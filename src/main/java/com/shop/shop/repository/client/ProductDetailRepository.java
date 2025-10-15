package com.shop.shop.repository.client;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;

public interface ProductDetailRepository
        extends JpaRepository<ProductDetail, Long> {

    ProductDetail findByProductAndSize(Product product, String size);
}
