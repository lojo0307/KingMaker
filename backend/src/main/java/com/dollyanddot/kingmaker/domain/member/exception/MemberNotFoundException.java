package com.dollyanddot.kingmaker.domain.member.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class MemberNotFoundException extends NotFoundException {

    public MemberNotFoundException() {
        super("704", "사용자를 찾을 수 없습니다.");
    }

}
