package com.dollyanddot.kingmaker.domain.auth.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class CredentialNotFoundException extends NotFoundException {

    public CredentialNotFoundException() {super("1604", "해당 OAuth2 인증 회원을 찾을 수 없습니다.");}
}
