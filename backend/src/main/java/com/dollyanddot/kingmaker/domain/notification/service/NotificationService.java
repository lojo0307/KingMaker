package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;

import java.util.List;

public interface NotificationService {
    void sendNotification();

    List<Notification> getNotification(Long memberId);

    void deleteNotification(Long notificationId);

    void sendMorningNotification();

    void sendEveningNotification();

    void generateTodoNotificationTmp(Todo todo);

//    void generateMemberRoutineNotificationTmp(MemberRoutine memberRoutine);

    void updateTodoNotification(Todo todo);
}
