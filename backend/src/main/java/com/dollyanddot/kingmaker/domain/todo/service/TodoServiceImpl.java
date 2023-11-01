package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.calendar.dto.CalendarAchieveDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarAchieveAndSumResDto;
import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.request.PostTodoReqDto;
import com.dollyanddot.kingmaker.domain.todo.dto.request.PutTodoReqDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.PatchTodoResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.exception.GetTodoDetailException;
import com.dollyanddot.kingmaker.domain.todo.exception.GetTodoListException;
import com.dollyanddot.kingmaker.domain.todo.exception.NonExistTodoIdException;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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

  @Override
  public void deleteTodoByTodoId(Long todoId) throws NonExistTodoIdException {
    Optional<Todo> temp = todoRepository.findById(todoId);
    if (temp.isEmpty()) {
      throw new NonExistTodoIdException();
    }
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
  public List<CalendarAchieveAndSumResDto> getAchieveAndSum(int year, int month, Long memberId) {
    List<CalendarAchieveDto> achieveList = calendarRepository.getAchieveByMonth(year, month,
        memberId);
    List<CalendarStreakResDto> sumList = calendarRepository.getPlansByMonth(year, month, memberId);
    List<CalendarAchieveAndSumResDto> result = new ArrayList<>();
    LocalDate newDate = LocalDate.of(year, month, 1);
    int lengthOfMon = newDate.lengthOfMonth();
    for (int i = 1; i <= lengthOfMon; i++) {
      result.add(new CalendarAchieveAndSumResDto(i, 0, 0));
    }
    for (CalendarAchieveDto a : achieveList) {
      result.get(a.getDay() - 1).setAchieve(a.getAchieve());
    }
    for (CalendarStreakResDto s : sumList) {
      result.get(s.getDay() - 1).setSum(s.getLevel());
    }
    return result;
  }

  @Override
  public List<TodoListResDto> getTodoList(Long memberId, String date) throws GetTodoListException {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
    LocalDate targetDate = LocalDate.parse(date, formatter);
    return todoRepository.getTodoList(memberId, targetDate);
  }

  @Override
  public TodoDetailResDto getTodoDetail(Long todoId) throws GetTodoDetailException {
    Optional<Todo> todo = todoRepository.getTodoByTodoId(todoId);
    if (todo.isEmpty()) {
      throw new GetTodoDetailException();
    }
    byte achivedYn=(byte) (todo.get().isAchievedYn() ? 1 : 0);
    byte importantYn=(byte) (todo.get().isImportantYn() ? 1 : 0);
    TodoDetailResDto detail=TodoDetailResDto.builder()
            .todoDetail(todo.get().getTodoDetail())
            .todoPlace(todo.get().getTodoPlace())
            .todoNm(todo.get().getTodoNm())
            .achievedYn(achivedYn)
            .importantYn(importantYn)
            .startAt(todo.get().getStartAt())
            .endAt(todo.get().getEndAt())
            .monsterCd(todo.get().getMonsterCd())
            .categoryId(todo.get().getCategory().getId())
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

    return null;
  }

  @Override
  @Transactional
  public PatchTodoResDto changeAchievedStatement(Long todoId){

    Todo todo = todoRepository.findById(todoId).orElseThrow();

    return PatchTodoResDto.from(todo.toggleAchieved());
  }
}
