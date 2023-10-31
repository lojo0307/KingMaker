package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationSetting;
import java.util.List;
import java.util.Optional;

import com.dollyanddot.kingmaker.domain.notification.domain.NotificationType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationSettingRepository extends JpaRepository<NotificationSetting, Long> {

    List<NotificationSetting> findNotificationSettingsByMember(Member member);

    Optional<NotificationSetting> findNotificationSettingByMember_MemberIdAndNotificationType_NotificationTypeId(Long memberId,int notificationTypeId);
}
