package com.dollyanddot.kingmaker.domain.reward.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class MemberRewardNotFoundException extends NotFoundException {
    public MemberRewardNotFoundException() {
        super("1204", "멤버_업적을 찾을 수 없습니다.");
    }
}
