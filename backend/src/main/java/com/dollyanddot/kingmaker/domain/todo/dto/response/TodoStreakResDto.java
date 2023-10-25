package com.dollyanddot.kingmaker.domain.todo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TodoStreakResDto {
    int day;
    int level;
}
