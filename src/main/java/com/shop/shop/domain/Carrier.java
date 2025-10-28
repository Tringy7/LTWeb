package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "Carriers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Carrier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String name;

    @Column(nullable = false)
    private Double deliveryFee;

    @Column(length = 100)
    private String area;

    @Column(length = 20)
    private String status; // e.g., ACTIVE, INACTIVE

    @Column(length = 20)
    private String contactPhone;

    @Column(length = 50)
    private String email;

    @OneToMany(mappedBy = "carrier", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Shipper> shippers;
}