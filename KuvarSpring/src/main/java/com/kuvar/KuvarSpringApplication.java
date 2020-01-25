package com.kuvar;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan("model")
public class KuvarSpringApplication {

	public static void main(String[] args) {
		SpringApplication.run(KuvarSpringApplication.class, args);
	}

}
