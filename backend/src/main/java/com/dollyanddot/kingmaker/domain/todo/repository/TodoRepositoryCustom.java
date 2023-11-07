package com.dollyanddot.kingmaker.domain.todo.repository;

import java.time.LocalDateTime;
import java.util.List;

public interface TodoRepositoryCustom {
    List<Long> countCategoryId(Long memberId);

    LocalDateTime findMostRecentAchieved();
}
