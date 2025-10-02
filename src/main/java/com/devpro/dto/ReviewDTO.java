package com.devpro.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDTO {
    private String body;
    private String createdAt;
    private String fullName;
    private String avatar;
    private String role;
}
