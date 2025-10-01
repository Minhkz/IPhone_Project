package com.devpro.service.impl;

import com.devpro.models.Product;
import com.devpro.models.Review;
import com.devpro.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewRepository reviewRepository;

    public Page<Review> getReviews(Product product, int page, int size) {
        Pageable pageable = PageRequest.of(page-1, size, Sort.by("createdAt").descending());
        return reviewRepository.findByProductAndIsApproved( product, 1 , pageable);
    }

    public Review saveReview(Review review) {
        return reviewRepository.save(review);
    }

    public Page<Review> getContentReviews(int type, Pageable pageable) {
        return reviewRepository.findAllByIsApproved(type,  pageable);
    }

    public Review getReviewById(Integer id) {
        return reviewRepository.findById(id).get();
    }

    public void deleteReviewByReviewId(Integer id) {
         reviewRepository.deleteById(id);
    }
}
