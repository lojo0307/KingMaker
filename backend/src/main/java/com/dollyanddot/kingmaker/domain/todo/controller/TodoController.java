package com.dollyanddot.kingmaker.domain.todo.controller;

import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.service.TodoService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
    public EnvelopeResponse<TodoListResDto> getTodoList(){
        return EnvelopeResponse.<TodoListResDto>builder()
                .data(null)
                .build();
    }
}
