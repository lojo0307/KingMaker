package com.dollyanddot.kingmaker.domain.notification.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class NotificationSettingDto {

    private Long notificationTypeId;
    private byte activatedYn;

}
