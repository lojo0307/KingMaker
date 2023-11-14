package com.dollyanddot.kingmaker.domain.member.service;

import com.dollyanddot.kingmaker.domain.auth.domain.Credential;
import com.dollyanddot.kingmaker.domain.auth.domain.Role;
import com.dollyanddot.kingmaker.domain.auth.exception.CredentialNotFoundException;
import com.dollyanddot.kingmaker.domain.auth.repository.CredentialRepository;
import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import com.dollyanddot.kingmaker.domain.kingdom.repository.KingdomRepository;
import com.dollyanddot.kingmaker.domain.member.domain.FcmToken;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.dto.request.NicknameReqDto;
import com.dollyanddot.kingmaker.domain.member.dto.request.SignUpReqDto;
import com.dollyanddot.kingmaker.domain.auth.dto.LoginResDto;
import com.dollyanddot.kingmaker.domain.member.dto.response.SignUpResDto;
import com.dollyanddot.kingmaker.domain.member.exception.MemberBadRequestException;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.FcmTokenRepository;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationSetting;
import com.dollyanddot.kingmaker.domain.notification.dto.request.NotificationSettingReqDto;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationSettingRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTypeRepository;
import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardInfoDto;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import com.dollyanddot.kingmaker.domain.reward.exception.RewardNotFoundException;
import com.dollyanddot.kingmaker.domain.reward.repository.MemberRewardRepository;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final FcmTokenRepository fcmTokenRepository;
    private final NotificationSettingRepository notificationSettingRepository;
    private final NotificationTypeRepository notificationTypeRepository;
    private final CredentialRepository credentialRepository;
    private final KingdomRepository kingdomRepository;
    private final RewardRepository rewardRepository;
    private final MemberRewardRepository memberRewardRepository;

    public SignUpResDto signUp(long credentialId, SignUpReqDto signUpReqDto) {
        Credential credential = credentialRepository.findById(credentialId).orElseThrow(() -> new CredentialNotFoundException());
        if (credential .getRole().equals(Role.USER)) throw new MemberBadRequestException();

        Kingdom kingdom = Kingdom.builder()
                .level(1)
                .kingdomNm(signUpReqDto.getKingdomName())
                .citizen(0).build();

        Member member = Member.builder()
                .nickname(signUpReqDto.getNickname())
                .credential(credential)
                .kingdom(kingdom)
                .createdAt(LocalDateTime.now())
                .gender(signUpReqDto.getGender())
                .build();

        kingdomRepository.save(kingdom);
        memberRepository.save(member);

        credential.setRole(Role.USER);
        credentialRepository.save(credential);

        long rewardCnt = rewardRepository.count();
        for (int i = 1; i <= rewardCnt; i++) {
            MemberReward memberReward = MemberReward.builder()
                    .member(member)
                    .reward(rewardRepository.findById(i).orElseThrow(() -> new RewardNotFoundException()))
                    .achievedYn(i == 10 ? true : false)
                    .build();

            memberRewardRepository.save(memberReward);
        }

        Reward reward = rewardRepository.findById(10).orElseThrow(() -> new RewardNotFoundException());

        return SignUpResDto.builder()
                .memberId(member.getMemberId())
                .nickname(member.getNickname())
                .gender(member.getGender())
                .email(credential.getEmail())
                .provider(credential.getProvider())
                .rewardResDto(RewardResDto.builder().isRewardAchieved(1).rewardInfoDto(
                        RewardInfoDto.builder().rewardNm(reward.getRewardNm()).rewardId(reward.getRewardId()).rewardCond(reward.getRewardCond()).rewardMsg(reward.getRewardMsg()).build()
                ).build())
                .build();
    }

    public void withDraw(long credentialId) {
        Credential credential = credentialRepository.findById(credentialId).orElseThrow(() -> new CredentialNotFoundException());
        Member member = memberRepository.findByCredential(credential).orElseThrow(() -> new MemberNotFoundException());
        memberRepository.delete(member);
    }

    @Transactional
    public void updateNickname(NicknameReqDto nicknameDto) {
        Member member
                = memberRepository.findById(nicknameDto.getMemberId()).orElseThrow(
                    () -> new MemberNotFoundException());

        member.update(nicknameDto.getNickname());
    }

    //TODO: 회원가입/로그인 시 사용자의 기기로부터 FCM 토큰 입력받는 함수
    public void getFcmToken(Long memberId, String token) {
        //이미 있을 경우 갱신
        Optional<FcmToken> existingToken = fcmTokenRepository.findFcmTokenByToken(token);
        if (existingToken.isPresent()) {
            System.out.println("있음");
            fcmTokenRepository.updateFcmTokenMember(memberId, token);
        }
        //없으면 새로 등록
        FcmToken newToken = FcmToken.builder()
                .token(token)
                .member(memberRepository.findById(memberId).orElseThrow(()->new MemberNotFoundException()))
                .build();
        List<String> tokenContainer=new ArrayList<>();
        tokenContainer.add(token);
        FirebaseMessaging messaging = FirebaseMessaging.getInstance();
        try{
            messaging.subscribeToTopic(tokenContainer,"MORNING");
            messaging.subscribeToTopic(tokenContainer,"TODO");
            messaging.subscribeToTopic(tokenContainer,"ROUTINE");
            messaging.subscribeToTopic(tokenContainer,"EVENING");
        }catch (FirebaseMessagingException e){
            e.printStackTrace();
        }
        fcmTokenRepository.save(newToken);
    }

    //TODO: 로그아웃 시 기기의 FCM 토큰 삭제: 이 때 토픽 매핑도 삭제해야 함
    @Transactional
    public void deleteFcmToken(String token) {
        //토픽마다 구독 취소
        List<String> tokenContainer=new ArrayList<>();
        tokenContainer.add(token);
        FirebaseMessaging messaging = FirebaseMessaging.getInstance();
        try {
            messaging.unsubscribeFromTopic(tokenContainer, "MORNING");
            messaging.unsubscribeFromTopic(tokenContainer, "TODO");
            messaging.unsubscribeFromTopic(tokenContainer, "ROUTINE");
            messaging.unsubscribeFromTopic(tokenContainer, "EVENING");
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }
        //DB에서 토큰 삭제
        fcmTokenRepository.deleteFcmTokensByToken(token);
    }
    
    //TODO: 회원가입 시 알림 최초 설정
    public void notificationFirstSetting(Long memberId, List<NotificationSettingReqDto> settingList){
        for(NotificationSettingReqDto dto:settingList){
            //설정 저장
            NotificationSetting ns=NotificationSetting.builder()
                    .member(memberRepository.findById(memberId).get())
                    .notificationType(notificationTypeRepository.findById(dto.getNotificationTypeId()).get())
                    .activatedYn(dto.isActivatedYn())
                    .build();
            notificationSettingRepository.save(ns);
            //fcm에서 알림 받기로 한 topic은 subscribe-fcm 토큰이 등록되어있을 경우
//            Optional<List<String>> tokenList=fcmTokenRepository.findTokensByMemberId(memberId);
//            if(tokenList.isEmpty())throw new RuntimeException();
//            if(dto.isActivatedYn()){
//                String topic=notificationTypeRepository.findById(dto.getNotificationTypeId()).get().getType().name();
//                try{
//                    FirebaseMessaging.getInstance().subscribeToTopic(tokenList.get(), topic);
//                }catch(FirebaseMessagingException e){
//                    e.printStackTrace();
//                }
//            }
        }
    }

    public LoginResDto getMemberInfo(long credentialId) {
        Credential credential = credentialRepository.findById(credentialId).orElseThrow(() -> new CredentialNotFoundException());
        Member member = memberRepository.findByCredential(credential).orElseThrow(() -> new MemberNotFoundException());

        return LoginResDto.builder()
                .memberId(member.getMemberId())
                .email(credential.getEmail())
                .gender(member.getGender())
                .nickname(member.getNickname())
                .provider(credential.getProvider())
                .build();
    }
}
