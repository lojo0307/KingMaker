package com.dollyanddot.kingmaker.domain.routine.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;
import lombok.Getter;

@Getter
public class MemberRoutineNotFoundException extends NotFoundException {

  private static final String code = "1104";
  private static final String message = "회원의 루틴을 찾을 수 없습니다.";


  public MemberRoutineNotFoundException() {
    super(code, message);
  }
}
