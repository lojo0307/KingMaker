package com.dollyanddot.kingmaker.domain.notification.repository;

import com.dollyanddot.kingmaker.domain.notification.domain.NotificationTmp;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.swing.text.html.Option;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface NotificationTmpRepository extends JpaRepository<NotificationTmp,Long> {
    List<NotificationTmp> getNotificationTmpsBySendTimeLessThanEqual(LocalDateTime time);

    @Transactional
    void deleteNotificationTmpsBySendTimeLessThanEqual(LocalDateTime time);

    //일정이 바뀌었을 때, 예정된 알림도 수정하기 위한 메소드들
    Optional<NotificationTmp> findNotificationTmpByTodo_TodoId(Long todoId);

    Optional<NotificationTmp> findNotificationTmpByMemberRoutine_Id(Long id);
}
