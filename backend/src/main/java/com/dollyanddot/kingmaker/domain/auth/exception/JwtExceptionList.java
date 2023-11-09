package com.dollyanddot.kingmaker.domain.auth.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import javax.servlet.http.HttpServletResponse;

@Getter
@AllArgsConstructor
public enum JwtExceptionList {
    EXPIRED_TOKEN(HttpServletResponse.SC_UNAUTHORIZED, 1707,  "만료된 토큰입니다."),
    INVALID_TOKEN(HttpServletResponse.SC_BAD_REQUEST, 1708, "유효하지 않은 토큰입니다."),

    TOKEN_NOTFOUND(HttpServletResponse.SC_UNAUTHORIZED, 1709, "요청에 토큰이 존재하지 않습니다."),
    TOKEN_EXCEPTION(HttpServletResponse.SC_EXPECTATION_FAILED, 1710, "토큰 에러가 발생했습니다.");

    private final int httpServletResponse;
    private final int code;
    private final String message;
}
