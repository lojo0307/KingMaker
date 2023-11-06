package com.dollyanddot.kingmaker.domain.notification.service;

import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.member.domain.FcmToken;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.exception.TokenNotFoundException;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.FcmTokenRepository;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.domain.Notification;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationSetting;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationTmp;
import com.dollyanddot.kingmaker.domain.notification.domain.Type;
import com.dollyanddot.kingmaker.domain.notification.dto.response.NotificationSettingResDto;
import com.dollyanddot.kingmaker.domain.notification.exception.*;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationSettingRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTmpRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationTypeRepository;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.exception.TodoNotFoundException;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.TopicManagementResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

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
    private final NotificationSettingRepository notificationSettingRepository;
    private final TodoRepository todoRepository;

    //발송 전 알림 보낸 후, 발송된 알림 테이블로 데이터 이동
    @Override
    public void sendNotification(){
        LocalDateTime time=LocalDateTime.now();
        List<NotificationTmp> list=notificationTmpRepository.getNotificationTmpsBySendTimeLessThanEqual(time);
        List<Notification> notificationList=new ArrayList<>();
        List<Message> messageList=new ArrayList<>();
        try{
            //notification_tmp에서 발송해야 하는 알림 목록 가져오기->발송->notification에 저장 후 notification_tmp에서 삭제
            //발송 로직
            for(NotificationTmp nt:list){
                Notification n=Notification.builder()
                        .notificationType(nt.getNotificationType())
                        .message(nt.getMessage())
                        .member(nt.getMember())
                        .build();
                notificationList.add(n);
                Optional<List<FcmToken>> fcmTokenList=fcmTokenRepository.findFcmTokensByMember_MemberId(nt.getMember().getMemberId());
                if(fcmTokenList.isPresent()){
                    for(FcmToken token:fcmTokenList.get()){
                        Message m=Message.builder()
                                .setToken(token.getToken())
                                .setTopic(Type.TODO.name())
                                .setNotification(com.google.firebase.messaging.Notification.builder()
                                        .setBody(nt.getMessage())
                                        .setTitle("일정 수행 전입니다.")
                                        .build())
                                .build();
                        messageList.add(m);
                    }
                }
            }
            notificationRepository.saveAll(notificationList);
            notificationTmpRepository.deleteNotificationTmpsBySendTimeLessThanEqual(time);
            if(messageList.isEmpty())return;
            //푸시 알림 발송
            firebaseMessaging.sendAll(messageList);
        }catch(FirebaseMessagingException e){
            e.printStackTrace();
        }
    }

    List<Message> generateMessageList(List<CountPlanDto> list,boolean isMorning){
        List<Message> messageList=new ArrayList<>();
        for(CountPlanDto t:list){
            Optional<List<FcmToken>> tokenList=fcmTokenRepository.findFcmTokensByMember_MemberId(t.getMemberId());
            if(tokenList.isEmpty())throw new TokenNotFoundException();
            if(isMorning){
                for(FcmToken ft:tokenList.get()){
                    Message message=Message.builder()
                            .setToken(ft.getToken())
                            .setTopic(Type.MORNING.name())
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
                            .setToken(ft.getToken())
                            .setTopic(Type.EVENING.name())
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
    @Override
    public void sendMorningNotification(){
        //각 멤버 별로 오늘 할 일+루틴 개수 반환해서 알림 생성 후 fcm으로 발송
        List<CountPlanDto> list=calendarRepository.getTodayPlan();
        List<Notification> notifications=new ArrayList<>();
        try{
            for(CountPlanDto t:list){
                Notification temp=Notification.builder()
                        .notificationType(notificationTypeRepository.findById(1).get())
                        .member(memberRepository.findById(t.getMemberId()).get())
                        .message("Your majesty, 오늘 처리해야 하는 업무가 "+t.getCnt()+"건 있습니다.")
                        .build();
            }
            notificationRepository.saveAll(notifications);
            //fcm 발송
            List<Message> messageList=generateMessageList(list,true);
            if(messageList.isEmpty())return;
            firebaseMessaging.sendAll(messageList);
        }catch(FirebaseMessagingException e){
            e.printStackTrace();
        }
    }

    @Override
    public void sendEveningNotification(){
        //멤버 별로 오늘 완료하지 못한 일 개수 알림
        List<CountPlanDto> list=calendarRepository.getUndonePlan();
        List<Notification> notifications=new ArrayList<>();
        try{
            for(CountPlanDto t:list){
                Notification temp=Notification.builder()
                        .notificationType(notificationTypeRepository.findById(4).get())
                        .member(memberRepository.findById(t.getMemberId()).get())
                        .message("Your majesty, 아직 처리하지 못한 업무가 "+t.getCnt()+"건 있습니다.")
                        .build();
                notifications.add(temp);
            }
            notificationRepository.saveAll(notifications);
            List<Message> messageList=generateMessageList(list,false);
            if(messageList.isEmpty())return;
            firebaseMessaging.sendAll(messageList);
        }catch(FirebaseMessagingException e){
            e.printStackTrace();
        }
    }

    @Override
    public void generateTodoNotificationTmp(Long todoId){
        Optional<Todo> todo=todoRepository.findById(todoId);
        if(todo.isEmpty())throw new TodoNotFoundException();
        //현 시간보다 이전에 시작한 일정이면 예약 알림 보내지 않음
        if(todo.get().getStartAt().isBefore(LocalDateTime.now()))return;
        NotificationTmp nt=NotificationTmp.builder()
                .notificationType(notificationTypeRepository.findById(2).get())
                .todo(todo.get())
                .member(todo.get().getMember())
                .sendTime(todo.get().getStartAt().minusHours(1))
                .message("Your majesty, "+todo.get().getTodoNm()+" 시작 한 시간 전입니다.")
                .build();
        notificationTmpRepository.save(nt);
        return;
    }

//    @Override
//    public void generateMemberRoutineNotificationTmp(MemberRoutine memberRoutine){
//        return;
//    }

    @Override
    public List<Notification> getNotification(Long memberId){
        if(memberRepository.findMemberByMemberId(memberId).isEmpty()) throw new MemberNotFoundException();
        return notificationRepository.getNotificationsByMember_MemberId(memberId);
    }

    @Override
    public void deleteNotification(Long notificationId){
        Notification notification=notificationRepository.findById(notificationId).orElseThrow(()->new NotificationNotFoundException());
        notificationRepository.deleteById(notificationId);
        return;
    }

    @Override
    public void updateTodoNotification(Long todoId){
        Todo todo=todoRepository.findById(todoId).orElseThrow(()->new TodoNotFoundException());
        //없으면 새로 만듦-예전에 한 시간 전 알림까지 날린 todo를 수정할 수도 있으니
        Optional<NotificationTmp> n=notificationTmpRepository.findNotificationTmpByTodo_TodoId(todoId);
        if(n.isEmpty()){
            generateTodoNotificationTmp(todoId);
        }
        else{
            //현 시간보다 이전이면 있는 알림도 삭제
            if(todo.getStartAt().isBefore(LocalDateTime.now()))notificationTmpRepository.delete(n.get());
            else notificationTmpRepository.updateTodoNotification(todo);
        }
        return;
    }

//    public void updateMemberRoutineNotification(MemberRoutine memberRoutine){
//        Optional<NotificationTmp> nt=notificationTmpRepository.findNotificationTmpByMemberRoutine_Id(memberRoutine.getId());
//        if(nt.isEmpty())throw new RuntimeException();
//        nt.get().setMessage("Your majesty, "+memberRoutine.getRoutine().getName()+" 시작 한 시간 전입니다.");
//        //시간 설정
//    }

    @Override
    public void notificationSettingToggle(Long memberId,int notificationTypeId){
        NotificationSetting ns=notificationSettingRepository.findNotificationSettingByMember_MemberIdAndNotificationType_NotificationTypeId(memberId,notificationTypeId).orElseThrow(()->new NotificationSettingNotFoundException());
        boolean prev=ns.isActivatedYn();
        //토픽 구독/구독 취소 로직
        List<String> tokenList=fcmTokenRepository.findTokensByMemberId(memberId).orElseThrow(()->new TokenNotFoundException());
        String topic=notificationTypeRepository.findById(notificationTypeId).get().getType().name();
        try {
            TopicManagementResponse response;
            if (!prev){
                //토픽 구독 시작
                response= FirebaseMessaging.getInstance().subscribeToTopic(tokenList, topic);
            }
            else{
                //토픽 구독 취소
                response = FirebaseMessaging.getInstance().unsubscribeFromTopic(tokenList, topic);
            }
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }
        //엔티티 설정 바꿈
        ns.setActivatedYn(!prev);
    }

    public List<NotificationSettingResDto> getNotificationSetting(Long memberId) {

        Member member = memberRepository.findById(memberId).orElseThrow(
            () -> new MemberNotFoundException());
        List<NotificationSetting> notificationDtoList
            = notificationSettingRepository.findNotificationSettingsByMember(member);

        return notificationDtoList.stream()
            .map(n -> NotificationSettingResDto.builder()
                .notificationTypeId(n.getNotificationSettingId())
                .activatedYn((byte) (n.isActivatedYn() ? 1 : 0))
                .build())
            .collect(Collectors.toList());
    }
}
