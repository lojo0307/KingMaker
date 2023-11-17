package com.dollyanddot.kingmaker.global.exception.domain;

public class NotFoundException extends BusinessException {

  public NotFoundException(String code, String message) {
    super(code, message);
  }
}
