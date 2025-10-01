package com.devpro.repository;

import com.devpro.models.Product;
import com.devpro.models.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    Page<Review> findByProductAndIsApproved(Product product, Integer isApproved, Pageable pageable);

    Page<Review> findAll(Pageable pageable);

    Page<Review> findAllByIsApproved(Integer isApproved,  Pageable pageable);

}
