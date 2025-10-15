package com.shop.shop.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Order_Details")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "orderId", nullable = false)
    @JsonIgnoreProperties({"orderDetails"})
    private Order order;

    @ManyToOne
    @JoinColumn(name = "productId", nullable = false)
    @JsonIgnoreProperties({ "orderDetails" })
    private Product product;

    @ManyToOne
    @JoinColumn(name = "shopId", nullable = false)
    @JsonIgnoreProperties({ "orderDetails" })
    private Shop shop;

    private Long quantity;

    private Double price;

    
}
