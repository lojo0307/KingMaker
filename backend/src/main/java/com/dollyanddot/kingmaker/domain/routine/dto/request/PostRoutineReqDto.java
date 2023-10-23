package com.dollyanddot.kingmaker.domain.routine.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PostRoutineReqDto {

  private Long memberId;
  private Long categoryId;
  private String period;

}
