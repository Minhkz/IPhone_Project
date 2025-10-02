package com.devpro.repository;

import com.devpro.models.Product;
import com.devpro.models.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    Page<Review> findByProductAndIsApproved(Product product, Integer isApproved, Pageable pageable);

    Page<Review> findAll(Pageable pageable);

    Page<Review> findAllByIsApproved(Integer isApproved,  Pageable pageable);

    @Query(value = "SELECT * FROM reviews r " +
                   "WHERE r.product_id = :productId " +
                   "ORDER BY r.created_at DESC " +
                   "LIMIT :limit OFFSET :offset",
            nativeQuery = true)
    List<Review> findByProductId(@Param("productId") Long productId,
                                 @Param("offset") int offset,
                                 @Param("limit") int limit);

}
