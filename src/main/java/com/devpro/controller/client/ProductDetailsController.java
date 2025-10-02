package com.devpro.controller.client;

import com.devpro.dto.ReviewDTO;
import com.devpro.models.*;
import com.devpro.repository.*;
import com.devpro.service.impl.ProductService;
import com.devpro.service.impl.ReviewService;
import com.devpro.service.impl.UserService;
import com.devpro.service.specification.ProductSpec;
import com.devpro.utils.TimeAgoUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/client/productdetails")
public class ProductDetailsController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private CartRepository  cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private WishListRepository wishListRepository;

    @Autowired
    private WishListItemRepository  wishListItemRepository;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ReviewRepository reviewRepository;

    @GetMapping("/{id}")
    public String productDetailsPage(Model model, @PathVariable("id")int id, HttpServletRequest request) {
         Product product= productService.findById(id);
         String category = product.getCategory().getName();
         List<Product> products = productService.findAll(ProductSpec.getCategoryProduct(category));
         HttpSession session = request.getSession();
         String email = (String) session.getAttribute("email");
         User user = this.userService.getUserByEmail(email);
         Set<Product> wish = new HashSet<>();
         Set<Integer> wishIds = new HashSet<>();
         if(user!=null){
             Wishlist wishlist = this.wishListRepository.findByUser(user);
             List<WishlistItem> wishlistItems = wishListItemRepository.findByWishlist(wishlist);
             wish = wishlistItems.stream().map(WishlistItem::getProduct).collect(Collectors.toSet());
             wishIds = wish.stream().map(Product::getId).collect(Collectors.toSet());

         }
        // review
        Page<Review> reviewPages = this.reviewService.getReviews(product, 1, 5);
        List<Review> reviews = reviewPages.getContent();

        List<ReviewDTO> reviewDTOs = reviews.stream().map(r -> {
            ReviewDTO dto = new ReviewDTO();
            dto.setBody(r.getBody());
            dto.setCreatedAt(TimeAgoUtil.toTimeAgo(r.getCreatedAt())); // time ago
            dto.setFullName(r.getUser().getFullName());
            dto.setAvatar(r.getUser().getAvatar());
            dto.setRole(r.getUser().getRole().getName().toString());
            return dto;
        }).toList();

        model.addAttribute("reviews", reviewDTOs);

        model.addAttribute("wishlistId",wishIds);
         model.addAttribute("productd",product);
         model.addAttribute("products",products);
         return "client/productdetails";
    }

    @PostMapping("/add-to-wishlist/{id}")
    @ResponseBody
    public Map<String, Object> addToWishlist(@PathVariable("id")int id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Map<String, Object> repone = new HashMap<>();
        repone.put("status", this.productService.addProductToWishlist(email, id)?"success":"error");
        return repone;
    }

    @PostMapping("/add-to-cart/{id}")
    @ResponseBody
    public Map<String, Object> addToCart(@PathVariable("id")int id, @RequestParam(name = "quantity", required = false)int quantity, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Map<String, Object> response = new HashMap<>();
        response.put("status", this.productService.handleProductToCart(email, id, session, quantity)?"success":"error");
        response.put("count", (Integer)session.getAttribute("sum"));
        return  response;
    }

    @PostMapping("/review/{id}")
    public String review(@PathVariable("id")int id, HttpServletRequest request, @RequestParam(value = "comment", required = false) String comment) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Product product = productService.findById(id);
        Review review = new Review();
        review.setProduct(product);
        review.setUser(user);
        review.setBody(comment);
        this.reviewService.saveReview(review);
        return "redirect:/client/productdetails/"+product.getId();
    }

    @GetMapping("/load-more-reviews")
    @ResponseBody
    public List<ReviewDTO> loadMoreReviews(@RequestParam("productId") Long productId,
                                        @RequestParam("offset") int offset,
                                        @RequestParam("limit") int limit) {
        List<Review> reviews = reviewRepository.findByProductId(productId, offset, limit);
        return reviews.stream().map(r -> {
            ReviewDTO dto = new ReviewDTO();
            dto.setBody(r.getBody());
            dto.setCreatedAt(TimeAgoUtil.toTimeAgo(r.getCreatedAt()));
            dto.setFullName(r.getUser().getFullName());
            dto.setAvatar(r.getUser().getAvatar());
            dto.setRole(r.getUser().getRole().getName().toString());
            return dto;
        }).toList();
    }

}
