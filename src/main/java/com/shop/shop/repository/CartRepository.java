package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.User;

public interface CartRepository extends JpaRepository<Cart, Long> {

    Cart findByUser(User user);
}
