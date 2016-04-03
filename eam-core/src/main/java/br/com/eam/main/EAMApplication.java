package br.com.eam.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configuration
@EnableAutoConfiguration
@EnableConfigurationProperties
@EnableWebMvc
@ComponentScan(basePackages = {"br.com.eam"})
public class EAMApplication {
	
	private static ConfigurableApplicationContext context;
	
	public static ConfigurableApplicationContext getContext(){
		return context;
	}
	
	public static void main(String[] args) throws Exception {
		EAMApplication.context = SpringApplication.run(
				EAMApplication.class, args);

	}

}
