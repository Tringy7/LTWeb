package com.shop.shop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.Review;
import com.shop.shop.domain.User;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    Optional<Review> findByUserAndProduct(User user, Product product);

}
