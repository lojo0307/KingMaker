package com.dollyanddot.kingmaker.domain.todo.service;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.todo.exception.GetTodoDetailException;
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

    @Override
    public TodoDetailResDto getTodoDetail(Long todoId) throws GetTodoDetailException {
        Optional<Todo> todo=todoRepository.getTodoByTodoId(todoId);
        if(todo.isEmpty()) throw new GetTodoDetailException();
        TodoDetailResDto detail=new TodoDetailResDto();
        detail.setTodoDetail(todo.get().getTodoDetail());
        detail.setTodoPlace(todo.get().getTodoPlace());
        detail.setTodoNm(todo.get().getTodoNm());
        byte temp=(byte)(todo.get().isAchievedYn()?1:0);
        detail.setAchievedYn(temp);
        temp=(byte)(todo.get().isImportantYn()?1:0);
        detail.setImportantYn(temp);
        detail.setEndAt(todo.get().getEndAt());
        detail.setStartAt(todo.get().getStartAt());
        detail.setTodoNm(todo.get().getTodoNm());
        detail.setMonsterCd(todo.get().getMonsterCd());
        Long categoryId=todo.get().getCategory().getId();
        detail.setCategoryId(categoryId);
        return detail;
    }


}
