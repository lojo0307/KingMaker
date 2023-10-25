package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoStreakResDto;

import java.util.List;

public interface TodoService {
    void deleteTodoByTodoId(Long todoId);

    List<TodoListResDto> getTodoList(Long memberId,String date);

    TodoDetailResDto getTodoDetail(Long todoId);

    List<TodoStreakResDto> getTodoStreak(int year,int month,Long memberId);
}
