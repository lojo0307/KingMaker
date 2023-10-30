package com.dollyanddot.kingmaker.domain.notification.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity(name="notification_type")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationType {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int notificationTypeId;

    @Column(nullable=false)
    @Enumerated(EnumType.STRING)
    private Type type;
}
