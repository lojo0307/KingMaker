package com.dollyanddot.kingmaker.domain.routine.repository;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import java.time.LocalDateTime;
import java.util.List;

public interface RoutineRepositoryCustom {
    LocalDateTime findMostRecentAchieved();

    List<CategoryCntResDto> getMaxRoutineCategory(Long memberId);
}
