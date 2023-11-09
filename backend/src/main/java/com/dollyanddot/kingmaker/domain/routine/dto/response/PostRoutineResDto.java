package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class PostRoutineResDto {

  private List<RewardResDto> rewardResDtoList;

  public static PostRoutineResDto from(List<RewardResDto> rewardResDtoList){
    return new PostRoutineResDto(rewardResDtoList);
  }
}
