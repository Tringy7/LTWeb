package com.shop.shop.repository.client;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {

}
