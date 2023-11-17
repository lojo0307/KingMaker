package com.dollyanddot.kingmaker.domain.notification.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class NotificationSettingNotFoundException extends NotFoundException {

    public NotificationSettingNotFoundException() {
        super("1504", "알림 설정을 찾을 수 없습니다.");
    }

}
