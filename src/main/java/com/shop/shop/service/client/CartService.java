package com.shop.shop.service.client;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.User;
import com.shop.shop.dto.ProductDTO;

public interface CartService {

    Cart getCart(User user);

    void handleCart(ProductDTO productDTO, Cart cart);

    void deleteCartDetail(Long cartDetailId);

    Long updateCart(Cart cartFromForm);

    /**
     * Finalize checkout. If orderId is provided, the specific order will be
     * used; otherwise the most recent pending order for the user is used.
     * shippingFee may be null.
     */
    boolean handleCheckout(User user, String payment, Double shippingFee, Long orderId);

    Order handleApplyVoucherToOrder(String voucherCode, User user);

    Order handleRemoveVoucherFromOrder(User user);

    /**
     * Recompute and update shipping (carrier + shippingFee) for the user's
     * pending order or a specific orderId if provided, using the user's current
     * receiver address.
     */
    boolean updateOrderShipping(User user, Long orderId);
}
