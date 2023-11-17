package com.dollyanddot.kingmaker.domain.category.repository;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {

}
