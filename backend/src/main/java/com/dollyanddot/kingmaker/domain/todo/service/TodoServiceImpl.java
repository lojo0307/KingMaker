package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.exception.NonExistTodoIdException;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
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
    public List<TodoListResDto> getTodoList(int year, int month, int day) {
        LocalDate targetDate=LocalDate.of(year,month,day);
        return todoRepository.getTodoList(targetDate);
    }


}
