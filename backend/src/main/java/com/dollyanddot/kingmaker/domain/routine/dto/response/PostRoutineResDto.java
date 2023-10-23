package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class PostRoutineResDto {

  private String routineName = "";

  public static PostRoutineResDto from(Routine routine){
    return PostRoutineResDto.builder()
        .routineName(routine.getRoutineName())
        .build();
  }
}
