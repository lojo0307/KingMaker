package com.dollyanddot.kingmaker.domain.member.dto.request;

import com.dollyanddot.kingmaker.domain.notification.dto.request.NotificationSettingReqDto;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class NotificationFirstSettingReqDto {
    Long memberId;
    List<NotificationSettingReqDto> setting;
}
