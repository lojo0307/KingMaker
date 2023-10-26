package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.dto.MemberRoutineDto;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class GetDailyRoutinesResDto {

  private List<MemberRoutineDto> dailyRoutines;

  public static GetDailyRoutinesResDto from(List<MemberRoutine> memberRoutines){
    return GetDailyRoutinesResDto.builder()
        .dailyRoutines(memberRoutines.stream()
            .map(MemberRoutineDto::from)
            .collect(Collectors.toList()))
        .build();
  }
}
