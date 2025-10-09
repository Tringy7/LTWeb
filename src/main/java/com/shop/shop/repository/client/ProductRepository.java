package com.shop.shop.repository.client;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

}
