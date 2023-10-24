package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;

import java.util.List;

public interface TodoService {
    void deleteTodoByTodoId(Long todoId);

    List<TodoListResDto> getTodoList(int year, int month, int day);
}
