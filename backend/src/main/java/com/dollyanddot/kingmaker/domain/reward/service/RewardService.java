package com.dollyanddot.kingmaker.domain.reward.service;

import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.dto.response.RewardListResDto;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardInfoDto;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import com.dollyanddot.kingmaker.domain.reward.exception.MemberRewardNotFoundException;
import com.dollyanddot.kingmaker.domain.reward.exception.RewardNotFoundException;
import com.dollyanddot.kingmaker.domain.reward.repository.MemberRewardRepository;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import java.util.Comparator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class RewardService {
    private final CalendarRepository calendarRepository;
    private final MemberRepository memberRepository;
    private final RewardRepository rewardRepository;
    private final MemberRewardRepository memberRewardRepository;
    private final TodoRepository todoRepository;
    private final MemberRoutineRepository memberRoutineRepository;
    private final CategoryRepository categoryRepository;

    //TODO: 전 달 성취율 100퍼센트인 멤버들에게 업적 일괄 적용-달마다 취득
    public void getMonthlyBrandReputation(int year,int month){
        //그 달의 reward를 먼저 reward 테이블에 추가
        Reward reward=rewardRepository.save(Reward.builder()
                .rewardNm(year+"년 "+month+"월 국가 브랜드 평판 S")
                .rewardCond(year+"년 "+month+"월 달성률 100%")
                .rewardMsg("몬스터로부터 안전함을 인정받아 포브스 선정 국가 브랜드 평판 S에 선정되었습니다.")
                .hidden(true)
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

    public List<RewardListResDto> getRewardList(long memberId) {
        long rewardCnt = rewardRepository.count();
        Member member = memberRepository.findById(memberId).orElseThrow(() -> new MemberNotFoundException());

        List<RewardListResDto> response = new ArrayList<>();
        for (int i = 1; i <= rewardCnt; i++) {
            Reward reward = rewardRepository.findById(i).get();
            MemberReward memberReward = memberRewardRepository.findMemberRewardByMemberAndReward(member, reward).orElseThrow(() -> new MemberRewardNotFoundException());

            int percent = (int)(memberRewardRepository.countByRewardAndAchievedYn(reward, true) * 100 / memberRewardRepository.countByReward(reward));
            response.add(RewardListResDto.builder()
                    .rewardNm(reward.getRewardNm())
                    .rewardCond(reward.getRewardCond())
                    .modifiedAt(memberReward.getModifiedAt())
                    .isAchieved(memberReward.isAchievedYn())
                    .rewardPercent(percent)
                    .rewardId(reward.getRewardId())
                    .build());
        }

        response.sort(Comparator
                .comparing(RewardListResDto::isAchieved, Comparator.reverseOrder())
                .thenComparing(RewardListResDto::getModifiedAt, Comparator.reverseOrder()));

        return response;
    }

    //TODO: 할 일 첫 달성시 "이게 내가 지닌 힘?" 업적 취득
    RewardResDto isThisMyPower(Long memberId){
        MemberReward mw=memberRewardRepository.findMemberRewardByMember_MemberIdAndReward_RewardId(memberId,11).orElseThrow();
        if(mw.isAchievedYn()){
            return RewardResDto.from(0,null);
        }
        Reward reward=rewardRepository.findById(11).get();
        memberRewardRepository.achieveMemberReward(memberId,11);
        RewardInfoDto rewardInfoDto=RewardInfoDto.from(11, reward.getRewardNm(), reward.getRewardCond(), reward.getRewardMsg());
        RewardResDto rewardResDto=RewardResDto.from(1,rewardInfoDto);
        //중요도 상 이면 "오잉?할 일의 상태가?" 까지 호출
        return rewardResDto;
    }

    //TODO: 카테고리별 하나 이상씩 달성시 "알록달록한 세상" 업적 취득
    public RewardResDto colorfulWorld(Long memberId){
        MemberReward mw=memberRewardRepository.findMemberRewardByMember_MemberIdAndReward_RewardId(memberId,8).orElseThrow();
        if(mw.isAchievedYn()){
            return RewardResDto.from(0,null);
        }
        List<Long> todoCategories=todoRepository.countCategoryId(memberId);
        List<Long> mrCategories=memberRoutineRepository.countCategoryId(memberId);
        Set<Long> categorySet=new HashSet<>();
        categorySet.addAll(todoCategories);
        categorySet.addAll(mrCategories);
        if(categorySet.size()==categoryRepository.count()){
            Reward reward=rewardRepository.findById(8).orElseThrow();
            RewardInfoDto rewardInfoDto=RewardInfoDto.from(8, reward.getRewardNm(), reward.getRewardCond(), reward.getRewardMsg());
            RewardResDto rewardResDto=RewardResDto.from(1,rewardInfoDto);
            return rewardResDto;
        }
        else{
            return RewardResDto.from(0,null);
        }
    }

    public void getMonsterPark(){
        Reward reward=rewardRepository.findById(14).orElseThrow(()->new RewardNotFoundException());
        List<Member> rewardList=calendarRepository.getMonsterParkMemberList();
        for(Member m:rewardList){
            //업적 없으면 업데이트
            MemberReward mr=memberRewardRepository.findMemberRewardByMemberAndReward(m,reward).orElseThrow(()->new MemberRewardNotFoundException());
            if(!mr.isAchievedYn()){memberRewardRepository.achieveMemberReward(m.getMemberId(),14);}
        }
        return;
    }

    public void getUndonePlanAllCnt50() {
        Reward reward = rewardRepository.findById(1).orElseThrow(RewardNotFoundException::new);
        List<Member> memberList = calendarRepository.getUndonePlanCntMemberList(50);
        for(Member member : memberList) {
            memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new);

            MemberReward memberReward = memberRewardRepository.findMemberRewardByMemberAndReward(member, reward)
                .orElseThrow(MemberRewardNotFoundException::new);

            //아직 미달성한 업적이면
            if(!memberReward.isAchievedYn()) {
                memberRewardRepository.achieveMemberReward(member.getMemberId(),1);
            }
        }
    }
    public void getUndonePlanAllCnt100() {
        Reward reward = rewardRepository.findById(2).orElseThrow(RewardNotFoundException::new);
        List<Member> memberList = calendarRepository.getUndonePlanCntMemberList(100);
        for(Member member : memberList) {
            memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new);

            MemberReward memberReward = memberRewardRepository.findMemberRewardByMemberAndReward(member, reward)
                .orElseThrow(MemberRewardNotFoundException::new);

            //아직 미달성한 업적이면
            if(!memberReward.isAchievedYn()) {
                memberRewardRepository.achieveMemberReward(member.getMemberId(),2);
            }
        }
    }

    public void getUndonePlanAllCnt(int rewardId, CountPlanDto c) {
        Reward reward = rewardRepository.findById(rewardId).orElseThrow(RewardNotFoundException::new);
        Member member = memberRepository.findById(c.getMemberId()).orElseThrow(MemberNotFoundException::new);
        MemberReward memberReward = memberRewardRepository.findMemberRewardByMemberAndReward(member, reward)
            .orElseThrow(MemberRewardNotFoundException::new);

        //아직 미달성한 업적이면
        if(!memberReward.isAchievedYn()) {
            memberRewardRepository.achieveMemberReward(member.getMemberId(),rewardId);
        }
    }
}
