package com.dollyanddot.kingmaker.domain.notification.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationSettingUpdateReqDto {
    Long memberId;
    int notificationTypeId;
}
