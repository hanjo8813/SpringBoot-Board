package com.example.boardbackend.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfiguration implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins("http://localhost:3000", "https://board.hanjo.xyz")
                .allowedMethods(
                        HttpMethod.POST.name(),
                        HttpMethod.GET.name(),
                        HttpMethod.DELETE.name(),
                        HttpMethod.PATCH.name()
                );
    }
}
