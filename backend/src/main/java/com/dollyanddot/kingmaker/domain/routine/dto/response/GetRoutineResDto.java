package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.RoutineDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class GetRoutineResDto {

  private Long memberRoutineId;
  private RoutineDto routine;
  private boolean achievedYn;

  public static GetRoutineResDto of(MemberRoutine memberRoutine, Routine routine){

    return GetRoutineResDto.builder()
        .memberRoutineId(memberRoutine.getId())
        .routine(RoutineDto.from(routine))
        .achievedYn(memberRoutine.isAchievedYn())
        .build();
  }
}
