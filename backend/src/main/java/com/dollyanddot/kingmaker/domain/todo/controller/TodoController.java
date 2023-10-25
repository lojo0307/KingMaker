package com.dollyanddot.kingmaker.domain.todo.controller;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
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

    //성공 시 성공 메시지만 출력, 아닐 경우 예외 처리
    @DeleteMapping
    public EnvelopeResponse<Void> deleteTodo(@RequestParam Long todoId){
        todoService.deleteTodoByTodoId(todoId);

        return EnvelopeResponse.<Void>builder()
                .data(null)
                .build();
    }

    @GetMapping("list/{memberId}")
    public EnvelopeResponse<List<TodoListResDto>> getTodoList(@PathVariable Long memberId,@RequestParam String date){
        List<TodoListResDto> list=todoService.getTodoList(memberId,date);
        return EnvelopeResponse.<List<TodoListResDto>>builder()
                .data(list)
                .build();
    }

    @GetMapping("{todoId}")
    public EnvelopeResponse<TodoDetailResDto> getTodoDetail(@PathVariable Long todoId){
        TodoDetailResDto detail=todoService.getTodoDetail(todoId);
        return EnvelopeResponse.<TodoDetailResDto>builder()
                .data(detail)
                .build();
    }
}
