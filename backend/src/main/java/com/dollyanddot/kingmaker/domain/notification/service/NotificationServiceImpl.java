package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationTmp;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationResDto;
import com.dollyanddot.kingmaker.domain.notification.exception.GetNotificationException;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTmpRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService{
    private final NotificationRepository notificationRepository;
    private final NotificationTmpRepository notificationTmpRepository;
    private final MemberRepository memberRepository;

    //발송 전 알림 보낸 후, 발송된 알림 테이블로 데이터 이동
    @Override
    public void sendNotification() {
        //notification_tmp에서 발송해야 하는 알림 목록 가져오기->발송->notification에 저장 후 notification_tmp에서 삭제
        LocalDateTime time=LocalDateTime.now();
        List<NotificationTmp> list=notificationTmpRepository.getNotificationTmpsBySendTimeLessThanEqual(time);
        //발송 로직
        for(NotificationTmp nt:list){
            Notification n=Notification.builder()
                    .notificationType(nt.getNotificationType())
                    .message(nt.getMessage())
                    .member(nt.getMember())
                    .build();
            notificationRepository.save(n);
        }
        notificationTmpRepository.deleteNotificationTmpsBySendTimeLessThanEqual(time);
    }

    @Override
    public List<Notification> getNotification(Long memberId) throws GetNotificationException {
        if(memberRepository.findMemberByMemberId(memberId).isEmpty()) throw new GetNotificationException();
        return notificationRepository.getNotificationsByMember_MemberId(memberId);
    }


}
