package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.CartDetail;

public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {

}
