package com.dollyanddot.kingmaker.domain.todo.domain;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.todo.dto.response.TodoListResDto;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity(name="todo")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@NamedNativeQueries({
        @NamedNativeQuery(
                name = "getTodoList",
                query = "select * from todo t"
                        + " where DATE(t.start_at)<=:targetDate and DATE(t.end_at)>=:targetDate",
                resultSetMapping = "getTodoList"
        ),
})
@SqlResultSetMapping(
        name = "getTodoList",
        classes = @ConstructorResult(
                targetClass = TodoListResDto.class,
                columns = {
                        @ColumnResult(name = "todo_id", type = Long.class),
                        @ColumnResult(name = "todo_nm", type = String.class),
                        @ColumnResult(name = "category_id", type = Long.class),
                        @ColumnResult(name = "start_at", type = LocalDateTime.class),
                        @ColumnResult(name = "end_at", type = LocalDateTime.class),
                        @ColumnResult(name = "important_yn", type = byte.class),
                        @ColumnResult(name = "achieved_yn", type = byte.class)
                }
        )
)

public class Todo {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long todoId;

//    @ManyToOne(fetch=FetchType.LAZY)
//    @OnDelete(action= OnDeleteAction.CASCADE)
//    @JoinColumn(name="member_id",nullable=false)
//    private Member member;

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
}
