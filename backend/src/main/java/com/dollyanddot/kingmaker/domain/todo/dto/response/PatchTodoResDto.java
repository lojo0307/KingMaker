package com.dollyanddot.kingmaker.domain.todo.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class PatchTodoResDto {

  private byte isAchieved;
  private List<RewardResDto> rewardResDtoList;

  public static PatchTodoResDto from(boolean isAchieved, List<RewardResDto> rewardResDtoList){
    return new PatchTodoResDto((byte) (isAchieved?1:0), rewardResDtoList);
  }
}
