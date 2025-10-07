package com.shop.shop.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
                // layout cho admin
                .addDecoratorPath("/admin", "/admin/layout.jsp")
                .addDecoratorPath("/admin/*", "/admin/layout.jsp")
                // layout cho client
                .addDecoratorPath("/*", "/client/layout.jsp");
    }
}
