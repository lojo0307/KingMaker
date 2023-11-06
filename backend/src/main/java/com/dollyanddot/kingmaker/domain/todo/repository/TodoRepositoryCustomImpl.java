package com.dollyanddot.kingmaker.domain.todo.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

import static com.dollyanddot.kingmaker.domain.todo.domain.QTodo.todo;


@RequiredArgsConstructor
public class TodoRepositoryCustomImpl {
    private final JPAQueryFactory queryFactory;

    List<Long> countCategoryId(Long memberId){
        return queryFactory.select(todo.category.id.count())
                .from(todo)
                .where(todo.achievedYn.eq(true).and(todo.member.memberId.eq(memberId)))
                .groupBy(todo.category.id)
                .orderBy(todo.category.id.asc())
                .fetch();
    }
}