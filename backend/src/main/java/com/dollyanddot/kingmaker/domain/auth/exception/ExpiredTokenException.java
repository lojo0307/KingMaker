package com.dollyanddot.kingmaker.domain.auth.exception;

import org.springframework.security.oauth2.jwt.JwtException;

public class ExpiredTokenException extends JwtException {
    public ExpiredTokenException() {
        super("만료된 토큰입니다.");
    }
}
