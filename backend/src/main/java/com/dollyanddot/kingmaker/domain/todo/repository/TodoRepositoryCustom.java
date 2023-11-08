package com.dollyanddot.kingmaker.domain.todo.repository;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import java.time.LocalDateTime;
import java.util.List;

public interface TodoRepositoryCustom {
    List<Long> countCategoryId(Long memberId);

    LocalDateTime findMostRecentAchieved();

    CategoryCntResDto getMinTodoCategory(Long memberId);

    CategoryCntResDto getMaxTodoCategory(Long memberId);
}
