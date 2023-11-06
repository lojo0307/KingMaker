package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationSettingResDto;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;

import java.util.List;

public interface NotificationService {
    void sendNotification() throws Exception;

    List<Notification> getNotification(Long memberId);

    void deleteNotification(Long notificationId);

    void sendMorningNotification() throws Exception;

    void sendEveningNotification() throws Exception;

    void generateTodoNotificationTmp(Long todoId);

//    void generateMemberRoutineNotificationTmp(MemberRoutine memberRoutine);

    void updateTodoNotification(Long todoId);

    void notificationSettingToggle(Long memberId,int notificationTypeId);

//    //알림 초기 설정 함수
//    void notificationFirstSetting(Long memberId);

    List<NotificationSettingResDto> getNotificationSetting(Long memberId);
}
