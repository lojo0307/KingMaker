package com.dollyanddot.kingmaker.domain.todo.controller;

import com.dollyanddot.kingmaker.domain.todo.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/todo")
public class TodoController {
    private final TodoService todoService;

    @DeleteMapping("")
    public ResponseEntity<Void> deleteTodo(@RequestParam Long todoId){
        todoService.deleteTodoByTodoId(todoId);
        return ResponseEntity.ok().build();
    }
}
