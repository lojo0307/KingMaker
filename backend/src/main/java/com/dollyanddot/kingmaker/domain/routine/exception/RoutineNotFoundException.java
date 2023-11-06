package com.dollyanddot.kingmaker.domain.routine.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;
import lombok.Getter;

@Getter
public class RoutineNotFoundException extends NotFoundException {

  private static final String code = "904";
  private static final String message = "루틴을 찾을 수 없습니다.";

  public RoutineNotFoundException() {
    super(code, message);
  }
}
