package com.shop.shop.service.client.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Review;
import com.shop.shop.repository.ReviewRepository;
import com.shop.shop.service.client.ReviewService;

import jakarta.transaction.Transactional;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    @Transactional
    public void saveReview(Review review) {
        reviewRepository.save(review);
    }

}
