package com.dollyanddot.kingmaker.domain.routine.domain;

import com.dollyanddot.kingmaker.domain.util.domain.Category;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "routine")
public class Routine {

  @Id
  @Column(name = "routine_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name="category_id")
  private Category category;

  @Column
  private String period;

  @Column
  private String routineName;

  @Column(name = "routine_important")
  private boolean isImportant;

  @Column(name = "routine_detail")
  private String detail;

  @Column
  private LocalDateTime startAt;

  @Column
  private LocalDateTime endAt;

  @Column
  private int monsterCd;






}
