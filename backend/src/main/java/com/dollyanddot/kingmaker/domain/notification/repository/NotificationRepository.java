package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<Notification,Long> {
}
