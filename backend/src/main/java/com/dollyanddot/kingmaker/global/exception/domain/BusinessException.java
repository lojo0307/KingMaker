package com.dollyanddot.kingmaker.global.exception.domain;

import lombok.Getter;

@Getter
public class BusinessException extends RuntimeException {

  private String code;

  public BusinessException(String code, String message) {
    super(message);
    this.code = code;
  }
}
