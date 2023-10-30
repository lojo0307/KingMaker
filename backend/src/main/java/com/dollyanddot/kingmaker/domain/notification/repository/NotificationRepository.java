package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification,Long> {
    List<Notification> getNotificationsByMember_MemberId(Long memberId);
}
