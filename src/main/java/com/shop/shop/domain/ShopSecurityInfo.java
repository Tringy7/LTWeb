package com.shop.shop.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "ShopSecurityInfo")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ShopSecurityInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "shopId", nullable = false, unique = true)
    private Shop shop;

    // Thông tin kinh doanh
    @Column(length = 50)
    private String businessType; // "individual" hoặc "company"

    @Column(length = 50)
    private String taxCode; // Mã số thuế

    // Thông tin thanh toán
    @Column(length = 100)
    private String bankName; // Tên ngân hàng

    @Column(length = 100)
    private String bankBranch; // Chi nhánh

    @Column(length = 50)
    private String bankAccount; // Số tài khoản

    @Column(length = 255)
    private String bankAccountName; // Tên chủ tài khoản

    // Trạng thái xác thực
    @Column(length = 50)
    private String verificationStatus; // Pending, Approved, Rejected

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();
}