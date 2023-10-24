package com.dollyanddot.kingmaker.domain.todo.controller;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.service.TodoService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/todo")
public class TodoController {
    private final TodoService todoService;

    @DeleteMapping
    public EnvelopeResponse<Void> deleteTodo(@RequestParam Long todoId){
        todoService.deleteTodoByTodoId(todoId);
        return EnvelopeResponse.<Void>builder()
                .data(null)
                .build();
    }

    @GetMapping
    public EnvelopeResponse<List<TodoListResDto>> getTodoList(@RequestParam int year, @RequestParam int month, @RequestParam int day){
        List<TodoListResDto> list=todoService.getTodoList(year,month,day);
        return EnvelopeResponse.<List<TodoListResDto>>builder()
                .data(list)
                .build();
    }
}
