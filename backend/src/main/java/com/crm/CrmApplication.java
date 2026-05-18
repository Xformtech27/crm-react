    package com.crm;

    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import org.springframework.boot.builder.SpringApplicationBuilder;
    import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
    import org.springframework.scheduling.annotation.EnableAsync;

    @SpringBootApplication
    @EnableAsync
    public class CrmApplication extends SpringBootServletInitializer {  // ← EXTEND this class

        @Override
        protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
            // Tell Tomcat where to find the main Spring Boot configuration
            return application.sources(CrmApplication.class);
        }

        public static void main(String[] args) {
            SpringApplication.run(CrmApplication.class, args);
        }
    }