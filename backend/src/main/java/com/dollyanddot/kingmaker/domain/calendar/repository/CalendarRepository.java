package com.dollyanddot.kingmaker.domain.calendar.repository;

import com.dollyanddot.kingmaker.domain.calendar.domain.Calendar;
import com.dollyanddot.kingmaker.domain.calendar.dto.CalendarAchieveDto;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import java.time.LocalDate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CalendarRepository extends JpaRepository<Calendar, Long>, CalendarRepositoryCustom{

    @Query(name="CalendarAchieveDtoMapping",nativeQuery = true)
    List<CalendarAchieveDto> getAchieveByMonth(@Param("year")int year, @Param("month")int month, @Param("memberId")Long memberId);

    List<Calendar> findAllByTodoAndMember(Todo todo, Member member);

    Calendar findByCalendarDateAndTodo(LocalDate date, Todo todo);
}
