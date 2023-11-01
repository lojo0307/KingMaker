package com.dollyanddot.kingmaker.domain.routine.domain;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
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
  @JoinColumn(name="category_id", nullable = false)
  private Category category;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "member_id", nullable = false)
  private Member member;

  @Column(name = "routine_nm", nullable = false)
  private String name;

  @Column(name = "routine_detail")
  private String detail;

  @Column(nullable = false)
  private String period;

  @Column(nullable = false)
  private boolean importantYn;

  @Column(nullable = false)
  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
  private LocalDateTime startAt;

  @Column
  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
  private LocalDateTime endAt;

  @Column
  private LocalDateTime registerAt;

  @Column
  private Integer registerDay;

  public void updateRegisterAt(LocalDateTime nextDate){
    this.registerAt = nextDate;
  }

  public void updateRegisterDay(int nextDay){
    this.registerDay = nextDay;
  }

  public void update(Category category, Member member, String name, String detail, String period, boolean importantYn, LocalDateTime startAt, LocalDateTime endAt){
    this.category = category;
    this.member = member;
    this.name = name;
    this.detail = detail;
    this.period = period;
    this.importantYn = importantYn;
    this.startAt = startAt;
    this.endAt = endAt;
  }
}
