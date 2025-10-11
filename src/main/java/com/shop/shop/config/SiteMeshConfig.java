package com.shop.shop.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.shop.shop.config.filter.CustomSiteMeshFilter;

@Configuration
public class SiteMeshConfig {

    @Bean
    public FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<CustomSiteMeshFilter> filter = new FilterRegistrationBean<>();
        filter.setFilter(new CustomSiteMeshFilter());
        filter.addUrlPatterns("/*");
        filter.setName("sitemesh");
        return filter;
    }
}
