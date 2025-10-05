package com.devpro.controller.client;

import com.devpro.models.*;
import com.devpro.repository.CartItemRepository;
import com.devpro.repository.CartRepository;
import com.devpro.service.impl.ProductService;
import com.devpro.service.impl.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/client/carts")
public class CartController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @GetMapping
    public String cartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        double tmpprice=0;
        int totalItem=0;
        if(email != null) {
            User user = this.userService.getUserByEmail(email);

            Cart cart = this.cartRepository.findByUser(user);
            List<CartProduct> cartProducts = this.cartItemRepository.findByCart(cart);
            model.addAttribute("cartProducts", cartProducts);
            totalItem=cartProducts.size();


            for(CartProduct cartProduct : cartProducts) {
                tmpprice+= cartProduct.getPrice()*cartProduct.getQuantity();
            }

        }
        double shippingFee = 29000;
        double serviceFee = 5000;

        double total= tmpprice + shippingFee + serviceFee;
        model.addAttribute("total",total);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("serviceFee", serviceFee);
        model.addAttribute("subtotal",tmpprice);
        model.addAttribute("totalItem", totalItem);
        return "client/cart";
    }

    @PostMapping("/cancel/{id}")
    @ResponseBody
    public Map<String, Object> cancelCart(@PathVariable("id") int id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.cartRepository.findByUser(user);
        Product product = productService.findById(id);

        // Xoá sản phẩm trong cart
        CartProductKey key = new CartProductKey();
        key.setCartId(cart.getId());
        key.setProductId(product.getId());
        this.cartItemRepository.deleteById(key);

        // Lấy lại danh sách giỏ hàng
        List<CartProduct> cartItems = this.cartItemRepository.findByCart(cart);

        // Tính lại tổng số sản phẩm
        int s = cart.getSum()-1;
        cart.setSum(s);
        session.setAttribute("sum", s);
        cartRepository.save(cart);

        // Tính lại subtotal
        long subtotal = cartItems.stream()
                .mapToLong(item -> Math.round(item.getPrice() * item.getQuantity()))
                .sum();

        long serviceFee =  5000 ;
        long shippingFee =  29000;
        long total = subtotal + serviceFee + shippingFee;

        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("sum", s);
        response.put("subtotal", subtotal);
        response.put("serviceFee", serviceFee);
        response.put("shippingFee", shippingFee);
        response.put("total", total);

        return response;
    }



    @PostMapping("/plus/{id}")
    @ResponseBody
    public Map<String, Object> plusCart(@PathVariable("id") int id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.cartRepository.findByUser(user);
        Product product = productService.findById(id);
        Map<String, Object> response = new HashMap<>();
        CartProduct cartProduct = this.cartItemRepository.findByCartAndProduct(cart, product);
        cartProduct.setQuantity(cartProduct.getQuantity() + 1);
        this.cartItemRepository.save(cartProduct);
        List<CartProduct> cartProducts = this.cartItemRepository.findByCart(cart);
        double price = cartProducts.stream()
                .mapToDouble(cp -> cp.getPrice() * cp.getQuantity())
                .sum();

        response.put("status", "success");
        response.put("quantity", cartProduct.getQuantity());
        response.put("totalPrice", cartProduct.getPrice()*cartProduct.getQuantity());
        response.put("price", price);
        return response;
    }

    @PostMapping("/minus/{id}")
    @ResponseBody
    public Map<String, Object> minusCart(@PathVariable("id") int id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.cartRepository.findByUser(user);
        Product product = productService.findById(id);
        Map<String, Object> response = new HashMap<>();

        CartProduct cartProduct = this.cartItemRepository.findByCartAndProduct(cart, product);
        if (cartProduct.getQuantity() > 1) {
            cartProduct.setQuantity(cartProduct.getQuantity() - 1);
            this.cartItemRepository.save(cartProduct);
        }

        List<CartProduct> cartProducts = this.cartItemRepository.findByCart(cart);
        double price = cartProducts.stream()
                .mapToDouble(cp -> cp.getPrice() * cp.getQuantity())
                .sum();

        response.put("status", "success");
        response.put("quantity", cartProduct.getQuantity());
        response.put("totalPrice", cartProduct.getPrice() * cartProduct.getQuantity());
        response.put("price", price);
        return response;
    }


}
