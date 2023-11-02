package com.dollyanddot.kingmaker.domain.scheduler;

import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.notification.service.NotificationService;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class SchedulerService {

  private final RoutineRepository routineRepository;
  private final MemberRoutineRepository memberRoutineRepository;
  private final CalendarRepository calendarRepository;
  private final NotificationService notificationService;

  @Transactional
  @Scheduled(cron = "0 0 0 * * ?", zone = "Asia/Seoul")
  public void registerTodayRoutines() {

    JSONParser jsonParser = new JSONParser();

    LocalDateTime today = LocalDateTime.now();
    List<Routine> todayRoutines = routineRepository.findAllByRegisterDateOrDay(today,
        today.getDayOfWeek().getValue());

    List<MemberRoutine> memberRoutines = memberRoutineRepository.saveAll(todayRoutines.stream()
        .map(routine -> MemberRoutine.builder()
            .member(routine.getMember())
            .routine(routine)
            .achievedYn(false)
            .monsterCd(1)
            .build())
        .collect(Collectors.toList()));

    memberRoutines.stream().forEach(memberRoutine -> calendarRepository.save(
        Calendar.builder().member(memberRoutine.getMember()).memberRoutine(memberRoutine)
            .calendarDate(today.toLocalDate()).build()));

    todayRoutines.stream().forEach(routine -> {
      try {

        JSONObject jsonObject = (JSONObject) jsonParser.parse(routine.getPeriod());

        if (jsonObject.get("type").equals("num")) {
          routine.updateRegisterAt(
              routine.getRegisterAt().plusDays((Long) jsonObject.get("value")));

        } else {
          JSONArray dayArr = (JSONArray) jsonObject.get("value");

          for(int i=today.getDayOfWeek().getValue()+1; i<=dayArr.size(); i++){
            if((boolean) dayArr.get(i%dayArr.size())){
              routine.updateRegisterDay(i);
              break;
            }

            if(i == dayArr.size()){
              i = 1;
            }
          }

        }
      } catch (ParseException e) {
        log.error("{}: JSON parsing 예외 발생", e.toString());
      }
    });
  }

  @Scheduled(cron="0 0 8 * * ?",zone="Asia/Seoul")
  public void sendMorningNotification() throws Exception{
    //TODO: 매일 오전 8시에 아침 알림 발송
    notificationService.sendMorningNotification();
  }

  @Scheduled(cron="0 0 21 * * ?",zone="Asia/Seoul")
  public void sendEveningNotification() throws Exception{
    //TODO: 매일 오후 9시에 아직 해결되지 않은 알림 발송
    notificationService.sendEveningNotification();
  }

//  @Scheduled(cron="0 0/1 * * * *",zone="Asia/Seoul")
//  public void sendPlanNotification() throws Exception{
//    //TODO: 일정 수행 시작 한 시간 전 알림 발송
//    notificationService.sendNotification();
//  }
}
