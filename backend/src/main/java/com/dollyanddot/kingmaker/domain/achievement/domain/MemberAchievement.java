package com.dollyanddot.kingmaker.domain.achievement.domain;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity(name = "member_achievement")
public class MemberAchievement extends BaseTimeEntity {

    @Id
    @Column(name = "member_achievement_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "achievement_id", nullable = false)
    private Achievement achievement;

}
