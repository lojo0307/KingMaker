package com.dollyanddot.kingmaker.domain.routine.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PatchRoutineResDto {

  private boolean isAchieved;

  public static PatchRoutineResDto from(boolean isAchieved){
    return new PatchRoutineResDto(isAchieved);
  }
}
