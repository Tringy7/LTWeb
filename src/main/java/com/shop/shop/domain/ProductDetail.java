package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "product_detail")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long quantity;
    private String size;
    private Long sold;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product product;
}
