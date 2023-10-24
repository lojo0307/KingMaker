package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.exception.GetTodoListException;
import com.dollyanddot.kingmaker.domain.todo.exception.NonExistTodoIdException;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TodoServiceImpl implements TodoService{
    private final TodoRepository todoRepository;
    @Override
    public void deleteTodoByTodoId(Long todoId) throws NonExistTodoIdException {
        Optional<Todo> temp=todoRepository.findById(todoId);
        if(temp.isEmpty())throw new NonExistTodoIdException();
        todoRepository.deleteTodoByTodoId(todoId);
    }

    @Override
    public List<TodoListResDto> getTodoList(Long memberId,String date) throws GetTodoListException {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
        LocalDate targetDate=LocalDate.parse(date, formatter);
        return todoRepository.getTodoList(memberId,targetDate);
    }


}
