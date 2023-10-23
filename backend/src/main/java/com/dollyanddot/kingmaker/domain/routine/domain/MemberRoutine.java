package com.dollyanddot.kingmaker.domain.routine.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Entity(name = "member_routine")
public class MemberRoutine extends BasetimeEntity{

  @Id
  @Column(name = "member_routine_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

//  @ManyToOne(fetch = FetchType.LAZY)
//  @Column(name = "member_id")
//  private Member member;

  @ManyToOne(fetch = FetchType.LAZY)
  @Column(name = "routine_id")
  private Routine routine;
}
