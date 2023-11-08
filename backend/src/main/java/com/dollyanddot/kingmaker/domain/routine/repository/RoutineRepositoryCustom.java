package com.dollyanddot.kingmaker.domain.routine.repository;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import java.time.LocalDateTime;

public interface RoutineRepositoryCustom {
    LocalDateTime findMostRecentAchieved();

    CategoryCntResDto getMinRoutineCategory(Long memberId);

    CategoryCntResDto getMaxRoutineCategory(Long memberId);
}
