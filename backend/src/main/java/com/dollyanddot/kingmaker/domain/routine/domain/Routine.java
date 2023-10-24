package com.dollyanddot.kingmaker.domain.routine.domain;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
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

@Getter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "routine")
public class Routine extends BaseTimeEntity {

  @Id
  @Column(name = "routine_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name="category_id")
  private Category category;

  @Column
  private String routineName;

  @Column(name = "routine_detail")
  private String detail;
}
