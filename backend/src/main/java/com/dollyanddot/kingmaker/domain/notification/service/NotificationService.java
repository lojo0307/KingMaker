package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;

import java.util.List;

public interface NotificationService {
    void sendNotification();

    List<Notification> getNotification(Long memberId);
}
