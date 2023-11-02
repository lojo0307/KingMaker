package com.dollyanddot.kingmaker.domain.auth.domain;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum Role {
    GUEST("ROLE_GUEST"), USER("ROLE_USER");
   private final String key;
}
