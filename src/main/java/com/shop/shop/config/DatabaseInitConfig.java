package com.shop.shop.config;

import javax.sql.DataSource;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class DatabaseInitConfig {

    @Bean
    @Order(1)
    public CommandLineRunner initDatabase(DataSource dataSource) {
        return arguments -> {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
            
            try {
                // Check if voucher table exists and if shop_id column allows NULL
                log.info("Checking voucher table schema...");
                
                // Try to update the voucher table to allow NULL shop_id
                String alterTableSQL = "ALTER TABLE voucher MODIFY COLUMN shop_id BIGINT NULL";
                jdbcTemplate.execute(alterTableSQL);
                log.info("Updated voucher table to allow NULL shop_id for system vouchers");
                
                // Add useful indexes for better performance
                try {
                    jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_voucher_shop_id_null ON voucher (shop_id)");
                    jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_voucher_status ON voucher (status)");
                    jdbcTemplate.execute("CREATE INDEX IF NOT EXISTS idx_voucher_dates ON voucher (start_date, end_date)");
                    log.info("Created performance indexes for voucher table");
                } catch (Exception e) {
                    log.warn("Could not create indexes (they might already exist): {}", e.getMessage());
                }
                
            } catch (Exception e) {
                log.error("Failed to initialize voucher table schema: {}", e.getMessage());
                // This is not critical for application startup, so we continue
            }
        };
    }
}
