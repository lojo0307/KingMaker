package com.dollyanddot.kingmaker.domain.kingdom.repository;

import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface KingdomRepository extends JpaRepository<Kingdom, Long> {

}
