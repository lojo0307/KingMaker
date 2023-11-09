package com.dollyanddot.kingmaker.domain.auth;

import com.dollyanddot.kingmaker.domain.auth.exception.*;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class ExceptionHandlerFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        try {
            filterChain.doFilter(request, response);
        } catch (InvalidTokenException e) {
            setResponse(response, JwtExceptionList.INVALID_TOKEN);
        } catch (ExpiredTokenException e) {
            setResponse(response, JwtExceptionList.EXPIRED_TOKEN);
        } catch (TokenNotFoundException e) {
            setResponse(response, JwtExceptionList.TOKEN_NOTFOUND);
        } catch (Exception e) {
            log.error("예외 발생");
            setResponse(response, JwtExceptionList.TOKEN_EXCEPTION);
        }
    }

    private void setResponse(HttpServletResponse response, JwtExceptionList jwtException) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(jwtException.getHttpServletResponse());

        JSONObject responseJson = new JSONObject();
        responseJson.put("message", jwtException.getMessage());
        responseJson.put("code", jwtException.getCode());

        response.getWriter().print(responseJson);
    }
}
