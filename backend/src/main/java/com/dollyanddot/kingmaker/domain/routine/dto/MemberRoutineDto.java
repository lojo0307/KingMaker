package com.dollyanddot.kingmaker.domain.routine.dto;

import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class MemberRoutineDto {

  private Long memberRoutineId;
  private RoutineDto routine;
  private boolean achievedYn;
  private int monsterCd;

  public static MemberRoutineDto from(MemberRoutine memberRoutine){
    return MemberRoutineDto.builder()
        .memberRoutineId(memberRoutine.getId())
        .routine(RoutineDto.from(memberRoutine.getRoutine()))
        .achievedYn(memberRoutine.isAchievedYn())
        .monsterCd(memberRoutine.getMonsterCd())
        .build();
  }
}
