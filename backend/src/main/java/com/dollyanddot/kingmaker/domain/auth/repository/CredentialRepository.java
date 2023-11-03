package com.dollyanddot.kingmaker.domain.auth.repository;

import com.dollyanddot.kingmaker.domain.auth.domain.Credential;
import com.dollyanddot.kingmaker.domain.auth.domain.Provider;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CredentialRepository extends JpaRepository<Credential, Long> {
    Optional<Credential> findByEmailAndProvider(String email, Provider provider);
}
