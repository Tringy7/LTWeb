package com.shop.shop.service.client.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.CartDetail;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.domain.User;
import com.shop.shop.dto.ProductDTO;
import com.shop.shop.repository.client.CartDetailRepository;
import com.shop.shop.repository.client.CartRepository;
import com.shop.shop.repository.client.OrderRepository;
import com.shop.shop.service.client.CartService;
import com.shop.shop.service.client.ProductDetailService;
import com.shop.shop.service.client.ProductService;

import jakarta.transaction.Transactional;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ProductDetailService productDetailService;

    @Override
    @Transactional
    public Cart getCart(User user) {
        Cart cart = cartRepository.findByUser(user);
        if (cart != null) {
            return cart;
        } else {
            Cart newCart = new Cart();
            newCart.setUser(user);
            newCart.setTotalPrice(0D);
            cartRepository.save(newCart);
            return newCart;
        }
    }

    @Override
    @Transactional
    public void handleCart(ProductDTO productDTO, Cart cart) {
        Product product = productService.getProductById(productDTO.getProductId());
        if (product != null) {
            CartDetail cartDetail = CartDetail.builder()
                    .cart(cart)
                    .product(product)
                    .price(productDTO.getPrice() * productDTO.getQuantity())
                    .quantity(productDTO.getQuantity())
                    .size(productDTO.getSize())
                    .build();
            cartDetailRepository.save(cartDetail);
            cart.setTotalPrice(cart.getTotalPrice() + productDTO.getPrice() * productDTO.getQuantity());
            cartRepository.save(cart);
        }
    }

    @Override
    @Transactional
    public void deleteCartDetail(Long cartDetailId) {
        CartDetail cartDetail = cartDetailRepository.findById(cartDetailId).orElse(null);
        if (cartDetail != null) {
            Cart cart = cartDetail.getCart();
            cart.setTotalPrice(cart.getTotalPrice() - cartDetail.getPrice());
            cartRepository.save(cart);
            cartDetailRepository.deleteById(cartDetailId);
        }
    }

    @Override
    @Transactional
    public void updateCart(Cart cartFromForm) {
        // 1. Lấy đối tượng Cart đầy đủ từ DB bằng ID gửi từ form.
        Cart cartInDB = cartRepository.findById(cartFromForm.getId()).orElse(null);

        if (cartInDB != null) {
            List<CartDetail> detailsFromForm = cartFromForm.getCartDetails();
            double newTotalCartPrice = 0.0;

            // 2. Duyệt qua từng CartDetail được gửi từ form.
            for (CartDetail detailFromForm : detailsFromForm) {
                // 3. Lấy đối tượng CartDetail đầy đủ từ DB.
                CartDetail cartDetailInDB = cartDetailRepository.findById(detailFromForm.getId()).orElse(null);

                if (cartDetailInDB != null) {
                    // 4. Cập nhật số lượng (quantity).
                    cartDetailInDB.setQuantity(detailFromForm.getQuantity());

                    // 5. Tính toán lại giá cho CartDetail này một cách an toàn.
                    double newPrice = cartDetailInDB.getProduct().getPrice() * detailFromForm.getQuantity();
                    cartDetailInDB.setPrice(newPrice);

                    newTotalCartPrice += newPrice;
                }
            }
            // 6. Cập nhật tổng giá trị cho toàn bộ giỏ hàng.
            cartInDB.setTotalPrice(newTotalCartPrice);
        }
    }

    @Override
    @Transactional
    public boolean handleCheckout(User user, String payment) {
        Cart cart = cartRepository.findByUser(user);
        if (cart == null || cart.getCartDetails() == null || cart.getCartDetails().isEmpty()) {
            return false;
        }

        try {
            // Create a new Order
            Order order = new Order();
            order.setUser(user);
            order.setTotalPrice(cart.getTotalPrice());
            order.setPaymentMethod(payment);
            order.setStatus("PENDING");

            // Create OrderDetail list from CartDetail list
            List<OrderDetail> orderDetails = new ArrayList<>();
            for (CartDetail cd : cart.getCartDetails()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrder(order);
                orderDetail.setProduct(cd.getProduct());
                orderDetail.setPrice(cd.getPrice());
                orderDetail.setQuantity(cd.getQuantity());
                orderDetail.setShop(cd.getProduct().getShop());
                orderDetail.setSize(cd.getSize());
                orderDetails.add(orderDetail);

                // Update product quantity
                ProductDetail productDetail = productDetailService.findByProductAndSize(cd.getProduct(), cd.getSize());
                if (productDetail != null) {
                    productDetail.setQuantity(productDetail.getQuantity() - cd.getQuantity());
                    productDetail.setSold(productDetail.getSold() + cd.getQuantity());
                }
            }
            order.setOrderDetails(orderDetails);

            // Save the order
            orderRepository.save(order);

            // Clear the cart
            cartDetailRepository.deleteAll(cart.getCartDetails());
            // Important: Clear the list in the parent entity to break the association
            cart.getCartDetails().clear();
            cart.setTotalPrice(0.0);
            cartRepository.save(cart);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
