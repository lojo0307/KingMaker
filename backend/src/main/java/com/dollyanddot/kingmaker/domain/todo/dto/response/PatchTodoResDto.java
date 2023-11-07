package com.dollyanddot.kingmaker.domain.todo.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PatchTodoResDto {

  private byte isAchieved;
  private RewardResDto rewardResDto;

  public static PatchTodoResDto from(boolean isAchieved, RewardResDto rewardResDto){
    return new PatchTodoResDto((byte) (isAchieved?1:0), rewardResDto);
  }
}
