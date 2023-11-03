package com.dollyanddot.kingmaker.domain.member.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class MemberNotFoundException extends NotFoundException {

    //TODO: code 및 msg 정하기
    public MemberNotFoundException() {
        super("1004", "사용자를 찾을 수 없습니다.");
    }

}
