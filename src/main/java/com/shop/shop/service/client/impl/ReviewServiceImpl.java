package com.shop.shop.service.client.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.Review;
import com.shop.shop.domain.User;
import com.shop.shop.repository.ReviewRepository;
import com.shop.shop.service.client.ReviewService;

import jakarta.transaction.Transactional;

@Service("clientReviewService")
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    @Transactional
    public void saveReview(Review review) {
        reviewRepository.save(review);
    }

    @Override
    @Transactional
    public boolean toggleFavorite(User user, Product product) {
        Optional<Review> existingReview = reviewRepository.findByUserAndProduct(user, product);

        if (existingReview.isPresent()) {
            Review review = existingReview.get();
            review.setFavorite(!review.getFavorite());
            reviewRepository.save(review);
            return review.getFavorite();
        } else {
            // Tạo review mới chỉ với favorite = true
            Review newReview = new Review();
            newReview.setUser(user);
            newReview.setProduct(product);
            newReview.setFavorite(true);
            reviewRepository.save(newReview);
            return true;
        }
    }

    @Override
    public boolean isFavorite(User user, Product product) {
        Optional<Review> review = reviewRepository.findByUserAndProduct(user, product);
        return review.isPresent() && review.get().getFavorite();
    }

}
