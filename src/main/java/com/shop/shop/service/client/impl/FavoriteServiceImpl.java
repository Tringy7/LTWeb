package com.shop.shop.service.client.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Favorite;
import com.shop.shop.domain.Product;
import com.shop.shop.domain.User;
import com.shop.shop.repository.FavoriteRepository;
import com.shop.shop.service.client.FavoriteService;

@Service("clientFavoriteService")
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteRepository favoriteRepository;

    @Override
    @Transactional
    public boolean toggleFavorite(User user, Product product) {
        if (user == null || product == null) {
            return false;
        }
        Optional<Favorite> existing = favoriteRepository.findByUserAndProduct(user, product);
        if (existing.isPresent()) {
            favoriteRepository.delete(existing.get());
            return false;
        } else {
            Favorite f = new Favorite();
            f.setUser(user);
            f.setProduct(product);
            favoriteRepository.save(f);
            return true;
        }
    }

    @Override
    public boolean isFavorite(User user, Product product) {
        if (user == null || product == null) {
            return false;
        }
        return favoriteRepository.existsByUserAndProduct(user, product);
    }
}
