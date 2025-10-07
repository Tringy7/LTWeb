package com.shop.shop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Name product not valid")
    private String name;

    @DecimalMin("0.0")
    private double price;

    private String image;

    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    private String brand;
    private String color;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    private List<OrderDetail> orderDetails;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    private List<CartDetail> cartDetails;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    private List<ProductDetail> productDetails;

}
