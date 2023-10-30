package com.dollyanddot.kingmaker;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class KingmakerApplication {

  public static void main(String[] args) {
    SpringApplication.run(KingmakerApplication.class, args);
  }

}
