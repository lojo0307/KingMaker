package com.dollyanddot.kingmaker.global.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

@Slf4j
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

  @Bean
  protected SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
    httpSecurity
        .httpBasic().disable()
        .csrf().disable()
        .formLogin().disable()
        .headers()
        .frameOptions()
        .sameOrigin()
        .and()
        .cors();

    httpSecurity
        .sessionManagement()
        .sessionCreationPolicy(SessionCreationPolicy.STATELESS);

    httpSecurity
        .authorizeRequests()
        .antMatchers(HttpMethod.OPTIONS).permitAll()
//        .antMatchers("/api/auth/**").permitAll()
        .antMatchers("/**").permitAll()
        .anyRequest().authenticated();

    return httpSecurity.build();
  }
}