package com.dollyanddot.kingmaker.domain.todo.repository;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.querydsl.core.types.Projections;
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

    @Override
    public CategoryCntResDto getMinTodoCategory(Long memberId) {
        try {
            CategoryCntResDto c = queryFactory.select(
                    Projections.fields(CategoryCntResDto.class,
                        todo.category.id.as("categoryId"),
                        todo.modifiedAt.as("modifiedAt"),
                        todo.category.count().as("cnt")
                    )
                )
                .from(todo)
                .where(todo.achievedYn.eq(true)
                    .and(todo.member.memberId.eq(memberId)))
                .groupBy(todo.category)
                .orderBy(todo.category.count().asc(), todo.modifiedAt.desc())
                .limit(1)
                .fetchOne();

            return c;
        } catch (NullPointerException e) {
            return null;
        }

    }

    @Override
    public CategoryCntResDto getMaxTodoCategory(Long memberId) {
        try {
            CategoryCntResDto c = queryFactory.select(
                Projections.fields(CategoryCntResDto.class,
                    todo.category.id.as("categoryId"),
                    todo.modifiedAt.as("modifiedAt"),
                    todo.category.count().as("cnt")
                )
            )
            .from(todo)
            .where(todo.achievedYn.eq(true)
                .and(todo.member.memberId.eq(memberId)))
            .groupBy(todo.category)
            .orderBy(todo.category.count().desc(), todo.modifiedAt.desc())
            .limit(1)
            .fetchOne();

            return c;
        } catch (NullPointerException e) {
            return null;
        }
    }
}