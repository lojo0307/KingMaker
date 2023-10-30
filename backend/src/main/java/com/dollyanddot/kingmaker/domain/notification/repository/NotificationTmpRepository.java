package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.notification.domain.NotificationTmp;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

public interface NotificationTmpRepository extends JpaRepository<NotificationTmp,Long> {
    List<NotificationTmp> getNotificationTmpsBySendTimeLessThanEqual(LocalDateTime time);

    @Transactional
    void deleteNotificationTmpsBySendTimeLessThanEqual(LocalDateTime time);
}
