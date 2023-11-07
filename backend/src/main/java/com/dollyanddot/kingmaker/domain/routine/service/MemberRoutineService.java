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
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberRoutineService {

  private final MemberRoutineRepository memberRoutineRepository;
  private final MemberRepository memberRepository;
  private final KingdomService kingdomService;
  private final RewardRepository rewardRepository;
  private final MemberRewardRepository memberRewardRepository;
  private final RewardService rewardService;
  private final TodoRepository todoRepository;
  private final RoutineRepository routineRepository;

  @Transactional
  public PatchRoutineResDto changeAchievedStatement(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();
    Routine routine = memberRoutine.getRoutine();
    Member member = memberRoutine.getMember();
    List<RewardResDto> rewardResDtoList = new ArrayList<>();

    Reward reward;

    //수행으로 인한 달성 여부 변경이 발생하기 전에 확인
    if (!memberRoutine.isAchievedYn()) {
      //4번 업적 달성 여부 확인 - 마지막 수행으로부터 30일 이상 지난 후 다시 수행을 한 경우
      reward = rewardRepository.findById(4).orElseThrow(RewardNotFoundException::new);

      if (!memberRewardRepository.findMemberRewardByMemberAndReward(member, reward)
          .orElseThrow(MemberRewardNotFoundException::new).isAchievedYn()) {

        LocalDateTime date1 = todoRepository.findMostRecentAchieved();
        LocalDateTime date2 = routineRepository.findMostRecentAchieved();
        LocalDateTime lastAchievedDate = null;

        if (date1 != null && date2 != null) {
          lastAchievedDate = date1.isAfter(date2) ? date1 : date2;
        } else if (date1 != null) {
          lastAchievedDate = date1;
        } else if (date2 != null) {
          lastAchievedDate = date2;
        } else {
          lastAchievedDate = LocalDateTime.now();
        }

        if (Math.abs(Period.between(lastAchievedDate.toLocalDate(), LocalDateTime.now().toLocalDate()).getDays()) >= 30) {
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
    }

    //수행으로 인한 달성 여부 변경이 발생
    boolean isAchieved = memberRoutine.toggleAchieved();
    //달성 시
    if (isAchieved) {

      //9번 업적 달성 여부 확인 - 중요도 상인 루틴 첫 수행 시
      if(routine.isImportantYn() && !memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(9).orElseThrow(RewardNotFoundException::new)).isAchievedYn()) {

        memberRewardRepository.achieveMemberReward(member.getMemberId(),9);
        reward=rewardRepository.findById(9).orElseThrow(RewardNotFoundException::new);
        rewardResDtoList.add(RewardResDto.builder()
                .rewardInfoDto(RewardInfoDto.from(
                        reward.getRewardId(),
                        reward.getRewardNm(),
                        reward.getRewardCond(),
                        reward.getRewardMsg()))
                .isRewardAchieved(1)
                .build());
      }

      //8번 업적 달성 여부 확인 - 카테고리 별 하나 이상씩 달성한 경우
      RewardResDto colorfulWorld=rewardService.colorfulWorld(member.getMemberId());
      if(colorfulWorld.getIsRewardAchieved()==1)
        rewardResDtoList.add(colorfulWorld);

      //11번 업적 달성 여부 확인 - 첫 몬스터 처치인 경우
      if(!memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(11).orElseThrow(RewardNotFoundException::new)).isAchievedYn()) {

          reward = rewardRepository.findById(11).orElseThrow(RewardNotFoundException::new);
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

      //백성 수 증가 및 레벨 변경
      int changeLevel = kingdomService.changeCitizen(member.getMemberId(), "plus");

      //5, 6, 7번 업적 수행 여부 확인 - 왕국 단계 재산정 및 해당되는 업적 번호(3단게/6단계/9단계)가 있는 경우
      int rewardId = kingdomService.levelReward(changeLevel);
      if(rewardId != 0 && !memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(rewardId).orElseThrow(RewardNotFoundException::new)).isAchievedYn()) {

          reward = rewardRepository.findById(rewardId).orElseThrow();

          MemberReward memberReward = memberRewardRepository.findByMemberAndReward(member, reward);
          rewardResDtoList.add(RewardResDto.builder()
              .rewardInfoDto(RewardInfoDto.from(
                  reward.getRewardId(),
                  reward.getRewardNm(),
                  reward.getRewardCond(),
                  reward.getRewardMsg()))
              .isRewardAchieved(!memberReward.isAchievedYn() && memberReward.achieveReward()? 1:0)
              .build());
      }

    } else {
      int originLevel = member.getKingdom().getLevel();

      //백성 수 다시 차감 및 레벨 변경
      int changeLevel = kingdomService.changeCitizen(member.getMemberId(), "minus");

      //TODO: 방금 수행함으로써 얻었던 리워드 다시 취소 해야 하는데...
    }

    if(rewardResDtoList.isEmpty())
      rewardResDtoList.add(RewardResDto.from( 0,null));

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
