package com.dollyanddot.kingmaker.domain.todo.repository;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoDetailResDto;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface TodoRepository extends JpaRepository<Todo,Long> {
    void deleteTodoByTodoId(Long todoId);

    @Query(name = "getTodoList", nativeQuery = true)
    List<TodoListResDto> getTodoList(Long memberId,LocalDate targetDate);

    Optional<Todo> getTodoByTodoId(Long todoId);
}
