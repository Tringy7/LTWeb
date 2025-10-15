package com.shop.shop.service.client;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.User;
import com.shop.shop.dto.ProductDTO;

public interface CartService {

    Cart getCart(User user);

    void handleCart(ProductDTO productDTO, Cart cart);

    void deleteCartDetail(Long cartDetailId);

    void updateCart(Cart cartFromForm);

    boolean handleCheckout(User user, String payment);
}
