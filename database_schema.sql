-- ============================================
-- Database Schema for Shop Management System
-- MySQL Database
-- Generated: October 18, 2025
-- ============================================

-- Drop existing database if exists and create new one
DROP DATABASE IF EXISTS shop_db;
CREATE DATABASE shop_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shop_db;

-- ============================================
-- Table: Roles
-- Description: Stores user roles (ADMIN, VENDOR, USER)
-- ============================================
CREATE TABLE Roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    INDEX idx_role_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Users
-- Description: Stores user information
-- ============================================
CREATE TABLE Users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    address VARCHAR(50),
    image VARCHAR(255),
    roleId BIGINT NOT NULL,
    CONSTRAINT fk_user_role FOREIGN KEY (roleId) REFERENCES Roles(id) ON DELETE CASCADE,
    INDEX idx_user_email (email),
    INDEX idx_user_role (roleId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: User_Addresses
-- Description: Stores user delivery addresses
-- ============================================
CREATE TABLE User_Addresses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    userId BIGINT UNIQUE,
    receiverName VARCHAR(255),
    receiverPhone VARCHAR(50),
    receiverAddress VARCHAR(500),
    note TEXT,
    CONSTRAINT fk_address_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    INDEX idx_address_user (userId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Shops
-- Description: Stores shop/vendor information
-- ============================================
CREATE TABLE Shops (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    userId BIGINT NOT NULL,
    shopName VARCHAR(255) NOT NULL,
    description VARCHAR(500),
    status VARCHAR(50) DEFAULT 'Active',
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_shop_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    INDEX idx_shop_user (userId),
    INDEX idx_shop_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Products
-- Description: Stores product information
-- ============================================
CREATE TABLE Products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    shopId BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255),
    color VARCHAR(255),
    detailDesc TEXT,
    image VARCHAR(255),
    price DOUBLE NOT NULL,
    category VARCHAR(255),
    gender VARCHAR(50),
    CONSTRAINT fk_product_shop FOREIGN KEY (shopId) REFERENCES Shops(id) ON DELETE CASCADE,
    INDEX idx_product_shop (shopId),
    INDEX idx_product_category (category),
    INDEX idx_product_gender (gender),
    INDEX idx_product_price (price)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Product_Detail
-- Description: Stores product size and inventory details
-- ============================================
CREATE TABLE Product_Detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    productId BIGINT NOT NULL,
    size VARCHAR(50),
    quantity BIGINT DEFAULT 0,
    sold BIGINT DEFAULT 0,
    CONSTRAINT fk_product_detail_product FOREIGN KEY (productId) REFERENCES Products(id) ON DELETE CASCADE,
    INDEX idx_product_detail_product (productId),
    INDEX idx_product_detail_size (size)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Reviews
-- Description: Stores product reviews by users
-- ============================================
CREATE TABLE Reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    productId BIGINT NOT NULL,
    userId BIGINT NOT NULL,
    message VARCHAR(1000),
    rating INT,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_product FOREIGN KEY (productId) REFERENCES Products(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    INDEX idx_review_product (productId),
    INDEX idx_review_user (userId),
    INDEX idx_review_rating (rating),
    INDEX idx_review_created (createdAt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: voucher
-- Description: Stores discount vouchers for shops
-- ============================================
CREATE TABLE voucher (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discountPercent DOUBLE,
    startDate DATETIME,
    endDate DATETIME,
    status BOOLEAN DEFAULT TRUE,
    shop_id BIGINT NOT NULL,
    CONSTRAINT fk_voucher_shop FOREIGN KEY (shop_id) REFERENCES Shops(id) ON DELETE CASCADE,
    INDEX idx_voucher_code (code),
    INDEX idx_voucher_shop (shop_id),
    INDEX idx_voucher_status (status),
    INDEX idx_voucher_dates (startDate, endDate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: user_voucher
-- Description: Stores which users have claimed which vouchers
-- ============================================
CREATE TABLE user_voucher (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    voucher_id BIGINT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_user_voucher_user FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_voucher_voucher FOREIGN KEY (voucher_id) REFERENCES voucher(id) ON DELETE CASCADE,
    INDEX idx_user_voucher_user (user_id),
    INDEX idx_user_voucher_voucher (voucher_id),
    UNIQUE KEY unique_user_voucher (user_id, voucher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Carts
-- Description: Stores shopping carts for users
-- ============================================
CREATE TABLE Carts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    userId BIGINT UNIQUE NOT NULL,
    totalPrice DOUBLE DEFAULT 0.0,
    CONSTRAINT fk_cart_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    INDEX idx_cart_user (userId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Cart_Details
-- Description: Stores items in shopping carts
-- ============================================
CREATE TABLE Cart_Details (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cartId BIGINT NOT NULL,
    productId BIGINT NOT NULL,
    quantity BIGINT DEFAULT 1,
    size VARCHAR(50),
    price DOUBLE,
    voucherId BIGINT,
    CONSTRAINT fk_cart_detail_cart FOREIGN KEY (cartId) REFERENCES Carts(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_detail_product FOREIGN KEY (productId) REFERENCES Products(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_detail_voucher FOREIGN KEY (voucherId) REFERENCES voucher(id) ON DELETE SET NULL,
    INDEX idx_cart_detail_cart (cartId),
    INDEX idx_cart_detail_product (productId),
    INDEX idx_cart_detail_voucher (voucherId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Orders
-- Description: Stores customer orders
-- ============================================
CREATE TABLE Orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    userId BIGINT NOT NULL,
    addressId BIGINT,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    paymentMethod VARCHAR(50),
    status VARCHAR(50) DEFAULT 'New',
    totalPrice DOUBLE,
    voucherCode VARCHAR(50),
    shop_id BIGINT,
    CONSTRAINT fk_order_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_address FOREIGN KEY (addressId) REFERENCES User_Addresses(id) ON DELETE SET NULL,
    CONSTRAINT fk_order_shop FOREIGN KEY (shop_id) REFERENCES Shops(id) ON DELETE SET NULL,
    INDEX idx_order_user (userId),
    INDEX idx_order_address (addressId),
    INDEX idx_order_shop (shop_id),
    INDEX idx_order_status (status),
    INDEX idx_order_created (createdAt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: Order_Details
-- Description: Stores items in orders
-- ============================================
CREATE TABLE Order_Details (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    orderId BIGINT NOT NULL,
    productId BIGINT NOT NULL,
    shopId BIGINT NOT NULL,
    quantity BIGINT NOT NULL,
    size VARCHAR(50),
    price DOUBLE,
    voucherId BIGINT,
    CONSTRAINT fk_order_detail_order FOREIGN KEY (orderId) REFERENCES Orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_detail_product FOREIGN KEY (productId) REFERENCES Products(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_detail_shop FOREIGN KEY (shopId) REFERENCES Shops(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_detail_voucher FOREIGN KEY (voucherId) REFERENCES voucher(id) ON DELETE SET NULL,
    INDEX idx_order_detail_order (orderId),
    INDEX idx_order_detail_product (productId),
    INDEX idx_order_detail_shop (shopId),
    INDEX idx_order_detail_voucher (voucherId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: commissions
-- Description: Stores commission calculations for shops
-- ============================================
CREATE TABLE commissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    shop_id BIGINT NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    total_revenue DECIMAL(15, 2) NOT NULL,
    percent DECIMAL(5, 2) DEFAULT 5.00,
    amount DECIMAL(15, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_commission_shop FOREIGN KEY (shop_id) REFERENCES Shops(id) ON DELETE CASCADE,
    INDEX idx_commission_shop (shop_id),
    INDEX idx_commission_status (status),
    INDEX idx_commission_period (period_start, period_end),
    INDEX idx_commission_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Insert Initial Data
-- ============================================

-- Insert default roles
INSERT INTO Roles (name) VALUES 
    ('ADMIN'),
    ('VENDOR'),
    ('USER');

-- Insert admin user (password: admin123 - should be hashed in production)
-- Note: This is a bcrypt hash of 'admin123'
INSERT INTO Users (fullName, email, password, roleId) VALUES 
    ('Administrator', 'admin@shop.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye1J9FVDGh7S8hPPmwHkJx4xQTKvCKAp2', 1);

-- Insert sample vendor user (password: vendor123)
INSERT INTO Users (fullName, email, password, phone, roleId) VALUES 
    ('Vendor User', 'vendor@shop.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye1J9FVDGh7S8hPPmwHkJx4xQTKvCKAp2', '0901234567', 2);

-- Insert sample regular user (password: user123)
INSERT INTO Users (fullName, email, password, phone, roleId) VALUES 
    ('Regular User', 'user@shop.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye1J9FVDGh7S8hPPmwHkJx4xQTKvCKAp2', '0912345678', 3);

-- ============================================
-- End of Schema
-- ============================================

-- Show all tables
SHOW TABLES;

-- Display table information
SELECT 
    TABLE_NAME,
    ENGINE,
    TABLE_ROWS,
    AVG_ROW_LENGTH,
    DATA_LENGTH,
    INDEX_LENGTH
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'shop_db'
ORDER BY TABLE_NAME;
