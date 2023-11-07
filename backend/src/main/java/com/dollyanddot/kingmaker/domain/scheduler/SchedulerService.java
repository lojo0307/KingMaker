package com.dollyanddot.kingmaker.domain.scheduler;

import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.service.NotificationService;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.dollyanddot.kingmaker.domain.reward.service.RewardService;
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
  private final RewardService rewardService;
  private final KingdomService kingdomService;
  private final MemberRepository memberRepository;
  private final RewardRepository rewardRepository;

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
              i = 0;
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

  @Scheduled(cron="0 0 0 * * *", zone="Asia/Seoul")
  public void checkNotAchievedPlanFromYesterday() {
    //어제 일정 미달성한 개수 카운트 & 백성 수 줄이기
    List<CountPlanDto> yesterdayDtoList = calendarRepository.getUndonePlanCntYesterday();

    //백성 수 차감 및 레벨 변경
    for(CountPlanDto c : yesterdayDtoList) {
      if(c.getCnt()>0) {
        memberRepository.findById(c.getMemberId()).orElseThrow(MemberNotFoundException::new);
        kingdomService.penaltyCitizen(c.getMemberId(), c.getCnt());
      }
     }

    //TODO: 아침 알림 메시지에 몬스터로 인해 백성이 이주했다는 메시지 추가

    rewardService.getUndonePlanAllCnt50();
    rewardService.getUndonePlanAllCnt100();

    //TODO: 업적 추가된 사항 전달
  }

  //오늘 할 일(그 중에서도 미달성인) 30개 이상이면 몬스터 파크 개장 업적 부여
  @Scheduled(cron="0 0 8 * * ?",zone="Asia/Seoul")
  public void grantMonsterPark(){
    rewardService.getMonsterPark();
  }
}
