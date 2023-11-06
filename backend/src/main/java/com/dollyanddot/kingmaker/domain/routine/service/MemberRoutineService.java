package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardInfoDto;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetDailyRoutinesResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PatchRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.exception.MemberRoutineNotFoundException;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
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

  @Transactional
  public PatchRoutineResDto changeAchievedStatement(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();

    Long memberId = memberRoutine.getMember().getMemberId();

    boolean isAchieved = memberRoutine.toggleAchieved();

    if(memberRoutine.isAchievedYn()) {
      int changeLevel = kingdomService.changeCitizen(memberId, "plus");
      int rewardId = levelReward(changeLevel);
      if(rewardId!=0) {
        Reward reward = rewardRepository.findById(rewardId).orElseThrow();
        RewardInfoDto rewardInfoDto
            = RewardInfoDto.from(rewardId, reward.getRewardNm(),
            reward.getRewardCond(), reward.getRewardMsg());
        RewardResDto rewardResDto
            = RewardResDto.from(1, rewardInfoDto);

        return PatchRoutineResDto.from(isAchieved, rewardResDto);

      } else {
        return PatchRoutineResDto.from(isAchieved, null);
      }

    } else {
      kingdomService.changeCitizen(memberId,"minus");
      return PatchRoutineResDto.from(isAchieved, null);
    }
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

  private int levelReward(int level) {
    int rewardId = 0;
    switch (level) {
      case 3: rewardId = 5;
        break;
      case 6: rewardId = 6;
        break;
      case 9: rewardId = 7;
        break;
      default: rewardId = 0;
        break;
    }
    return rewardId;
  }
}
