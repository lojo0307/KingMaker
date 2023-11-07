package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class PatchRoutineResDto {

  private byte isAchieved;
  private List<RewardResDto> rewardResDtoList;

  public static PatchRoutineResDto from(boolean isAchieved, List<RewardResDto> rewardResDtoList){
    return new PatchRoutineResDto((byte) (isAchieved?1:0), rewardResDtoList);
  }
}
