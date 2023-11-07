package com.dollyanddot.kingmaker.domain.reward.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class RewardNotFoundException extends NotFoundException {
    public RewardNotFoundException() {
        super("1104", "업적을 찾을 수 없습니다.");
    }
}
