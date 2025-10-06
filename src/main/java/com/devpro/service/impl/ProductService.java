package com.devpro.service.impl;

import com.devpro.dto.product.ProductDto;
import com.devpro.models.*;
import com.devpro.repository.*;
import com.devpro.service.IProductService;
import com.devpro.service.specification.ProductSpec;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ProductService implements IProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private WishListRepository wishListRepository;

    @Autowired
    private WishListItemRepository wishListItemRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderProductRepository orderProductRepository;

    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }

    @Override
    public Page<Product> findAll(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Override
    public Page<Product> findAll(Specification<Product> spec, Pageable pageable) {
        return productRepository.findAll(spec, pageable);
    }

    @Override
    public List<Product> findAll(Specification<Product> spec) {
        return productRepository.findAll(spec);
    }


    @Override
    public Product findById(int id) {
        return productRepository.findById(id).get();
    }

    @Override
    public void deleteProductById(int id) {
        productRepository.deleteById(id);
    }

    public ProductDto convertProduct(Product product) {
        return ProductDto.builder()
                .id(product.getId())
                .name(product.getName())
                .price(product.getPrice())
                .quantity(product.getQuantity())
                .sold(product.getSold())
                .shortDesc(product.getShortDesc())
                .build();
    }

    public Page<Product> filterProduct(Pageable page, String tradeMark, String color, String rom, String price) {
        if(tradeMark == null &&  color == null && rom == null && price == null){
            return productRepository.findAll(page);
        }
        Specification<Product> combinedSpec = Specification.allOf();
        if(tradeMark != null){
            List<String> tradeMarkList = Arrays.asList(tradeMark.split("-"));
            combinedSpec = combinedSpec.and(ProductSpec.getListCategoryProduct(tradeMarkList));
        }
        if(color != null){
            List<String> colorList = Arrays.asList(color.split("-"));
            combinedSpec = combinedSpec.and(ProductSpec.getProductByListColor(colorList));
        }
        if(rom != null){
            List<String> romList = Arrays.asList(rom.split("-"));
            List<Integer> roms = romList.stream()
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            combinedSpec = combinedSpec.and(ProductSpec.getProductByListRom(roms));
        }
        if(price != null){
            double minPrice = 0;
            double maxPrice=0;
            switch (price){
                case "100000-5000000":
                    minPrice = 100000;
                    maxPrice = 5000000;
                    break;
                case "5000000-10000000":
                    minPrice = 5000001;
                    maxPrice = 10000000;
                    break;
                case "10000000":
                    minPrice = 10000000;
                    maxPrice = 1000000000;
                    break;
                case "1-10000000000":
                    minPrice = 1;
                    maxPrice = 1000000000;
                    break;

            }
            combinedSpec = combinedSpec.and(ProductSpec.getProductByPrice(minPrice, maxPrice));
        }

        return  productRepository.findAll(combinedSpec, page);
    }

    public Boolean handleProductToWishList(String email, int productId) {
        User user = this.userService.getUserByEmail(email);
        if(user != null){
            Wishlist wishlist = this.wishListRepository.findByUser(user);
            if(wishlist == null){
               Wishlist newWishlist = new Wishlist();
               newWishlist.setUser(user);
               wishlist = this.wishListRepository.save(newWishlist);
            }

            Optional<Product> product = productRepository.findById(productId);
            if(product.isPresent()){
                Product realProduct = product.get();
                WishlistItemKey wishlistItemKey = new WishlistItemKey();
                wishlistItemKey.setProductId(realProduct.getId());
                wishlistItemKey.setWishlistId(wishlist.getId());

                WishlistItem wishlistItem = wishListItemRepository.findBywishlistItemKey(wishlistItemKey);
                if(wishlistItem != null){
                    this.wishListItemRepository.delete(wishlistItem);
                    return false;
                }
                else{
                    wishlistItem = new WishlistItem();
                    wishlistItem.setWishlistItemKey(wishlistItemKey);
                    wishlistItem.setProduct(realProduct);
                    wishlistItem.setWishlist(wishlist);
                    this.wishListItemRepository.save(wishlistItem);
                    return true;
                }

            }
        }
        return false;
    }

    public Boolean addProductToWishlist(String email, int productId) {
        User user = this.userService.getUserByEmail(email);
        if(user != null){
            Wishlist wishlist = this.wishListRepository.findByUser(user);
            if(wishlist == null){
                Wishlist newWishlist = new Wishlist();
                newWishlist.setUser(user);
                wishlist = this.wishListRepository.save(newWishlist);
            }
            Optional<Product> product = productRepository.findById(productId);
            if(product.isPresent()){
                Product realProduct = product.get();
                WishlistItemKey wishlistItemKey = new WishlistItemKey();
                wishlistItemKey.setProductId(realProduct.getId());
                wishlistItemKey.setWishlistId(wishlist.getId());
                WishlistItem wishlistItem = wishListItemRepository.findBywishlistItemKey(wishlistItemKey);
                if(wishlistItem != null){
                    return false;
                }else {
                    wishlistItem = new WishlistItem();
                    wishlistItem.setWishlistItemKey(wishlistItemKey);
                    wishlistItem.setProduct(realProduct);
                    wishlistItem.setWishlist(wishlist);
                    this.wishListItemRepository.save(wishlistItem);
                    return true;
                }

            }
        }
        return false;
    }

    public Boolean handleProductToCart(String email, int productId, HttpSession session, int quantity){
        User  user = this.userService.getUserByEmail(email);
        if(user != null){
            Cart cart = this.cartRepository.findByUser(user);
            if(cart == null){
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);
            }

            Optional<Product> product = productRepository.findById(productId);
            if(product.isPresent()){
                Product realProduct = product.get();

                CartProduct cartProduct = this.cartItemRepository.findByCartAndProduct(cart,realProduct);
                if(cartProduct != null){
                    cartProduct.setQuantity(cartProduct.getQuantity()+ quantity);
                    this.cartItemRepository.save(cartProduct);
                }else{
                    cartProduct = new CartProduct();

                    CartProductKey cartProductKey = new CartProductKey();
                    cartProductKey.setProductId(realProduct.getId());
                    cartProductKey.setCartId(cart.getId());

                    cartProduct.setCart(cart);
                    cartProduct.setProduct(realProduct);
                    cartProduct.setCartProductKey(cartProductKey);
                    cartProduct.setPrice(realProduct.getPrice());
                    cartProduct.setQuantity(quantity);

                    int s = cart.getSum()+1;
                    cart.setSum(s);
                    cartRepository.save(cart);
                    cartItemRepository.save(cartProduct);
                    session.setAttribute("sum", s);
                }
                return true;
            }
        }
        return false;
    }

    public void handlePlaceOrder(User user, Address address, HttpSession session, String paymentType, String uuid) {
        String type = (String)session.getAttribute("checkoutSource");
        if(type.equals("cart")){
            List<CartProduct> cartProducts = (List<CartProduct>) session.getAttribute("checkoutProducts");

            // 1. Tạo Order
            Order order = new Order();
            order.setUser(user);
            order.setAddress(address);
            order.setTotalPrice((Double) session.getAttribute("total"));
            order.setQuantity(cartProducts.size());
            order.setStatus("PENDING");
            order.setPaymentRef(paymentType.equals("COD")?"UNKNOW": uuid);
            order.setPaymentStatus(("PAYMENT_UNPAID"));
            order.setPaymentMethod(paymentType);
            // Lưu order trước để có ID
            order = orderRepository.save(order);

            // Map quantity trong giỏ hàng
            Map<Integer, Integer> map = (Map<Integer, Integer>) session.getAttribute("checkoutQuantities");

            Cart cart = cartRepository.findByUser(user);

            // 2. Tạo OrderProduct cho từng sản phẩm
            for (CartProduct cartProduct : cartProducts) {
                Product product = cartProduct.getProduct();

                OrderProductKey key = new OrderProductKey(order.getId(), product.getId());

                OrderProduct orderProduct = new OrderProduct();
                orderProduct.setOrderProductKey(key);
                orderProduct.setOrder(order);
                orderProduct.setProduct(product);
                orderProduct.setQuantity(map.get(product.getId()));
                orderProduct.setPrice(cartProduct.getPrice());

                orderProductRepository.save(orderProduct);

                // Xoá khỏi giỏ hàng
                cartItemRepository.deleteById(new CartProductKey(product.getId(), cart.getId()));
            }

            // 3. Cập nhật lại sum của giỏ hàng
            int s = (Integer) session.getAttribute("sum") - cartProducts.size();
            cart.setSum(s);
            this.cartRepository.save(cart);
            session.setAttribute("sum", s);
            session.setAttribute("orderId", order.getId());
            session.removeAttribute("checkoutProducts");
            session.removeAttribute("checkoutQuantities");
            session.removeAttribute("total");
        }else{
            int quantity = (Integer) session.getAttribute("productDetailQuanity");
            // 1. Tạo Order
            Order order = new Order();
            order.setUser(user);
            order.setAddress(address);
            order.setTotalPrice((Double) session.getAttribute("total"));
            order.setQuantity(quantity);
            order.setStatus("PENDING");
            order.setPaymentRef(paymentType.equals("COD")?"UNKNOW": uuid);
            order.setPaymentStatus(("PAYMENT_UNPAID"));
            order.setPaymentMethod(paymentType);
            // Lưu order trước để có ID
            order = orderRepository.save(order);

            int id = (Integer) session.getAttribute("productDetailId");
            Product product = this.productRepository.findById(id).get();

            //2. Tạo Order product
            OrderProductKey key = new OrderProductKey(order.getId(), product.getId());
            OrderProduct orderProduct = new OrderProduct();
            orderProduct.setOrder(order);
            orderProduct.setProduct(product);
            orderProduct.setOrderProductKey(key);
            orderProduct.setQuantity(quantity);
            orderProduct.setPrice(product.getPrice());
            this.orderProductRepository.save(orderProduct);

            session.setAttribute("orderId", order.getId());
        }
    }

    public void updatePayment(String paymentRef, String paymentStatus){
        Order order = this.orderRepository.findByPaymentRef(paymentRef);
        order.setPaymentStatus(paymentStatus);
        orderRepository.save(order);
    }

}
