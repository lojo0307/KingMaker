package com.dollyanddot.kingmaker.domain.notification.domain;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity(name="notification_tmp")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationTmp {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long notificationTmpId;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="member_id",nullable=false)
    private Member member;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="notification_type_id",nullable=false)
    private NotificationType notificationType;

    @Column(nullable=false,length=256)
    private String message;

    @OneToOne(fetch = FetchType.LAZY)
    @OnDelete(action=OnDeleteAction.CASCADE)
    @JoinColumn(name="todo_id",nullable=true)
    private Todo todo;

    @OneToOne(fetch = FetchType.LAZY)
    @OnDelete(action=OnDeleteAction.CASCADE)
    @JoinColumn(name="member_routine_id",nullable=true)
    private MemberRoutine memberRoutine;

    @Column(name="send_time",nullable=false)
    private LocalDateTime sendTime;
}
