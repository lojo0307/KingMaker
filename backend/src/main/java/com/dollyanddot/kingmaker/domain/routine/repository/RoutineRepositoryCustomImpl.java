package com.dollyanddot.kingmaker.domain.routine.repository;

import static com.dollyanddot.kingmaker.domain.routine.domain.QMemberRoutine.memberRoutine;
import static com.dollyanddot.kingmaker.domain.todo.domain.QTodo.todo;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@RequiredArgsConstructor
public class RoutineRepositoryCustomImpl implements RoutineRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public LocalDateTime findMostRecentAchieved() {
        return queryFactory
                .select(memberRoutine.modifiedAt)
                .from(memberRoutine)
                .where(memberRoutine.achievedYn.eq(true))
                .orderBy(memberRoutine.modifiedAt.desc())
                .fetchFirst();
    }

    public CategoryCntResDto getMinRoutineCategory(Long memberId) {
        try {
        CategoryCntResDto c = queryFactory.select(
                Projections.fields(CategoryCntResDto.class,
                    memberRoutine.routine.category.id.as("categoryId"),
                    memberRoutine.modifiedAt.as("modifiedAt"),
                    memberRoutine.routine.category.count().as("cnt")
                )
            )
            .from(memberRoutine)
            .where(memberRoutine.achievedYn.eq(true)
                .and(memberRoutine.member.memberId.eq(memberId)))
            .groupBy(memberRoutine.routine.category)
            .orderBy(memberRoutine.routine.category.count().asc(), todo.modifiedAt.desc())
            .limit(1)
            .fetchOne();

            return c;
        } catch (NullPointerException e) {
            return null;
        }
    }

    public CategoryCntResDto getMaxRoutineCategory(Long memberId) {
        try {
            CategoryCntResDto c = queryFactory.select(
                    Projections.fields(CategoryCntResDto.class,
                        memberRoutine.routine.category.id.as("categoryId"),
                        memberRoutine.modifiedAt.as("modifiedAt"),
                        memberRoutine.routine.category.count().as("cnt")
                    )
                )
                .from(memberRoutine)
                .where(memberRoutine.achievedYn.eq(true)
                    .and(memberRoutine.member.memberId.eq(memberId)))
                .groupBy(memberRoutine.routine.category)
                .orderBy(memberRoutine.routine.category.count().desc(), todo.modifiedAt.desc())
                .limit(1)
                .fetchOne();

            return c;
        } catch (NullPointerException e) {
            return null;
        }
    }
}
