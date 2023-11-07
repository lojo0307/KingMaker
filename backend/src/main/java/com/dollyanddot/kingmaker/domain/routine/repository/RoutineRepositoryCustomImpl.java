package com.dollyanddot.kingmaker.domain.routine.repository;

import static com.dollyanddot.kingmaker.domain.routine.domain.QMemberRoutine.memberRoutine;
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
}
