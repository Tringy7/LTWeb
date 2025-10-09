package com.shop.shop.service.client;

import java.util.List;

import com.shop.shop.domain.Product;

public interface ProductService {

    List<Product> getAllProduct();

    List<Product> getAllProductSoldOver10();

    Product getProductTopSold();
}
