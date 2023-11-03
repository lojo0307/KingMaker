package com.dollyanddot.kingmaker.domain.kingdom.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class KingdomNotFoundException extends NotFoundException {

    //TODO: code 및 msg 정하기
    public KingdomNotFoundException() {
        super("1005", "왕국을 찾을 수 없습니다.");
    }

}
