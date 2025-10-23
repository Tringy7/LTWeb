package com.shop.shop.service.client;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.Review;
import com.shop.shop.domain.User;

public interface ReviewService {

    void saveReview(Review review);

    boolean toggleFavorite(User user, Product product);

    boolean isFavorite(User user, Product product);
}
