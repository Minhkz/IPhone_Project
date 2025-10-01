package com.devpro.controller.admin;

import com.devpro.models.Review;
import com.devpro.models.User;
import com.devpro.service.impl.ProductService;
import com.devpro.service.impl.ReviewService;
import com.devpro.service.impl.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/reviews")
public class ReviewController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;

    @GetMapping
    public String reviews(Model model, @RequestParam(value = "page", defaultValue = "1") int page ) {
        Pageable pageable = PageRequest.of(page-1, 5);
        Page<Review> reviewPage = this.reviewService.getContentReviews(0,  pageable);
        List<Review> reviews = reviewPage.getContent();
        model.addAttribute("reviews", reviews);
        model.addAttribute("reviews", reviews);
        return "admin/reviews/review";
    }

    @GetMapping("/success/{id}")
    public String success(@PathVariable Integer id) {
        Review review = this.reviewService.getReviewById(id);
        review.setIsApproved(1);
        this.reviewService.saveReview(review);
        return "redirect:/admin/reviews";
    }

    @GetMapping("/deletes/{id}")
    public String deletes(@PathVariable Integer id) {
        this.reviewService.deleteReviewByReviewId(id);
        return "redirect:/admin/reviews";
    }
}
