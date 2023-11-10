package com.dollyanddot.kingmaker.domain.todo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TodoListResDto {
    Long todoId;
    String todoNm;
    Long categoryId;
    LocalDateTime startAt;
    LocalDateTime endAt;
    byte importantYn;
    byte achievedYn;
}