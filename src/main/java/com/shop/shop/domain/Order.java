package com.shop.shop.domain;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

    @Column(unique = true)
    private String txnRef;

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(length = 50)
    private String paymentMethod;

    private Boolean paymentStatus;

    private Double totalPrice;

    @Column(length = 50)
    private String voucherCode;

    @ManyToOne
    @JoinColumn(name = "voucher_id")
    private Voucher voucher;

    @ManyToOne
    @JoinColumn(name = "shop_id")
    private Shop shop;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderDetail> orderDetails;

    // Helper method to get overall order status based on order details
    public String getStatus() {
        if (orderDetails == null || orderDetails.isEmpty()) {
            return "NEW";
        }

        // Get unique statuses from order details
        List<String> statuses = orderDetails.stream()
                .map(OrderDetail::getStatus)
                .filter(status -> status != null)
                .distinct()
                .toList();

        // If all order details are delivered, order is delivered
        if (statuses.size() == 1 && "DELIVERED".equals(statuses.get(0))) {
            return "DELIVERED";
        }

        // If all order details are cancelled, order is cancelled
        if (statuses.size() == 1 && "CANCELLED".equals(statuses.get(0))) {
            return "CANCELLED";
        }

        // If any order detail is delivered, order is partially delivered
        if (statuses.contains("DELIVERED")) {
            return "PROCESSING"; // Partially delivered, still processing
        }

        // If any order detail is cancelled but not all, still processing
        if (statuses.contains("CANCELLED")) {
            return "PROCESSING";
        }

        // If all are pending/processing, order is processing
        if (statuses.stream().allMatch(status -> "PENDING".equals(status) || "PROCESSING".equals(status))) {
            return "PROCESSING";
        }

        // Default to processing for any other combination
        return "PROCESSING";
    }
}
