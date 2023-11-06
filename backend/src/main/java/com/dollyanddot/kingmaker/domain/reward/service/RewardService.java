package com.dollyanddot.kingmaker.domain.reward.service;

import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardInfoDto;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import com.dollyanddot.kingmaker.domain.reward.repository.MemberRewardRepository;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RewardService {
    private final CalendarRepository calendarRepository;
    private final MemberRepository memberRepository;
    private final RewardRepository rewardRepository;
    private final MemberRewardRepository memberRewardRepository;
    //TODO: 전 달 성취율 100퍼센트인 멤버들에게 업적 일괄 적용-달마다 취득
    void getMonthlyBrandReputation(int year,int month){
        //그 달의 reward를 먼저 reward 테이블에 추가
        Reward reward=rewardRepository.save(Reward.builder()
                .rewardNm(year+"년 "+month+"월 국가 브랜드 평판 S")
                .rewardCond(year+"년 "+month+"월 달성률 100%")
                .rewardMsg("몬스터로부터 안전함을 인정받아 포브스 선정 국가 브랜드 평판 S에 선정되었습니다.")
                .build());
        //등록한 일정이 하나라도 있는 멤버들의 id를 조회하는 리스트
        List<Long> rewardList=calendarRepository.getMonthlyPlanExistCheck(year,month);
        //미달성한 할일이 있으면 리워드 명단에서 제외할 때 쓰는 리스트
        List<Long> undoneList=calendarRepository.getUndonePlanByMonth(year,month);
        rewardList.removeAll(undoneList);
//        List<Member> allMemberList=memberRepository.findAll();
//        //리워드 못 받는 나머지 멤버들
//        List<Long> restList=allMemberList.stream().map(member->member.getMemberId()).collect(Collectors.toList());
//        restList.removeAll(rewardList);
//        RewardInfoDto rewardInfoDto = RewardInfoDto.from(14,
//                year+"년 "+month+"월 국가 브랜드 평판 S",
//                "월 달성률 100%",
//                "몬스터로부터 안전함을 인정받아 포브스 선정 국가 브랜드 평판 S에 선정되었습니다.");
//        RewardResDto rewardResDto=RewardResDto.from(1,rewardInfoDto);
        //db에 insert
        List<MemberReward> memberRewardList=new ArrayList<>();
        for(Long id:rewardList){
            MemberReward mr=MemberReward.builder()
                    .achievedYn(true)
                    .reward(reward)
                    .member(memberRepository.findById(id).get())
                    .build();
            memberRewardList.add(mr);
        }
//        for(Long id:restList){
//            MemberReward mr=MemberReward.builder()
//                    .achievedYn(false)
//                    .reward(reward)
//                    .member(memberRepository.findById(id).get())
//                    .build();
//            memberRewardList.add(mr);
//        }
        memberRewardRepository.saveAll(memberRewardList);
        return;
    }
}
