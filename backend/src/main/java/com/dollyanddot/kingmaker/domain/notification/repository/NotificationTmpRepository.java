package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.notification.domain.NotificationTmp;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface NotificationTmpRepository extends JpaRepository<NotificationTmp,Long> {
    List<NotificationTmp> getNotificationTmpsBySendTimeLessThanEqual(LocalDateTime time);

    void deleteNotificationTmpsBySendTimeLessThanEqual(LocalDateTime time);
}
