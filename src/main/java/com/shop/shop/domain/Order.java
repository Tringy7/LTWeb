package com.shop.shop.domain;

import java.beans.Transient;
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
import com.shop.shop.domain.Carrier;

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

    private Double shippingFee;

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

    @Transient
    public String getStatus() {
        if (orderDetails == null || orderDetails.isEmpty()) {
            return "NEW";
        }

        List<String> statuses = orderDetails.stream()
                .map(d -> d.getStatus() == null ? "" : d.getStatus().trim().toUpperCase())
                .distinct()
                .toList();

        boolean allCancelled = statuses.size() == 1 && statuses.contains("CANCELLED");
        boolean allReturned = statuses.size() == 1 && statuses.contains("RETURNED");
        boolean allDelivered = statuses.size() == 1 && statuses.contains("DELIVERED");
        boolean allConfirmed = statuses.size() == 1 && statuses.contains("CONFIRMED");

        boolean anyReturned = statuses.contains("RETURNED");
        boolean anyCancelled = statuses.contains("CANCELLED");
        boolean anyDelivered = statuses.contains("DELIVERED");
        boolean anyShipping = statuses.contains("SHIPPING");
        boolean anyConfirmed = statuses.contains("CONFIRMED");
        boolean anyProcessing = statuses.contains("PROCESSING");
        boolean anyPending = statuses.contains("PENDING");

        // 🔹 Ưu tiên theo mức độ hoàn tất cao nhất trước
        if (allReturned) {
            return "RETURNED";
        }
        if (allCancelled) {
            return "CANCELLED";
        }
        if (allDelivered) {
            return "DELIVERED";
        }
        if (anyReturned) {
            return "RETURNED";
        }
        if (anyCancelled) {
            return "CANCELLED";
        }
        if (anyDelivered) {
            return "DELIVERED";
        }
        if (anyShipping) {
            return "SHIPPING";
        }
        if (allConfirmed) {
            return "CONFIRMED";
        }
        if (anyConfirmed && !anyShipping && !anyDelivered) {
            return "CONFIRMED";
        }
        if (anyProcessing) {
            return "PROCESSING";
        }
        if (anyPending && statuses.size() == 1) {
            return "PENDING";
        }

        return "PROCESSING";
    }

}
