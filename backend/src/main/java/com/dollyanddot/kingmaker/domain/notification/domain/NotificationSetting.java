package com.dollyanddot.kingmaker.domain.notification.domain;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;

@Data
@Entity(name="notification_setting")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationSetting {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long notificationSettingId;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="member_id",nullable=false)
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="notification_type_id",nullable=false)
    private NotificationType notificationType;

    @Column(nullable=false, columnDefinition = "TINYINT(1)")
    private boolean achievedYn;
}
