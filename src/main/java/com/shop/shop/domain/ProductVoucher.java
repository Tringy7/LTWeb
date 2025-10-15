package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "Product_Voucher")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductVoucher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "productId", nullable = false)
    private Product product;

    @Column(unique = true, length = 50)
    private String code;

    private Double discountPercent;

    private LocalDateTime startDate;

    private LocalDateTime endDate;

    @Column(length = 20)
    private String status;

}
