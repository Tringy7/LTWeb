package com.shop.shop.domain;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "User_Addresses")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserAddress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "userId", nullable = true, unique = true)
    private User user;

    @Column(length = 255)
    private String receiverName;

    @Column(length = 50)
    private String receiverPhone;

    @Column(length = 500)
    private String receiverAddress;

    @Column(length = 500)
    private String receiverDistrict;

    @Column(columnDefinition = "TEXT")
    private String note;

    @OneToMany(mappedBy = "address", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetails;
}
