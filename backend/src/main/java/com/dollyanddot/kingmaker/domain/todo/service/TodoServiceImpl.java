package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.dto.CalendarAchieveDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
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
import com.dollyanddot.kingmaker.domain.routine.dto.response.PatchRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.request.PostTodoReqDto;
import com.dollyanddot.kingmaker.domain.todo.dto.request.PutTodoReqDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.PatchTodoResDto;
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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
      double rate=(double)achieve/(double)s.getLevel();
      System.out.println(s.getDay()+"일의 달성률은 "+rate+"이고 achieved: "+achieve+" level: "+s.getLevel());
      int level;
      if(rate>0.8)level=5;
      else if(rate>0.6)level=4;
      else if(rate>0.4)level=3;
      else if(rate>0.2)level=2;
      else if(rate>0)level=1;
      else level=0;
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
            .monsterCd(todo.getMonsterCd())
            .categoryId(todo.getCategory().getId())
            .build();
    return detail;
  }

  @Override
  @Transactional
  public Void registerTodo(PostTodoReqDto postTodoReqDto) {

    Member member = memberRepository.findById(postTodoReqDto.getMemberId()).orElseThrow();

    Todo todo = todoRepository.save(new Todo().builder()
        .member(member)
        .category(categoryRepository.findById(postTodoReqDto.getCategoryId()).orElseThrow())
        .startAt(postTodoReqDto.getStartAt())
        .endAt(postTodoReqDto.getEndAt())
        .todoNm(postTodoReqDto.getTodoNm())
        .todoDetail(postTodoReqDto.getTodoDetail())
        .todoPlace(postTodoReqDto.getTodoPlace())
        .importantYn(postTodoReqDto.isImportantYn())
        .monsterCd(postTodoReqDto.getMonsterCd())
        .build());

    LocalDate startDate = postTodoReqDto.getStartAt().toLocalDate();
    LocalDate endDate = postTodoReqDto.getEndAt().toLocalDate();

    LocalDate.from(startDate).datesUntil(LocalDate.from(endDate).plusDays(1))
        .forEach(date -> calendarRepository.save(new Calendar().builder()
            .todo(todo)
            .member(member)
            .calendarDate(date)
            .build()));

    //알림 생성
    notificationService.generateTodoNotificationTmp(todo.getTodoId());
    return null;
  }

  @Override
  @Transactional
  public Void editTodo(PutTodoReqDto putTodoReqDto) {

    Todo todo = todoRepository.findById(putTodoReqDto.getTodoId()).orElseThrow();
    List<Calendar> calendars = calendarRepository.findAllByTodoAndMember(todo, todo.getMember());

    todo.update(categoryRepository.findById(putTodoReqDto.getCategoryId()).orElseThrow(),
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
  public PatchTodoResDto changeAchievedStatement(Long todoId){

    Todo todo = todoRepository.findById(todoId).orElseThrow();
    Member member = todo.getMember();
    List<RewardResDto> rewardResDtoList=new ArrayList<>();

    if (!todo.isAchievedYn()) {
      // 4번 업적 확인 로직
      Reward reward4 = rewardRepository.findById(4).get();
      RewardInfoDto rewardInfoDto4 = RewardInfoDto
              .builder()
              .rewardNm(reward4.getRewardNm())
              .rewardId(reward4.getRewardId())
              .rewardMsg(reward4.getRewardMsg())
              .rewardCond(reward4.getRewardCond())
              .build();

      if (!memberRewardRepository.findMemberRewardByMemberAndReward(member, reward4).get().isAchievedYn()) {
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
        if (Math.abs(Period.between(lastAchievedDate.toLocalDate(), LocalDateTime.now().toLocalDate()).getDays()) >= 30) {
          rewardResDtoList.add(
                  RewardResDto
                          .builder()
                          .isRewardAchieved(1)
                          .rewardInfoDto(rewardInfoDto4)
                          .build()
          );
        } else {
          rewardResDtoList.add(
                  RewardResDto
                          .builder()
                          .isRewardAchieved(0)
                          .rewardInfoDto(rewardInfoDto4)
                          .build()
          );
        }
      } else {
        rewardResDtoList.add(
                RewardResDto
                        .builder()
                        .isRewardAchieved(0)
                        .rewardInfoDto(rewardInfoDto4)
                        .build()
        );
      }
    }

    boolean isAchieved = todo.toggleAchieved();
    Reward reward;
    //달성 시
    if (isAchieved) {
      //중요도 상인 할일 첫 수행 시
      if(todo.isImportantYn()){
        MemberReward mr=memberRewardRepository.findMemberRewardByMember_MemberIdAndReward_RewardId(member.getMemberId(),9).orElseThrow(()->new MemberRewardNotFoundException());
        if(!mr.isAchievedYn()){
          //'업적 달성'으로 바꿈
          memberRewardRepository.achieveMemberReward(member.getMemberId(),9);
          reward=rewardRepository.findById(9).orElseThrow(()->new RewardNotFoundException());
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

      //카테고리 별 하나 이상씩 달성한 경우
      RewardResDto colorfulWorld=rewardService.colorfulWorld(member.getMemberId());
      if(colorfulWorld.getIsRewardAchieved()==1)rewardResDtoList.add(colorfulWorld);

      //백성 수 증가
      int changeLevel = kingdomService.changeCitizen(member.getMemberId(), "plus");

      if (!memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(todo.getMember().getMemberId())
              .orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(11).orElseThrow()).isAchievedYn()) {

        reward = rewardRepository.findById(11).orElseThrow();
        MemberReward memberReward = memberRewardRepository.findByMemberAndReward(todo.getMember(),
            reward);

        rewardResDtoList.add(RewardResDto.builder()
            .rewardInfoDto(RewardInfoDto.from(
                reward.getRewardId(),
                reward.getRewardNm(),
                reward.getRewardCond(),
                reward.getRewardMsg()))
            .isRewardAchieved(!memberReward.isAchievedYn() && memberReward.achieveReward() ? 1 : 0)
            .build());
      }

      //왕국 단계 재산정 및 해당되는 업적 번호(3단게/6단계/9단계)가 있는 경우
      int rewardId = kingdomService.levelReward(changeLevel);

      if (rewardId != 0 && !memberRewardRepository.findByMemberAndReward(
          memberRepository.findById(member.getMemberId())
              .orElseThrow(MemberNotFoundException::new),
          rewardRepository.findById(rewardId).orElseThrow()).isAchievedYn()) {

        reward = rewardRepository.findById(rewardId).orElseThrow();

        //업적 달성으로 변경
        MemberReward memberReward = memberRewardRepository.findByMemberAndReward(member, reward);
        RewardInfoDto rewardInfoDto
            = RewardInfoDto.from(rewardId, reward.getRewardNm(),
            reward.getRewardCond(), reward.getRewardMsg());
        RewardResDto rewardResDto
            = RewardResDto.from(!memberReward.isAchievedYn() && memberReward.achieveReward() ? 1 : 0, rewardInfoDto);

        rewardResDtoList.add(rewardResDto);
      }





    } else {
      kingdomService.changeCitizen(member.getMemberId(), "minus");
    }
    if(rewardResDtoList.isEmpty()){
      rewardResDtoList.add(RewardResDto.from(0, null));}
    return PatchTodoResDto.from(isAchieved,rewardResDtoList);
  }

}
