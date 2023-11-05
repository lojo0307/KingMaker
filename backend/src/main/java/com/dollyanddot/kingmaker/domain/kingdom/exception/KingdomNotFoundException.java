package com.dollyanddot.kingmaker.domain.kingdom.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class KingdomNotFoundException extends NotFoundException {

    public KingdomNotFoundException() {
        super("604", "왕국을 찾을 수 없습니다.");
    }

}
