package com.shop.shop.service.client.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.repository.ProductDetailRepository;
import com.shop.shop.service.client.ProductDetailService;

@Service("clientProductDetailService")
public class ProductDetailServiceImpl implements ProductDetailService {

    @Autowired
    private ProductDetailRepository productDetailRepository;

    @Override
    public ProductDetail findByProductAndSize(Product product, String size) {
        return productDetailRepository.findByProductAndSize(product, size);
    }
}
