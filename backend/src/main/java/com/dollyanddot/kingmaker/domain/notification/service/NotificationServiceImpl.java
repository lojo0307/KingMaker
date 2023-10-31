package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.member.domain.FcmToken;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.FcmTokenRepository;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationTmp;
import com.dollyanddot.kingmaker.domain.notification.exception.DeleteNotificationException;
import com.dollyanddot.kingmaker.domain.notification.exception.GetNotificationException;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTmpRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTypeRepository;
import com.google.firebase.FirebaseException;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService{
    private final NotificationRepository notificationRepository;
    private final NotificationTmpRepository notificationTmpRepository;
    private final MemberRepository memberRepository;
    private final CalendarRepository calendarRepository;
    private final NotificationTypeRepository notificationTypeRepository;
    private final FirebaseMessaging firebaseMessaging;
    private final FcmTokenRepository fcmTokenRepository;

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

    List<Message> generateMessageList(List<CountPlanDto> list,boolean isMorning){
        List<Message> messageList=new ArrayList<>();
        for(CountPlanDto t:list){
            Optional<List<FcmToken>> tokenList=fcmTokenRepository.findFcmTokensByMember_MemberId(t.getMemberId());
            if(tokenList.isEmpty())throw new RuntimeException();
            if(isMorning){
                for(FcmToken ft:tokenList.get()){
                    Message message=Message.builder()
                            .setToken(ft.getFcmToken())
                            .setTopic("MORNING")
                            .setNotification(com.google.firebase.messaging.Notification.builder()
                                    .setBody("Your majesty, 오늘 처리해야 하는 업무가 "+t.getCnt()+"건 있습니다.")
                                    .setTitle("아침 문안인사 드립니다.")
                                    .build())
                            .build();
                    messageList.add(message);
                }
            }else{
                for(FcmToken ft:tokenList.get()){
                    Message message=Message.builder()
                            .setToken(ft.getFcmToken())
                            .setTopic("EVENING")
                            .setNotification(com.google.firebase.messaging.Notification.builder()
                                    .setBody("Your majesty, 아직 처리하지 못한 업무가 "+t.getCnt()+"건 있습니다.")
                                    .setTitle("저녁 문안인사 드립니다.")
                                    .build())
                            .build();
                    messageList.add(message);
                }
            }
        }
        return messageList;
    }
    //오늘 해야 할 알림 개수 푸시 알림 발송 및 notification 테이블에 저장
    public void sendMorningNotification(){
        //각 멤버 별로 오늘 할 일+루틴 개수 반환해서 알림 생성 후 fcm으로 발송
        List<CountPlanDto> list=calendarRepository.getTodayPlan();
        List<Notification> notifications=new ArrayList<>();
        for(CountPlanDto t:list){
            Notification temp=Notification.builder()
                    .notificationType(notificationTypeRepository.findById(1).get())
                    .member(memberRepository.findById(t.getMemberId()).get())
                    .message("Your majesty, 오늘 처리해야 하는 업무가 "+t.getCnt()+"건 있습니다.")
                    .build();
        }
        //fcm 발송
        List<Message> messageList=generateMessageList(list,true);
        try{
            firebaseMessaging.sendAll(messageList);
        }catch(FirebaseMessagingException e){
            e.printStackTrace();
        }
        notificationRepository.saveAll(notifications);
    }

    public void sendEveningNotification(){
        //멤버 별로 오늘 완료하지 못한 일 개수 알림
        List<CountPlanDto> list=calendarRepository.getUndonePlan();
        List<Notification> notifications=new ArrayList<>();
        for(CountPlanDto t:list){
            Notification temp=Notification.builder()
                    .notificationType(notificationTypeRepository.findById(4).get())
                    .member(memberRepository.findById(t.getMemberId()).get())
                    .message("Your majesty, 아직 처리하지 못한 업무가 "+t.getCnt()+"건 있습니다.")
                    .build();
            notifications.add(temp);
        }
        List<Message> messageList=generateMessageList(list,false);
        try{
            firebaseMessaging.sendAll(messageList);
        }catch(FirebaseMessagingException e){
            e.printStackTrace();
        }
        notificationRepository.saveAll(notifications);
    }

    @Override
    public List<Notification> getNotification(Long memberId) throws GetNotificationException {
        if(memberRepository.findMemberByMemberId(memberId).isEmpty()) throw new GetNotificationException();
        return notificationRepository.getNotificationsByMember_MemberId(memberId);
    }

    @Override
    public void deleteNotification(Long notificationId) throws DeleteNotificationException {
        notificationRepository.deleteById(notificationId);
        return;
    }


}
