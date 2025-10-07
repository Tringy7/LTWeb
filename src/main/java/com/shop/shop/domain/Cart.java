package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "carts")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private double totalPrice;
    private Long sum;

    @OneToOne()
    @JoinColumn(name = "userId")
    private User user;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cart")
    private List<CartDetail> cartDetails;
}
