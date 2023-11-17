package com.dollyanddot.kingmaker.domain.auth.exception;

import com.dollyanddot.kingmaker.global.exception.domain.BadRequestException;

public class CredentialBadRequestException extends BadRequestException {
    public CredentialBadRequestException() { super("1600", "잘못된 인증 요청입니다."); }
}
