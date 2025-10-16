package com.shop.shop.repository.client;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

}
