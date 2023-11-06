package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PatchRoutineResDto {

  private boolean isAchieved;
  private RewardResDto rewardResDto;

  public static PatchRoutineResDto from(boolean isAchieved, RewardResDto rewardResDto){
    return new PatchRoutineResDto(isAchieved, rewardResDto);
  }
}
