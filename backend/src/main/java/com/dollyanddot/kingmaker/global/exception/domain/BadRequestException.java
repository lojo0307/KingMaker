package com.dollyanddot.kingmaker.global.exception.domain;

public class BadRequestException extends BusinessException{

  public BadRequestException(String code, String message) {
    super(code, message);
  }
}
