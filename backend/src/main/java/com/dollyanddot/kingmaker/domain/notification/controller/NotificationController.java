package com.dollyanddot.kingmaker.domain.notification.controller;

import com.dollyanddot.kingmaker.domain.notification.dto.request.NotificationSettingUpdateReqDto;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationSettingResDto;
import com.dollyanddot.kingmaker.domain.notification.service.NotificationService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/notification")
public class NotificationController {
    private final NotificationService notificationService;

    @GetMapping("{memberId}")
    public EnvelopeResponse<List<NotificationResDto>> getNotification(@PathVariable Long memberId){
        List<NotificationResDto> list=notificationService.getNotification(memberId)
                .stream()
                .map(m->new NotificationResDto(m.getMessage(),m.getNotificationType().getNotificationTypeId(),m.getNotificationId()))
                .collect(Collectors.toList());
        return EnvelopeResponse.<List<NotificationResDto>>builder()
                .data(list)
                .build();
    }

    @DeleteMapping("{notificationId}")
    public EnvelopeResponse<Void> deleteNotification(@PathVariable Long notificationId){
        notificationService.deleteNotification(notificationId);
        return EnvelopeResponse.<Void>builder().build();
    }

    @PatchMapping("setting")
    public EnvelopeResponse<Void> updateNotificationSetting(@RequestBody NotificationSettingUpdateReqDto req){
        notificationService.notificationSettingToggle(req.getMemberId(), req.getNotificationTypeId());
        return EnvelopeResponse.<Void>builder().build();
    }

    @GetMapping("/notification/{memberId}")
    EnvelopeResponse<?> getNotificationSetting(@PathVariable Long memberId) {
        List<NotificationSettingResDto> notificationSettingDtoList
            = notificationService.getNotificationSetting(memberId);
        return EnvelopeResponse.builder()
            .data(notificationSettingDtoList)
            .build();
    }
}
