package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "Shippers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Shipper {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(length = 20)
    private String phone;

    @Column(length = 50)
    private String vehicleNumber;

    @Column(length = 20)
    private String status; // e.g., ACTIVE, INACTIVE

    @ManyToOne
    @JoinColumn(name = "carrier_id")
    private Carrier carrier;

    @OneToMany(mappedBy = "shipper", cascade = CascadeType.ALL)
    private List<OrderDetail> orders;

    @OneToOne
    @JoinColumn(name = "userId", nullable = true, unique = true)
    private User user;
}