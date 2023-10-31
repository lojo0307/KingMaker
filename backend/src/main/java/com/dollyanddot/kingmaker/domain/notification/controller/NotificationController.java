package com.dollyanddot.kingmaker.domain.notification.controller;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarAchieveAndSumResDto;
import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.dto.request.NotificationSettingReqDto;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;
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

    //1분마다 일정 알림 발송하기 위한 함수 테스트용
    @GetMapping("test")
    void sendTest(){
//        notificationService.sendNotification();
//        notificationService.sendMorningNotification();
        notificationService.sendEveningNotification();
        return;
    }

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
    public EnvelopeResponse<Void> updateNotificationSetting(@RequestBody NotificationSettingReqDto req){
        notificationService.notificationSettingToggle(req.getMemberId(), req.getNotificationTypeId());
        return EnvelopeResponse.<Void>builder().build();
    }
}
