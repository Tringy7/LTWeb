-- Database schema update for voucher management feature
-- This script ensures the voucher table supports system vouchers (shop_id can be null)

-- Check if voucher table exists and update it to allow null shop_id
-- Run this script manually in your MySQL database if you encounter the shop_id cannot be null error

USE shop;

-- Update the voucher table to allow null shop_id for system vouchers
ALTER TABLE voucher MODIFY COLUMN shop_id BIGINT NULL;

-- Add an index for better performance on system voucher queries
CREATE INDEX idx_voucher_shop_id_null ON voucher (shop_id);
CREATE INDEX idx_voucher_status ON voucher (status);
CREATE INDEX idx_voucher_dates ON voucher (start_date, end_date);

-- Add some sample system vouchers for testing (optional)
-- Note: These will be inserted only if they don't already exist
INSERT IGNORE INTO voucher (code, discount_percent, start_date, end_date, status, shop_id)
VALUES 
('WELCOME10', 10.0, '2025-01-01 00:00:00', '2025-12-31 23:59:59', 'ACTIVE', NULL),
('NEWUSER15', 15.0, '2025-01-01 00:00:00', '2025-06-30 23:59:59', 'ACTIVE', NULL),
('HOLIDAY20', 20.0, '2025-12-01 00:00:00', '2025-12-31 23:59:59', 'ACTIVE', NULL);
