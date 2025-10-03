package com.devpro.controller.client;

import com.devpro.dto.user.UserDto;
import com.devpro.models.*;
import com.devpro.repository.OrderRepository;
import com.devpro.repository.WishListItemRepository;
import com.devpro.repository.WishListRepository;
import com.devpro.service.impl.EmailService;
import com.devpro.service.impl.ProductService;
import com.devpro.service.impl.RoleService;
import com.devpro.service.impl.UserService;
import com.devpro.service.specification.ProductSpec;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/client/homes")
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RoleService roleService;

    @Autowired
    private WishListRepository  wishListRepository;

    @Autowired
    private WishListItemRepository  wishListItemRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping
    public String homePage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Set<Integer> wishListItemIds = new HashSet<>();
        if (email != null) {
            User user = userService.getUserByEmail(email);
            model.addAttribute("user", user);
            Wishlist  wishlist = wishListRepository.findByUser(user);

            if (wishlist != null) {
                wishListItemIds = wishlist.getWishlistItems()
                        .stream()
                        .map(item -> item.getProduct().getId())
                        .collect(Collectors.toSet());
            }

        }
        List<Product> products= productService.findAll(ProductSpec.getFeatureProduct(1));
        List<Product> products2 = productService.findAll(ProductSpec.getDiscountProduct(1));
        model.addAttribute("products",products);
        model.addAttribute("productDiss",products2);
        model.addAttribute("wishlistId", wishListItemIds);
        return "client/home";
    }
    @GetMapping("/signin")
    public String signIn() {

        return "client/signin";
    }
    @GetMapping("/signup")
    public String signUp(Model model) {
        model.addAttribute("signUp", new UserDto());
        return "client/signup";
    }
    @PostMapping("/signup-create")
    public String signUp(Model model, @ModelAttribute("signUp") @Valid UserDto signUp,
                         BindingResult bindingResult) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors ) {
            System.out.println (error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "client/signup";
        }
        User user = new User();
        String hashPassword = this.passwordEncoder.encode(signUp.getPassword());
        user.setPassword(hashPassword);
        user.setUsername(signUp.getUsername());
        user.setEmail(signUp.getEmail());
        user.setRole(roleService.findByName("USER"));
        user.setAddress(signUp.getAddress());
        user.setFullName(signUp.getFullName());
        user.setPhone(signUp.getPhone());
        userService.save(user);
        return "redirect:/client/homes/signin";
    }

    @PostMapping("/add-to-wishlist/{id}")
    @ResponseBody
    public Map<String, Object> wish(@PathVariable("id") int id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Integer productId = id;
        String email = (String) session.getAttribute("email");
        Boolean added = productService.handleProductToWishList(email, productId);
        Map<String, Object> response = new HashMap<>();
        response.put("status", added?"added":"removed");
        return response;
    }

    @GetMapping("/order-history")
    public String orderHistory(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = userService.getUserByEmail(email);
        List<Order>  orders = user.getOrders();
        model.addAttribute("orders",orders);
        return  "client/order_history";
    }

    @GetMapping("/order-history/{id}")
    public String orderHistoryView(Model model, @PathVariable("id") int id) {
        Order order = this.orderRepository.findById(id).get();
        List<OrderProduct> orderProducts = order.getOrderProducts();
        model.addAttribute("order",order);
        model.addAttribute("orderProducts",orderProducts);
        return "client/order_details";
    }

    @GetMapping("/order-history/cancel/{id}")
    public String cancelOrderHistory(Model model, @PathVariable("id") int id) {
        Order order = this.orderRepository.findById(id).get();
        order.setStatus("CANCELLED");
        this.orderRepository.save(order);
        return "redirect:/client/homes/order-history";
    }
}
