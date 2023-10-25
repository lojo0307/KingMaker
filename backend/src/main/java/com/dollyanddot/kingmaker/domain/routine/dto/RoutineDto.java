package com.dollyanddot.kingmaker.domain.routine.dto;

import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class RoutineDto {

  private Long routineId;
  private CategoryDto category;
  private String routineNm;
  private String routineDetail;
  private String period;
  private boolean importantYn;
  private LocalDateTime startAt;
  private LocalDateTime endAt;

  public static RoutineDto from(Routine routine){
    return RoutineDto.builder()
        .routineId(routine.getId())
        .category(CategoryDto.from(routine.getCategory()))
        .routineNm(routine.getName())
        .routineDetail(routine.getDetail())
        .period(routine.getPeriod())
        .importantYn(routine.isImportantYn())
        .startAt(routine.getStartAt())
        .endAt(routine.getEndAt())
        .build();
  }
}
