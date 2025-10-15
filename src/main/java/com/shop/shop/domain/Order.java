package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "Orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "addressId")
    private UserAddress address;

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(length = 50)
    private String paymentMethod;

    @Column(length = 50)
    private String status = "New";

    private Double totalPrice;

    @Column(length = 50)
    private String voucherCode;

    @ManyToOne
    @JoinColumn(name = "shop_id")
    private Shop shop;

    @OneToMany(mappedBy = "order")
    @JsonIgnoreProperties({ "order" })
    private List<OrderDetail> orderDetails;

}
