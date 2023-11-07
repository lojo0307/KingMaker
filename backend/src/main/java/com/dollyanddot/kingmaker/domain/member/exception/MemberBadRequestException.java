package com.dollyanddot.kingmaker.domain.member.exception;

import com.dollyanddot.kingmaker.global.exception.domain.BadRequestException;

public class MemberBadRequestException extends BadRequestException {
    public MemberBadRequestException() {super("700", "잘못된 사용자 요청입니다");}
}
