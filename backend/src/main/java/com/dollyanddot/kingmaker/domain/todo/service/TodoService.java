package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarAchieveAndSumResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;

import java.util.List;

public interface TodoService {
    void deleteTodoByTodoId(Long todoId);

    List<TodoListResDto> getTodoList(Long memberId,String date);

    TodoDetailResDto getTodoDetail(Long todoId);

    List<CalendarStreakResDto> getStreak(int year, int month, Long memberId);

    List<CalendarAchieveAndSumResDto> getAchieveAndSum(int year, int month, Long memberId);
}
