package com.devpro.repository;


import com.devpro.models.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    Page<Order> findAll(Pageable pageable);
    Page<Order> findAll(Specification<Order> spec, Pageable pageable);

    Order findByPaymentRef(String paymentRef);
}
