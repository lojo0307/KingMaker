package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import org.springframework.data.jpa.repository.JpaRepository;

public class NotificationRepository extends JpaRepository<Notification,Long> {
}
