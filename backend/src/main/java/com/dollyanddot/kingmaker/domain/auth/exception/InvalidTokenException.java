package com.dollyanddot.kingmaker.domain.auth.exception;

import org.springframework.security.oauth2.jwt.JwtException;

public class InvalidTokenException extends JwtException {
    public InvalidTokenException() {
        super("유효하지 않은 토큰입니다.");
    }
}
