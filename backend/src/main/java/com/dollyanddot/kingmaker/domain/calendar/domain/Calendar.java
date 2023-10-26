package com.dollyanddot.kingmaker.domain.calendar.domain;

import com.dollyanddot.kingmaker.domain.calendar.dto.CalendarAchieveDto;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.time.LocalDate;

@NamedNativeQuery(
        name="CalendarAchieveDtoMapping",
        query = "SELECT " +
                "DAY(c.calendar_date) AS `day`," +
                "(COALESCE(SUM(CASE WHEN t.todo_id IS NOT NULL THEN 1 ELSE 0 END), 0)+" +
                "COALESCE(SUM(CASE WHEN mr.member_routine_id IS NOT NULL THEN 1 ELSE 0 END), 0)) AS achieve " +
                "FROM calendar c " +
                "LEFT JOIN todo t ON c.todo_id = t.todo_id AND t.achieved_yn=1 " +
                "LEFT JOIN member_routine mr ON c.member_routine_id = mr.member_routine_id AND mr.achieved_yn=1 " +
                "WHERE c.member_id =:memberId AND YEAR(c.calendar_date)=:year AND MONTH(c.calendar_date)=:month " +
                "GROUP BY DAY(c.calendar_date);",
        resultSetMapping = "CalendarAchieveDtoMapping"
)
@SqlResultSetMapping(
        name = "CalendarAchieveDtoMapping",
        classes = @ConstructorResult(
                targetClass = CalendarAchieveDto.class,
                columns = {
                        @ColumnResult(name = "day", type = Integer.class),
                        @ColumnResult(name = "achieve", type = Integer.class)
                }
        )
)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Entity(name = "calendar")
public class Calendar {
    @Id
    @Column(name = "calendar_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long calendarId;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="member_id",nullable=false)
    private Member member;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="todo_id",nullable=true)
    private Todo todo;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="member_routine_id",nullable=true)
    private MemberRoutine memberRoutine;

    @Column(nullable = false)
    private LocalDate calendarDate;
}
