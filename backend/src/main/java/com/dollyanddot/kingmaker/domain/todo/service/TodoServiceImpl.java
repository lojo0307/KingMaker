package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.dto.CalendarAchieveDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.category.exception.CategoryNotFoundException;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.service.NotificationService;
import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardInfoDto;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import com.dollyanddot.kingmaker.domain.reward.exception.MemberRewardNotFoundException;
import com.dollyanddot.kingmaker.domain.reward.exception.RewardNotFoundException;
import com.dollyanddot.kingmaker.domain.reward.repository.MemberRewardRepository;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.dollyanddot.kingmaker.domain.reward.service.RewardService;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.request.PostTodoReqDto;
import com.dollyanddot.kingmaker.domain.todo.dto.request.PutTodoReqDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.PatchTodoResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.PostTodoResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.exception.TodoNotFoundException;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class TodoServiceImpl implements TodoService {

  private final TodoRepository todoRepository;
  private final CalendarRepository calendarRepository;
  private final MemberRepository memberRepository;
  private final CategoryRepository categoryRepository;
  private final NotificationService notificationService;
  private final KingdomService kingdomService;
  private final RewardRepository rewardRepository;
  private final MemberRewardRepository memberRewardRepository;
  private final RoutineRepository routineRepository;
  private final RewardService rewardService;

  @Override
  public void deleteTodoByTodoId(Long todoId){
    Todo temp = todoRepository.findById(todoId).orElseThrow(()->new TodoNotFoundException());
    todoRepository.deleteTodoByTodoId(todoId);
  }

  @Override
  public List<CalendarStreakResDto> getStreak(int year, int month, Long memberId) {
    //윤년까지 계산해야 하므로 year도 parameter로 넘김
    List<CalendarStreakResDto> list = calendarRepository.getPlansByMonth(year, month, memberId);
    List<CalendarStreakResDto> result = new ArrayList<>();
    LocalDate newDate = LocalDate.of(year, month, 1);
    int lengthOfMon = newDate.lengthOfMonth();
    for (int i = 1; i <= lengthOfMon; i++) {
      result.add(new CalendarStreakResDto(i, 0));
    }
    for (CalendarStreakResDto c : list) {
      result.get(c.getDay() - 1).setLevel(c.getLevel());
    }
    return result;
  }

  @Override
  public List<CalendarStreakResDto> getAchieveLevel(int year, int month, Long memberId) {
    List<CalendarAchieveDto> achieveList = calendarRepository.getAchieveByMonth(year, month,
        memberId);
    List<CalendarStreakResDto> sumList = calendarRepository.getPlansByMonth(year, month, memberId);
    List<CalendarStreakResDto> result = new ArrayList<>();
    LocalDate newDate = LocalDate.of(year, month, 1);
    int lengthOfMon = newDate.lengthOfMonth();
    for (int i = 1; i <= lengthOfMon; i++) {
      result.add(new CalendarStreakResDto(i, 0));
    }
    for (CalendarAchieveDto a : achieveList) {
      result.get(a.getDay() - 1).setLevel(a.getAchieve());
    }
    for (CalendarStreakResDto s : sumList) {
      int achieve= result.get(s.getDay()-1).getLevel();
      int level;
      if(achieve==0)level=0;
      else{
        double rate=(double)s.getLevel()/(double)achieve*100;
        level=(int)Math.round(rate);
      }
//      System.out.println(s.getDay()+"일의 달성률은 "+level+"이고 achieved: "+achieve+" level: "+s.getLevel());
//      if(rate>0.8)level=5;
//      else if(rate>0.6)level=4;
//      else if(rate>0.4)level=3;
//      else if(rate>0.2)level=2;
//      else if(rate>0)level=1;
//      else level=0;
      result.get(s.getDay() - 1).setLevel(level);
    }
    return result;
  }

  @Override
  public List<TodoListResDto> getTodoList(Long memberId, String date){
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
    LocalDate targetDate = LocalDate.parse(date, formatter);
    return todoRepository.getTodoList(memberId, targetDate);
  }

  @Override
  public TodoDetailResDto getTodoDetail(Long todoId){
    Todo todo = todoRepository.getTodoByTodoId(todoId).orElseThrow(()->new TodoNotFoundException());
    byte achivedYn=(byte) (todo.isAchievedYn() ? 1 : 0);
    byte importantYn=(byte) (todo.isImportantYn() ? 1 : 0);
    TodoDetailResDto detail=TodoDetailResDto.builder()
            .todoDetail(todo.getTodoDetail())
            .todoPlace(todo.getTodoPlace())
            .todoNm(todo.getTodoNm())
            .achievedYn(achivedYn)
            .importantYn(importantYn)
            .startAt(todo.getStartAt())
            .endAt(todo.getEndAt())
            .categoryId(todo.getCategory().getId())
            .build();
    return detail;
  }

  @Override
  @Transactional
  public PostTodoResDto registerTodo(PostTodoReqDto postTodoReqDto) {

    Member member = memberRepository.findById(postTodoReqDto.getMemberId()).orElseThrow(MemberRewardNotFoundException::new);
    List<RewardResDto> rewardResDtoList = new ArrayList<>();

    Todo todo = todoRepository.save(new Todo().builder()
        .member(member)
        .category(categoryRepository.findById(postTodoReqDto.getCategoryId()).orElseThrow(
            CategoryNotFoundException::new))
        .startAt(postTodoReqDto.getStartAt())
        .endAt(postTodoReqDto.getEndAt())
        .todoNm(postTodoReqDto.getTodoNm())
        .todoDetail(postTodoReqDto.getTodoDetail())
        .todoPlace(postTodoReqDto.getTodoPlace())
        .importantYn(postTodoReqDto.isImportantYn())
        .build());

    LocalDate startDate = postTodoReqDto.getStartAt().toLocalDate();
    LocalDate endDate = postTodoReqDto.getEndAt().toLocalDate();

    LocalDate.from(startDate).datesUntil(LocalDate.from(endDate).plusDays(1))
        .forEach(date -> calendarRepository.save(new Calendar().builder()
            .todo(todo)
            .member(member)
            .calendarDate(date)
            .build()));

    // 13번 업적 달성
    Reward reward = rewardRepository.findById(13).orElseThrow(RewardNotFoundException::new);
    MemberReward memberReward = memberRewardRepository.findByMemberAndReward(member, reward);
    if (!memberReward.isAchievedYn()) {
      List<Todo> todos = todoRepository.findAllByMember(member);
      // 할일 100개 이상 등록했는지 체크
      if (todos.size() >= 100) {
        memberReward.achieveReward();

        rewardResDtoList.add(RewardResDto.builder().isRewardAchieved(1).rewardInfoDto(
            RewardInfoDto.from(
                reward.getRewardId(),
                reward.getRewardNm(),
                reward.getRewardCond(),
                reward.getRewardMsg())
        ).build());
      }
    }

    //알림 생성
    notificationService.generateTodoNotificationTmp(todo.getTodoId());

    if(rewardResDtoList.size() == 0){
      return PostTodoResDto.from(null);
    } else {
      log.info("달성 업적");
      for(RewardResDto r: rewardResDtoList) {
        log.info("업적명: {}", r.getRewardInfoDto().getRewardNm());
        log.info("업적 조건: {}", r.getRewardInfoDto().getRewardCond());
        log.info("업적 메시지: {}", r.getRewardInfoDto().getRewardMsg());
      }
    }

    return PostTodoResDto.from(rewardResDtoList);
  }

  @Override
  @Transactional
  public Void editTodo(PutTodoReqDto putTodoReqDto) {

    Todo todo = todoRepository.findById(putTodoReqDto.getTodoId()).orElseThrow(TodoNotFoundException::new);
    List<Calendar> calendars = calendarRepository.findAllByTodoAndMember(todo, todo.getMember());

    todo.update(categoryRepository.findById(putTodoReqDto.getCategoryId()).orElseThrow(CategoryNotFoundException::new),
        putTodoReqDto.getTodoNm(), putTodoReqDto.getTodoDetail(), putTodoReqDto.getTodoPlace(),
        putTodoReqDto.isImportantYn(), putTodoReqDto.getStartAt(), putTodoReqDto.getEndAt());

    LocalDate startDate = todo.getStartAt().toLocalDate();
    LocalDate endDate = todo.getEndAt().toLocalDate();

    LocalDate.from(startDate).datesUntil(LocalDate.from(endDate).plusDays(1))
        .forEach(date -> {
          if(calendarRepository.findByCalendarDateAndTodo(date, todo) == null){
            calendarRepository.save(new Calendar().builder()
                .todo(todo)
                .member(todo.getMember())
                .calendarDate(date)
                .build());
          }
        });

    for (Calendar calendar : calendars) {
      if (calendar.getCalendarDate().isBefore(startDate) || calendar.getCalendarDate()
          .isAfter(endDate)) {
        calendarRepository.delete(calendar);
      }
    }
    //알림 수정
    notificationService.updateTodoNotification(putTodoReqDto.getTodoId());
    return null;
  }

  @Override
  @Transactional
  public PatchTodoResDto changeAchievedStatement(Long todoId) {

    Todo todo = todoRepository.findById(todoId).orElseThrow(TodoNotFoundException::new);
    Member member = todo.getMember();
    List<RewardResDto> rewardResDtoList = new ArrayList<>();

    Reward reward;

    //수행으로 인한 달성 여부 변경이 발생하기 전에 확인
    if (!todo.isAchievedYn()) {
      //4번 업적 달성 여부 확인 - 마지막 수행으로부터 30일 이상 지난 후 다시 수행을 한 경우
      reward = rewardRepository.findById(4).orElseThrow(RewardNotFoundException::new);

      if (!memberRewardRepository.findMemberRewardByMemberAndReward(member, reward)
          .orElseThrow(MemberRewardNotFoundException::new).isAchievedYn()) {

        LocalDateTime date1 = todoRepository.findMostRecentAchieved();
        LocalDateTime date2 = routineRepository.findMostRecentAchieved();
        LocalDateTime lastAchievedDate = null;
        if (date1 != null && date2 != null) {
          lastAchievedDate = date1.isAfter(date2) ? date1 : date2;
        } else if (date1 != null) {
          lastAchievedDate = date1;
        } else if (date2 != null) {
          lastAchievedDate = date2;
        } else {
          lastAchievedDate = LocalDateTime.now();
        }

        if (Math.abs(
            Period.between(lastAchievedDate.toLocalDate(), LocalDateTime.now().toLocalDate())
                .getDays()) >= 30) {
          rewardResDtoList.add(RewardResDto.builder()
              .rewardInfoDto(RewardInfoDto.from(
                  reward.getRewardId(),
                  reward.getRewardNm(),
                  reward.getRewardCond(),
                  reward.getRewardMsg()))
              .isRewardAchieved(1)
              .build());
        }
      }
    }

    //수행으로 인한 달성 여부 변경이 발생
    boolean isAchieved = todo.toggleAchieved();
    //달성 시
    if (isAchieved) {

      //중요도 상인 할일 첫 수행 시
      if (todo.isImportantYn() && !memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(9).orElseThrow(RewardNotFoundException::new)).isAchievedYn()) {

        memberRewardRepository.achieveMemberReward(member.getMemberId(), 9);
        reward = rewardRepository.findById(9).orElseThrow(RewardNotFoundException::new);
        rewardResDtoList.add(RewardResDto.builder()
            .rewardInfoDto(RewardInfoDto.from(
                reward.getRewardId(),
                reward.getRewardNm(),
                reward.getRewardCond(),
                reward.getRewardMsg()))
            .isRewardAchieved(1)
            .build());
      }

      //8번 업적 달성 여부 확인 - 카테고리 별 하나 이상씩 달성한 경우
      RewardResDto colorfulWorld = rewardService.colorfulWorld(member.getMemberId());
      if (colorfulWorld.getIsRewardAchieved() == 1)
        rewardResDtoList.add(colorfulWorld);

      //11번 업적 달성 여부 확인 - 첫 몬스터 처치인 경우
      reward = rewardRepository.findById(11).orElseThrow(RewardNotFoundException::new);
      MemberReward memberReward = memberRewardRepository.findByMemberAndReward(member, reward);

      if (!memberReward.isAchievedYn()) {

        memberReward.achieveReward();

        rewardResDtoList.add(RewardResDto.builder()
            .rewardInfoDto(RewardInfoDto.from(
                reward.getRewardId(),
                reward.getRewardNm(),
                reward.getRewardCond(),
                reward.getRewardMsg()))
            .isRewardAchieved(memberReward.isAchievedYn() ? 1 : 0)
            .build());
      }
      int changeLevel = kingdomService.changeCitizen(member.getMemberId(), "plus");

      //5, 6, 7번 업적 수행 여부 확인 - 왕국 단계 재산정 및 해당되는 업적 번호(3단게/6단계/9단계)가 있는 경우
      int rewardId = kingdomService.levelReward(changeLevel);
      if (rewardId != 0 && !memberRewardRepository.findByMemberAndReward(
              memberRepository.findById(member.getMemberId()).orElseThrow(MemberNotFoundException::new),
              rewardRepository.findById(rewardId).orElseThrow(RewardNotFoundException::new))
          .isAchievedYn()) {

        reward = rewardRepository.findById(rewardId).orElseThrow(RewardNotFoundException::new);

        memberReward = memberRewardRepository.findByMemberAndReward(member, reward);

        if(memberReward == null){
          throw new MemberRewardNotFoundException();
        }

        rewardResDtoList.add(RewardResDto.builder()
            .rewardInfoDto(RewardInfoDto.from(
                reward.getRewardId(),
                reward.getRewardNm(),
                reward.getRewardCond(),
                reward.getRewardMsg()))
            .isRewardAchieved(!memberReward.isAchievedYn() && memberReward.achieveReward() ? 1 : 0)
            .build());
      }

    } else {
      int originLevel = member.getKingdom().getLevel();

      //백성 수 다시 차감 및 레벨 변경
      int changeLevel = kingdomService.changeCitizen(member.getMemberId(), "minus");
    }

    if(rewardResDtoList.isEmpty()){
      return PatchTodoResDto.from(isAchieved, null);
    } else {
      log.info("달성 업적 리스트");
      for(RewardResDto r: rewardResDtoList) {
        log.info("업적명: {}", r.getRewardInfoDto().getRewardNm());
        log.info("업적 조건: {}", r.getRewardInfoDto().getRewardCond());
        log.info("업적 메시지: {}", r.getRewardInfoDto().getRewardMsg());
        log.info("------------------------------------------------");
      }
    }

    return PatchTodoResDto.from(isAchieved,rewardResDtoList);
  }

}
