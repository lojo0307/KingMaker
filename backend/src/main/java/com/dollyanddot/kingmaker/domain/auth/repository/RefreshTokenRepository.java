package com.dollyanddot.kingmaker.domain.auth.repository;

import com.dollyanddot.kingmaker.domain.auth.domain.RefreshToken;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface RefreshTokenRepository extends CrudRepository<RefreshToken, String> {
}
