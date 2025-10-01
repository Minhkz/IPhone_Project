package com.devpro.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "reviews")
@Getter
@Setter
@NoArgsConstructor
@RequiredArgsConstructor
public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    @NonNull
    private Product product;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @NonNull
    private User user;


    @Column(columnDefinition = "MEDIUMTEXT")
    @NonNull
    private String body;

    @Column(name = "is_approved")
    private Integer isApproved;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @PrePersist
    public void defaults() {
        if (isApproved == null) {
            isApproved = 0;
        }
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }
}
