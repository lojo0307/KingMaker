package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import static com.dollyanddot.kingmaker.domain.notification.domain.QNotificationTmp.notificationTmp;

@RequiredArgsConstructor
public class NotificationTmpRepositoryCustomImpl implements NotificationTmpRepositoryCustom{
    private final JPAQueryFactory queryFactory;

    public void updateTodoNotification(Todo todo){
        queryFactory
                .update(notificationTmp)
                .set(notificationTmp.sendTime,todo.getStartAt().minusHours(1))
                .set(notificationTmp.message,"Your majesty, "+todo.getTodoNm()+" 시작 한 시간 전입니다.")
                .where(notificationTmp.todo.todoId.eq(todo.getTodoId()))
                .execute();
        return;
    }
}
