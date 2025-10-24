package com.shop.shop.service.client.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.CartDetail;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.domain.User;
import com.shop.shop.domain.Voucher;
import com.shop.shop.dto.ProductDTO;
import com.shop.shop.repository.CartDetailRepository;
import com.shop.shop.repository.CartRepository;
import com.shop.shop.repository.OrderRepository;
import com.shop.shop.repository.UserVoucherRepository;
import com.shop.shop.repository.VoucherRepository;
import com.shop.shop.service.client.CartService;
import com.shop.shop.service.client.ProductDetailService;
import com.shop.shop.service.client.ProductService;

import jakarta.transaction.Transactional;

@Service("clientCartService")
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

    @Autowired
    private VoucherRepository voucherRepository;

    @Autowired
    private UserVoucherRepository userVoucherRepository;

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
    public Long updateCart(Cart cartFromForm) {
        Cart cartInDB = cartRepository.findById(cartFromForm.getId()).orElse(null);

        if (cartInDB != null) {
            List<CartDetail> detailsFromForm = cartFromForm.getCartDetails();
            double newTotalCartPrice = 0.0;

            // Create a new Order
            Order order = new Order();
            order.setUser(cartInDB.getUser());
            order.setTotalPrice(0.0); // Will calculate later
            order.setStatus("PENDING_PAYMENT");
            order.setPaymentStatus(false);
            order.setAddress(cartInDB.getUser().getReceiver());

            // Create OrderDetail list
            List<OrderDetail> orderDetails = new ArrayList<>();

            for (CartDetail detailFromForm : detailsFromForm) {
                // Lấy đối tượng CartDetail đầy đủ từ DB
                CartDetail cartDetailInDB = cartDetailRepository.findById(detailFromForm.getId()).orElse(null);

                if (cartDetailInDB != null) {
                    // Cập nhật số lượng (quantity)
                    cartDetailInDB.setQuantity(detailFromForm.getQuantity());

                    // Tính toán lại giá cho CartDetail này
                    double newPrice = cartDetailInDB.getProduct().getPrice() * detailFromForm.getQuantity();
                    cartDetailInDB.setPrice(newPrice);

                    double finalPrice = newPrice;
                    if (cartDetailInDB.getVoucher() != null && cartDetailInDB.getVoucher().getDiscountPercent() != null) {
                        finalPrice = newPrice * (1 - cartDetailInDB.getVoucher().getDiscountPercent() / 100);
                    }

                    newTotalCartPrice += finalPrice;

                    // Create OrderDetail
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cartDetailInDB.getProduct());
                    orderDetail.setPrice(cartDetailInDB.getPrice());
                    orderDetail.setQuantity(cartDetailInDB.getQuantity());
                    orderDetail.setShop(cartDetailInDB.getProduct().getShop());
                    orderDetail.setSize(cartDetailInDB.getSize());

                    // Lưu thông tin voucher nếu có
                    if (cartDetailInDB.getVoucher() != null) {
                        orderDetail.setVoucher(cartDetailInDB.getVoucher());

                        // Cập nhật status của UserVoucher thành false
                        userVoucherRepository.findByUserAndVoucher(cartInDB.getUser(), cartDetailInDB.getVoucher())
                                .ifPresent(userVoucher -> {
                                    userVoucher.setStatus(false);
                                    userVoucherRepository.save(userVoucher);
                                });
                    }

                    orderDetails.add(orderDetail);
                }
            }

            // Set order details and total price
            order.setOrderDetails(orderDetails);
            order.setTotalPrice(newTotalCartPrice);

            // Save the order
            orderRepository.save(order);

            // Update cart total price
            cartInDB.setTotalPrice(newTotalCartPrice);
            cartRepository.save(cartInDB);
            return order.getId();
        } else {
            return null;
        }
    }

    @Override
    @Transactional
    public boolean handleCheckout(User user, String payment) {
        Cart cart = cartRepository.findByUser(user);
        // if (cart == null || cart.getCartDetails() == null || cart.getCartDetails().isEmpty()) {
        //     return false;
        // }

        try {
            // Find the most recent order with PENDING_PAYMENT status for this user
            Order order = orderRepository.findTopByUserAndStatusOrderByCreatedAtDesc(user, "PENDING_PAYMENT");

            if (order == null || order.getOrderDetails() == null || order.getOrderDetails().isEmpty()) {
                return false;
            }

            // Update order status and payment info
            order.setPaymentMethod(payment);

            if ("Direct Bank Transfer".equals(payment)) {
                order.setPaymentStatus(true);
                order.setStatus("PENDING"); // Đợi xác nhận
            } else if ("Cash On Delivery".equals(payment)) {
                order.setPaymentStatus(false);
                order.setStatus("PENDING"); // Đợi xác nhận
            }

            orderRepository.save(order);

            // Update product quantity in stock based on ORDER DETAILS (not cart)
            for (OrderDetail orderDetail : order.getOrderDetails()) {
                ProductDetail productDetail = productDetailService.findByProductAndSize(
                        orderDetail.getProduct(),
                        orderDetail.getSize()
                );
                if (productDetail != null) {
                    productDetail.setQuantity(productDetail.getQuantity() - orderDetail.getQuantity());
                    productDetail.setSold(productDetail.getSold() + orderDetail.getQuantity());
                }
            }

            if (cart != null) {
                // Clear the cart
                cartDetailRepository.deleteAll(cart.getCartDetails());
                cart.getCartDetails().clear();
                cart.setTotalPrice(0.0);
                cartRepository.save(cart);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Cart handleApplyVoucher(String code, User user) {
        Cart cart = cartRepository.findByUser(user);
        if (cart == null) {
            return null;
        }

        Voucher voucher = voucherRepository.findByCode(code);
        if (voucher == null) {
            return null;
        }
        // Validate thời gian hiệu lực và trạng thái
        LocalDateTime now = LocalDateTime.now();
        if (Boolean.FALSE.equals(voucher.getStatus())) {
            return null;
        }
        if (voucher.getStartDate() != null && voucher.getStartDate().isAfter(now)) {
            return null;
        }
        if (voucher.getEndDate() != null && voucher.getEndDate().isBefore(now)) {
            return null;
        }
        // Áp dụng cho các CartDetail thuộc cùng shop của voucher, đồng thời bỏ voucher ở shop khác
        List<CartDetail> toUpdate = new ArrayList<>();
        for (CartDetail cd : cart.getCartDetails()) {
            boolean sameShop = cd.getProduct() != null
                    && cd.getProduct().getShop() != null
                    && voucher.getShop() != null
                    && Objects.equals(cd.getProduct().getShop().getId(), voucher.getShop().getId());
            Voucher newVoucher = sameShop ? voucher : null;
            Long currentId = cd.getVoucher() == null ? null : cd.getVoucher().getId();
            Long newId = newVoucher == null ? null : newVoucher.getId();
            if (!Objects.equals(currentId, newId)) {
                cd.setVoucher(newVoucher);
                toUpdate.add(cd);
            }
        }
        if (!toUpdate.isEmpty()) {
            cartDetailRepository.saveAll(toUpdate);
        }
        // Recalculate cart total price after applying/changing vouchers
        double newTotalCartPrice = 0.0;
        for (CartDetail cd : cart.getCartDetails()) {
            double itemPrice = cd.getPrice(); // This is price * quantity
            if (cd.getVoucher() != null && cd.getVoucher().getDiscountPercent() != null) {
                // Voucher is applied but discount calculation will be done in updateCart
            }
            newTotalCartPrice += itemPrice;
        }
        // Only update if the total price has changed
        if (Double.compare(cart.getTotalPrice(), newTotalCartPrice) != 0) {
            cart.setTotalPrice(newTotalCartPrice);
            cartRepository.save(cart);
        }
        return cart;
    }

    @Override
    @Transactional
    public boolean handleRemoveVoucher(User user) {
        Cart cart = cartRepository.findByUser(user);
        if (cart == null || cart.getCartDetails() == null || cart.getCartDetails().isEmpty()) {
            return false;
        }

        try {
            // Xóa voucher khỏi tất cả các CartDetail
            List<CartDetail> toUpdate = new ArrayList<>();
            for (CartDetail cd : cart.getCartDetails()) {
                if (cd.getVoucher() != null) {
                    cd.setVoucher(null);
                    toUpdate.add(cd);
                }
            }

            // Lưu các CartDetail đã cập nhật
            if (!toUpdate.isEmpty()) {
                cartDetailRepository.saveAll(toUpdate);
            }

            // Tính lại tổng giá trị giỏ hàng không có voucher
            double newTotalCartPrice = 0.0;
            for (CartDetail cd : cart.getCartDetails()) {
                newTotalCartPrice += cd.getPrice(); // Price gốc (không có discount)
            }

            // Cập nhật tổng giá trị giỏ hàng
            cart.setTotalPrice(newTotalCartPrice);
            cartRepository.save(cart);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
