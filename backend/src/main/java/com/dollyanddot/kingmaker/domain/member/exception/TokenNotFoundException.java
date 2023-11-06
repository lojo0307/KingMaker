package com.dollyanddot.kingmaker.domain.member.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class TokenNotFoundException extends NotFoundException {

    public TokenNotFoundException() {
        super("1204", "사용자에 해당하는 토큰을 찾을 수 없습니다.");
    }

}
