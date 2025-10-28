package com.shop.shop.service.client;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.User;

public interface FavoriteService {

    boolean toggleFavorite(User user, Product product);

    boolean isFavorite(User user, Product product);
}
