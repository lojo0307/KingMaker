package com.dollyanddot.kingmaker.domain.routine.repository;

import static com.dollyanddot.kingmaker.domain.routine.domain.QMemberRoutine.memberRoutine;
import static com.dollyanddot.kingmaker.domain.todo.domain.QTodo.todo;

import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    public List<CategoryCntResDto> getMaxRoutineCategory(Long memberId) {
        try {
            List<CategoryCntResDto> categoryCntResDtoList = queryFactory.select(
                    Projections.fields(CategoryCntResDto.class,
                        memberRoutine.routine.category.id.as("categoryId"),
                        memberRoutine.routine.category.id.count().as("cnt"),
                        memberRoutine.modifiedAt.as("modifiedAt")
                    )
                )
                .from(memberRoutine)
                .where(memberRoutine.achievedYn.eq(true)
                    .and(memberRoutine.member.memberId.eq(memberId)),
                    memberRoutine.routine.category.id.ne(6L))
                .groupBy(memberRoutine.routine.category.id)
                .orderBy(memberRoutine.routine.category.id.count().desc(), todo.modifiedAt.desc())
                .fetch();

            if(categoryCntResDtoList.size()==0) {
                CategoryCntResDto c = CategoryCntResDto.builder().categoryId(-1L).cnt(-1L).build();
                categoryCntResDtoList.add(c);
            }
            return categoryCntResDtoList;

        } catch (NullPointerException e) {
            log.info("routine null");
            List<CategoryCntResDto> categoryCntResDtoList = new ArrayList<>();
            CategoryCntResDto c = CategoryCntResDto.builder().categoryId(-1L).cnt(-1L).build();
            categoryCntResDtoList.add(c);
            return categoryCntResDtoList;
        }
    }
}
