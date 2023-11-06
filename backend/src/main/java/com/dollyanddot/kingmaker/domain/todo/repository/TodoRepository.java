package com.dollyanddot.kingmaker.domain.todo.repository;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface TodoRepository extends JpaRepository<Todo,Long>,TodoRepositoryCustom {
    @Transactional
    void deleteTodoByTodoId(Long todoId);

    @Query(name = "getTodoList", nativeQuery = true)
    List<TodoListResDto> getTodoList(Long memberId,LocalDate targetDate);

    Optional<Todo> getTodoByTodoId(Long todoId);

    @Query(name = "getTodoStreak", nativeQuery = true)
    List<CalendarStreakResDto> getTodoStreak(String targetMonth, Long memberId);
}
