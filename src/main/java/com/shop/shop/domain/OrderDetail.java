package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "order_detail")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "orderId")
    private Order order;

    private String sizeProduct;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product product;

    private Long quantity;
}
