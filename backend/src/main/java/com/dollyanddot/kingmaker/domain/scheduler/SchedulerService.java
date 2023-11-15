package com.dollyanddot.kingmaker.domain.scheduler;

import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.service.NotificationService;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.dollyanddot.kingmaker.domain.reward.service.RewardService;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import com.google.type.DateTime;
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

  @Transactional
  @Scheduled(cron="0 0/10 * * * *",zone="Asia/Seoul")
//  @Scheduled(cron="0 0 8 * * ?",zone="Asia/Seoul")
  public void sendMorningNotification() throws Exception{
    log.info("아침 알림 발송");
    //TODO: 매일 오전 8시에 아침 알림 발송
    notificationService.sendMorningNotification();
  }

  @Scheduled(cron="0 0/10 * * * *",zone="Asia/Seoul")
//  @Scheduled(cron="0 0 21 * * ?",zone="Asia/Seoul")
  public void sendEveningNotification() throws Exception{
    log.info("저녁 알림 발송");
    //TODO: 매일 오후 9시에 아직 해결되지 않은 알림 발송
    notificationService.sendEveningNotification();
  }

  @Transactional
  @Scheduled(cron="0 0/1 * * * *",zone="Asia/Seoul")
  public void sendPlanNotification() throws Exception{
    //TODO: 일정 수행 시작 한 시간 전 알림 발송
    notificationService.sendNotification();
  }

  @Transactional
  @Scheduled(cron="0 0/10 * * * *", zone="Asia/Seoul")
//  @Scheduled(cron="0 0 0 * * *", zone="Asia/Seoul")
  public void checkNotAchievedPlanFromYesterday() throws Exception {
    log.info("미달성 업무 알림 발송");
    //어제 일정 미달성한 개수 카운트 & 백성 수 줄이기
//    List<CountPlanDto> undoneList = calendarRepository.getUndonePlanCntYesterday();
    //어제 일정 달성한 개수 카운트
//    List<CountPlanDto> DoneList = calendarRepository.getUndonePlanCntYesterday();

    //업적 달성 시
    List<CountPlanDto> allDtoList = calendarRepository.getUndonePlanAllCnt();
    for(CountPlanDto c : allDtoList) {
      if(c.getCnt()==50) {
        rewardService.getUndonePlanAllCnt(1, c);
      } else if(c.getCnt()==100) {
        rewardService.getUndonePlanAllCnt(2, c);
      }
    }

    //어제 미달성한 업무 관련 밤 12시에 알림
    notificationService.sendChangeCitizenNotification();
  }

  //오늘 할 일(그 중에서도 미달성인) 30개 이상이면 몬스터 파크 개장 업적 부여
  @Scheduled(cron="0 0 8 * * ?",zone="Asia/Seoul")
  public void grantMonsterPark(){
    rewardService.getMonsterPark();
  }

  //매달 1일마다, 전 달의 국가 브랜드 평판 S급 업적 부여
  @Scheduled(cron="0 0 8 1 * ?",zone="Asia/Seoul")
  public void getMonthlyBrandReputation(){
    int year=LocalDate.now().getYear();
    int month= LocalDate.now().getMonthValue()-1;
    rewardService.getMonthlyBrandReputation(year,month);
  }
}
