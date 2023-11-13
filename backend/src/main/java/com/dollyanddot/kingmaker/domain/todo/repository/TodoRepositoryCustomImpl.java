package com.dollyanddot.kingmaker.domain.todo.repository;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.ArrayList;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import lombok.extern.slf4j.Slf4j;

import static com.dollyanddot.kingmaker.domain.todo.domain.QTodo.todo;

@Slf4j
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
    public List<CategoryCntResDto> getMaxTodoCategory(Long memberId) {
        try {
            List<CategoryCntResDto> categoryCntResDtoList = queryFactory.select(
                Projections.fields(CategoryCntResDto.class,
                    todo.category.id.as("categoryId"),
                    todo.category.id.count().as("cnt"),
                    todo.modifiedAt.as("modifiedAt")
                )
            )
            .from(todo)
            .where(todo.achievedYn.eq(true)
                .and(todo.member.memberId.eq(memberId)),
                todo.category.id.ne(6L))
            .groupBy(todo.category.id)
            .orderBy(todo.category.id.count().desc(), todo.modifiedAt.desc())
            .fetch();

            if(categoryCntResDtoList.size()==0) {
                CategoryCntResDto c = CategoryCntResDto.builder().categoryId(-1L).cnt(-1L).build();
                categoryCntResDtoList.add(c);
            }
            return categoryCntResDtoList;

        } catch (NullPointerException e) {
            log.info("todo null");
            List<CategoryCntResDto> categoryCntResDtoList = new ArrayList<>();
            CategoryCntResDto c = CategoryCntResDto.builder().categoryId(-1L).cnt(-1L).build();
            categoryCntResDtoList.add(c);
            return categoryCntResDtoList;
        }
    }
}