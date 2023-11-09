package com.dollyanddot.kingmaker.domain.todo.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PostRoutineResDto;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class PostTodoResDto {
  private List<RewardResDto> rewardResDtoList;

  public static PostTodoResDto from(List<RewardResDto> rewardResDtoList) {
    return new PostTodoResDto(rewardResDtoList);
  }
}
