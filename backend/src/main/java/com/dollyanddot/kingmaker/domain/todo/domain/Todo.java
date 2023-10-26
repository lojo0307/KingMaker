package com.dollyanddot.kingmaker.domain.todo.domain;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.time.LocalDateTime;

@NamedNativeQueries({
        @NamedNativeQuery(
                name = "getTodoList",
                query = "select * from todo t"
                        + " where DATE(t.start_at)<=:targetDate and DATE(t.end_at)>=:targetDate and t.member_id=:memberId",
                resultSetMapping = "getTodoList"
        ),
        @NamedNativeQuery(
                name = "getTodoStreak",
                query = "WITH RECURSIVE DateRange AS (" +
                        "SELECT DATE(CONCAT(:targetMonth, '-01')) AS target_date " +
                        "UNION ALL " +
                        "SELECT DATE_ADD(target_date, INTERVAL 1 DAY) " +
                        "FROM DateRange " +
                        "WHERE DATE_ADD(target_date, INTERVAL 1 DAY) <= LAST_DAY(DATE(CONCAT(:targetMonth, '-01')))" +
                        ") " +
                        "SELECT " +
                        "DAY(dr.target_date) AS day," +
                        "COUNT(t.todo_id) AS level " +
                        "FROM DateRange dr " +
                        "LEFT JOIN todo t ON dr.target_date BETWEEN date(t.start_at) AND date(t.end_at) AND t.member_id=:memberId " +
                        "GROUP BY dr.target_date ORDER BY day;",
                resultSetMapping = "getTodoStreak"
        ),
})
@SqlResultSetMapping(
        name = "getTodoList",
        classes = @ConstructorResult(
                targetClass = CalendarStreakResDto.class,
                columns = {
                        @ColumnResult(name = "todo_id", type = Long.class),
                        @ColumnResult(name = "todo_nm", type = String.class),
                        @ColumnResult(name = "category_id", type = Long.class),
                        @ColumnResult(name = "start_at", type = LocalDateTime.class),
                        @ColumnResult(name = "end_at", type = LocalDateTime.class),
                        @ColumnResult(name = "important_yn", type = byte.class),
                        @ColumnResult(name = "achieved_yn", type = byte.class),
                        @ColumnResult(name = "monster_cd",type= Integer.class)
                }
        )
)
@SqlResultSetMapping(
        name = "getTodoStreak",
        classes = @ConstructorResult(
                targetClass = CalendarStreakResDto.class,
                columns = {
                        @ColumnResult(name = "day", type = Integer.class),
                        @ColumnResult(name = "level", type = Integer.class)
                }
        )
)

@Data
@Entity(name="todo")
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Todo extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long todoId;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="member_id",nullable=false)
    private Member member;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="category_id",nullable=false)
    private Category category;

    @Column(nullable=true)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
    private LocalDateTime startAt;

    @Column(nullable=true)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
    private LocalDateTime endAt;

    @Column(nullable=false)
    private String todoNm;

    @Column(nullable=true)
    private String todoDetail;

    @Column(nullable=true)
    private String todoPlace;

    @Column(nullable=false)
    private boolean importantYn;

    @Column(nullable=false)
    private boolean achievedYn;

    @Column(nullable=false)
    private int monsterCd;

    public void update(Category category, String todoNm, String todoDetail, String todoPlace, boolean importantYn, LocalDateTime startAt, LocalDateTime endAt){
        this.category = category;
        this.todoNm = todoNm;
        this.todoDetail = todoDetail;
        this.todoPlace = todoPlace;
        this.importantYn = importantYn;
        this.startAt = startAt;
        this.endAt = endAt;
    }
}
