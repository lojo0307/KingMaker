package com.dollyanddot.kingmaker.domain.auth.exception;

import org.springframework.security.oauth2.jwt.JwtException;

public class TokenNotFoundException extends JwtException {
    public TokenNotFoundException() {
        super("요청에 토큰이 존재하지 않습니다.");
    }
}
