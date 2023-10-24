package com.dollyanddot.kingmaker.domain.routine.domain;

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
  @JoinColumn(name = "routine_registration_id")
  private RoutineRegistraion routineRegistraion;

  @Column
  private boolean achievedYn;
  
  @Column
  private int monsterCd;
}
