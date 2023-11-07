package com.dollyanddot.kingmaker.global.config;

import com.dollyanddot.kingmaker.domain.auth.JwtAuthenticationFilter;
import com.dollyanddot.kingmaker.domain.auth.repository.CredentialRepository;
import com.dollyanddot.kingmaker.domain.auth.repository.RefreshTokenRepository;
import com.dollyanddot.kingmaker.domain.auth.service.JwtService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutFilter;

@Slf4j
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

  private final JwtService jwtService;
  private final CredentialRepository credentialRepository;
  private final RefreshTokenRepository refreshTokenRepository;

  @Bean
  protected SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
    httpSecurity
        .httpBasic().disable()
        .csrf().disable()
        .formLogin().disable()
        .headers().frameOptions().disable()

        .and()
        .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)

        .and()
        .authorizeRequests()
        .antMatchers(HttpMethod.OPTIONS).permitAll()
//        .antMatchers("/api/auth/**").permitAll()
        .antMatchers("/**").permitAll()
        .anyRequest().authenticated()

        .and()
        .addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

    return httpSecurity.build();
  }

  @Bean
  public JwtAuthenticationFilter jwtAuthenticationFilter() {
    JwtAuthenticationFilter jwtAuthenticationFilter = new JwtAuthenticationFilter(jwtService, credentialRepository, refreshTokenRepository);
    return jwtAuthenticationFilter;
  }
}