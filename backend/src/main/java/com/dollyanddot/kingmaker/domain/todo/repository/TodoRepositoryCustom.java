package com.dollyanddot.kingmaker.domain.todo.repository;

import java.util.List;

public interface TodoRepositoryCustom {
    List<Long> countCategoryId(Long memberId);
}
