package com.dollyanddot.kingmaker.domain.member.service;

import com.dollyanddot.kingmaker.domain.member.domain.FcmToken;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.dto.NicknameDto;
import com.dollyanddot.kingmaker.domain.member.repository.FcmTokenRepository;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationSetting;
import com.dollyanddot.kingmaker.domain.notification.dto.request.NotificationSettingReqDto;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationSettingRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTypeRepository;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final FcmTokenRepository fcmTokenRepository;
    private final NotificationSettingRepository notificationSettingRepository;
    private final NotificationTypeRepository notificationTypeRepository;

    @Transactional
    public void updateNickname(NicknameDto nicknameDto) {
        Member member
                = memberRepository.findById(nicknameDto.getMemberId()).orElseThrow();

        member.update(nicknameDto.getNickname());
    }

    //TODO: 회원가입/로그인 시 사용자의 기기로부터 FCM 토큰 입력받는 함수
    public void getFcmToken(Long memberId, String token) {
        //이미 있을 경우 갱신
        Optional<FcmToken> existingToken = fcmTokenRepository.findFcmTokenByToken(token);
        if (existingToken.isPresent()) {
            fcmTokenRepository.updateFcmTokenMember(memberId, token);
        }
        //없으면 새로 등록
        FcmToken newToken = FcmToken.builder()
                .token(token)
                .member(memberRepository.findById(memberId).get())
                .build();
        fcmTokenRepository.save(newToken);
    }

    //TODO: 로그아웃 시 기기의 FCM 토큰 삭제: 이 때 토픽 매핑도 삭제해야 함
    public void deleteFcmToken(String token) {
        //토픽마다 구독 취소
        List<String> tokenContainer=new ArrayList<>();
        tokenContainer.add(token);
        try {
            FirebaseMessaging.getInstance().unsubscribeFromTopic(tokenContainer, "MORNING");
            FirebaseMessaging.getInstance().unsubscribeFromTopic(tokenContainer, "TODO");
            FirebaseMessaging.getInstance().unsubscribeFromTopic(tokenContainer, "ROUTINE");
            FirebaseMessaging.getInstance().unsubscribeFromTopic(tokenContainer, "EVENING");
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }
        //DB에서 토큰 삭제
        fcmTokenRepository.deleteFcmTokenByToken(token);
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
}
