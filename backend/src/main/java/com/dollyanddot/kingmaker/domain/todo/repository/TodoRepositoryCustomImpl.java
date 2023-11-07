package com.dollyanddot.kingmaker.domain.todo.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import static com.dollyanddot.kingmaker.domain.todo.domain.QTodo.todo;


@RequiredArgsConstructor
public class TodoRepositoryCustomImpl implements TodoRepositoryCustom{
    private final JPAQueryFactory queryFactory;

    public List<Long> countCategoryId(Long memberId){
        return queryFactory.select(todo.category.id)
                .from(todo)
                .where(todo.achievedYn.eq(true).and(todo.member.memberId.eq(memberId)))
                .groupBy(todo.category.id)
                .orderBy(todo.category.id.asc())
                .fetch();
    }

    @Override
    public LocalDateTime findMostRecentAchieved() {
        return queryFactory
                .select(todo.modifiedAt)
                .from(todo)
                .where(todo.achievedYn.eq(true))
                .orderBy(todo.modifiedAt.desc())
                .fetchFirst();
    }
}