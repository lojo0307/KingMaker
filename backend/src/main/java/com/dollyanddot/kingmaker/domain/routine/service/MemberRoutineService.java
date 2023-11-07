package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
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
import com.dollyanddot.kingmaker.domain.reward.service.RewardService;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetDailyRoutinesResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PatchRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.exception.MemberRoutineNotFoundException;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MemberRoutineService {

  private final MemberRoutineRepository memberRoutineRepository;
  private final MemberRepository memberRepository;
  private final KingdomService kingdomService;
  private final RewardRepository rewardRepository;
  private final MemberRewardRepository memberRewardRepository;
  private final RewardService rewardService;

  @Transactional
  public PatchRoutineResDto changeAchievedStatement(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();
    Routine routine=memberRoutine.getRoutine();
    Member member = memberRoutine.getMember();
    List<RewardResDto> rewardResDtoList=new ArrayList<>();
    boolean isAchieved = memberRoutine.toggleAchieved();
    Reward reward;
    //달성 시
    if (isAchieved) {
      //중요도 상인 루틴 첫 수행 시
      if(routine.isImportantYn()){
        MemberReward mr=memberRewardRepository.findMemberRewardByMember_MemberIdAndReward_RewardId(member.getMemberId(),9).orElseThrow(()->new MemberRewardNotFoundException());
        if(!mr.isAchievedYn()){
          //'업적 달성'으로 바꿈
          memberRewardRepository.achieveMemberReward(member.getMemberId(),9);
          reward=rewardRepository.findById(9).orElseThrow(()->new RewardNotFoundException());
          rewardResDtoList.add(RewardResDto.builder()
                  .rewardInfoDto(RewardInfoDto.from(
                          reward.getRewardId(),
                          reward.getRewardNm(),
                          reward.getRewardCond(),
                          reward.getRewardMsg()))
                  .isRewardAchieved(1)
                  .build());
        }
      }

      //카테고리 별 하나 이상씩 달성한 경우
      RewardResDto colorfulWorld=rewardService.colorfulWorld(member.getMemberId());
      if(colorfulWorld.getIsRewardAchieved()==1)rewardResDtoList.add(colorfulWorld);

      //백성 수 증가
      int changeLevel = kingdomService.changeCitizen(member.getMemberId(), "plus");

      //첫 몬스터 처치인 경우
      if(!memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(11).orElseThrow()).isAchievedYn()) {

          reward = rewardRepository.findById(11).orElseThrow();
          MemberReward memberReward = memberRewardRepository.findByMemberAndReward(memberRoutine.getMember(), reward);

          rewardResDtoList.add(RewardResDto.builder()
                .rewardInfoDto(RewardInfoDto.from(
                        reward.getRewardId(),
                        reward.getRewardNm(),
                        reward.getRewardCond(),
                        reward.getRewardMsg()))
                .isRewardAchieved(!memberReward.isAchievedYn() && memberReward.achieveReward()? 1:0)
                .build());
      }

      //왕국 단계 재산정 및 해당되는 업적 번호(3단게/6단계/9단계)가 있는 경우
      int rewardId = kingdomService.levelReward(changeLevel);

      //해당되는 업적이면
      if(rewardId != 0 && !memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(rewardId).orElseThrow()).isAchievedYn()) {

          reward = rewardRepository.findById(rewardId).orElseThrow();

          //업적 달성으로 변경
          MemberReward memberReward = memberRewardRepository.findByMemberAndReward(member, reward);
          RewardInfoDto rewardInfoDto
              = RewardInfoDto.from(rewardId, reward.getRewardNm(),
              reward.getRewardCond(), reward.getRewardMsg());
          RewardResDto rewardResDto
              = RewardResDto.from(!memberReward.isAchievedYn() && memberReward.achieveReward()? 1:0, rewardInfoDto);

          rewardResDtoList.add(rewardResDto);
      }

    } else {
      kingdomService.changeCitizen(member.getMemberId(), "minus");
    }
    if(rewardResDtoList.isEmpty())rewardResDtoList.add(RewardResDto.from(0,null));
    return PatchRoutineResDto.from(isAchieved, rewardResDtoList);
  }

  @Transactional(readOnly = true)
  public GetRoutineResDto getMemberRoutine(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow(
        MemberRoutineNotFoundException::new);

    Routine routine = memberRoutine.getRoutine();

    return GetRoutineResDto.of(memberRoutine, routine);
  }

  @Transactional(readOnly = true)
  public GetDailyRoutinesResDto getDailyRoutines(Long memberId, String dateStr) {

    Member member = memberRepository.findById(memberId).orElseThrow(MemberNotFoundException::new);

    return GetMemberRoutinesByDate(member, dateStr);
  }

  private GetDailyRoutinesResDto GetMemberRoutinesByDate(Member member, String dateStr) {

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    LocalDateTime date = LocalDateTime.parse(dateStr, formatter);

    List<MemberRoutine> memberRoutines = memberRoutineRepository.findAllByMemberAndDate(
        member, date);

    return GetDailyRoutinesResDto.from(memberRoutines);
  }

}
