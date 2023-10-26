package com.dollyanddot.kingmaker.domain.todo.dto.request;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PutTodoReqDto {

  private Long todoId;
  private Long categoryId;
  private LocalDateTime startAt;
  private LocalDateTime endAt;
  private String todoNm;
  private String todoDetail;
  private String todoPlace;
  private boolean importantYn;
  private int monsterCd;
}
