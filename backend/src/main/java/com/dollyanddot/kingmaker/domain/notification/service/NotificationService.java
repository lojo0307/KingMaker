package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.notification.repository.NotificationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NotificationService {
    private final NotificationRepository notificationRepository;
}
