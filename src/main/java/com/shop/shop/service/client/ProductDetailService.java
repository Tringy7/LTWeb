package com.shop.shop.service.client;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;

public interface ProductDetailService {

    ProductDetail findByProductAndSize(Product product, String size);

}
