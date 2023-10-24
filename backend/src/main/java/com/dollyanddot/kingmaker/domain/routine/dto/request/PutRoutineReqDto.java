package com.dollyanddot.kingmaker.domain.routine.dto.request;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PutRoutineReqDto {

  private Long routineRegistrationId;
  private Long categoryId;
  private String period;
  private String routineNm;
  private boolean importantYn;
  private String routineDetail;
  private LocalDateTime startAt;
  private LocalDateTime endAt;
}
