package com.dollyanddot.kingmaker.domain.routine.domain;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Entity(name = "member_routine")
public class MemberRoutine extends BaseTimeEntity {

  @Id
  @Column(name = "member_routine_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @OnDelete(action= OnDeleteAction.CASCADE)
  @JoinColumn(name = "member_id", nullable = false)
  private Member member;

  @ManyToOne(fetch = FetchType.LAZY)
  @OnDelete(action= OnDeleteAction.CASCADE)
  @JoinColumn(name = "routine_id", nullable = false)
  private Routine routine;

  @Column(nullable = false)
  private boolean achievedYn;
  
  @Column(nullable = false)
  private int monsterCd;
}
