package com.dollyanddot.kingmaker.domain.util.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Entity(name = "category")
public class Category {

  @Id
  @Column(name = "category_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column
  private String name;
}
