package com.dollyanddot.kingmaker.domain.todo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoDetailResDto {
    String todoNm;
    String todoPlace;
    String todoDetail;
    Long categoryId;
    LocalDateTime startAt;
    LocalDateTime endAt;
    byte importantYn;
    byte achievedYn;
}
