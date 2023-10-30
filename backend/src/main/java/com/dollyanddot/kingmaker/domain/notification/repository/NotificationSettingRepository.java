package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationSetting;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationSettingRepository extends JpaRepository<NotificationSetting, Long> {

    List<NotificationSetting> findNotificationSettingsByMember(Member member);
}
