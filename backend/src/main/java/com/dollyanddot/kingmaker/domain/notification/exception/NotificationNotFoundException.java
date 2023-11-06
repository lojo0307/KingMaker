package com.dollyanddot.kingmaker.domain.notification.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class NotificationNotFoundException extends NotFoundException {

    public NotificationNotFoundException() {
        super("804", "알림을 찾을 수 없습니다.");
    }

}
