package com.dollyanddot.kingmaker.domain.reward.repository;

import com.dollyanddot.kingmaker.domain.todo.domain.Todo;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import javax.transaction.Transactional;

import static com.dollyanddot.kingmaker.domain.reward.domain.QMemberReward.memberReward;

@RequiredArgsConstructor
public class MemberRewardRepositoryCustomImpl implements MemberRewardRepositoryCustom{
    private final JPAQueryFactory queryFactory;

    @Transactional
    public void achieveMemberReward(Long memberId,int rewardId){
        queryFactory
                .update(memberReward)
                .set(memberReward.achievedYn,true)
                .where(memberReward.member.memberId.eq(memberId).and(memberReward.reward.rewardId.eq(rewardId)))
                .execute();
        return;
    }
}
