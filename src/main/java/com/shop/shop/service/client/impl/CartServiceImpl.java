package com.shop.shop.service.client.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Carrier;
import com.shop.shop.domain.Cart;
import com.shop.shop.domain.CartDetail;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.domain.Voucher;
import com.shop.shop.dto.ProductDTO;
import com.shop.shop.repository.CarrierRepository;
import com.shop.shop.repository.CartDetailRepository;
import com.shop.shop.repository.CartRepository;
import com.shop.shop.repository.OrderRepository;
import com.shop.shop.repository.UserVoucherRepository;
import com.shop.shop.repository.VoucherRepository;
import com.shop.shop.service.client.CartService;
import com.shop.shop.service.client.ProductDetailService;
import com.shop.shop.service.client.ProductService;
import com.shop.shop.util.ProvinceUtils;

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
    private CarrierRepository carrierRepository;

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
    public Long updateCart(Cart cartFromForm, User user) {
        Cart cartInDB = cartRepository.findById(cartFromForm.getId()).orElse(null);

        if (cartInDB != null) {
            UserAddress address = user.getReceiver();
            List<CartDetail> detailsFromForm = cartFromForm.getCartDetails();
            double newTotalCartPrice = 0.0;

            // Create a new Order
            Order order = new Order();
            order.setUser(cartInDB.getUser());
            order.setTotalPrice(0.0); // Will calculate later
            // order.setStatus("PENDING_PAYMENT");
            order.setPaymentStatus(false);
            order.setAddress(cartInDB.getUser().getReceiver());

            // Determine and set carrier based on receiver province (receiverDistrict)
            String province = null;
            if (cartInDB.getUser() != null && cartInDB.getUser().getReceiver() != null) {
                province = cartInDB.getUser().getReceiver().getReceiverDistrict();
            }

            Long carrierId = determineCarrierIdByProvince(province);
            if (carrierId != null) {
                Carrier carrier = carrierRepository.findById(carrierId).orElse(null);
                order.setShippingFee(carrier.getDeliveryFee());
                newTotalCartPrice += carrier.getDeliveryFee();
            }

            // Create OrderDetail list
            List<OrderDetail> orderDetails = new ArrayList<>();

            for (CartDetail detailFromForm : detailsFromForm) {
                // Lấy đối tượng CartDetail đầy đủ từ DB
                CartDetail cartDetailInDB = cartDetailRepository.findById(detailFromForm.getId()).orElse(null);

                if (cartDetailInDB != null) {
                    // Cập nhật số lượng (quantity)
                    cartDetailInDB.setQuantity(detailFromForm.getQuantity());

                    // Tính toán lại giá cho CartDetail này (KHÔNG áp dụng voucher ở đây)
                    double newPrice = cartDetailInDB.getProduct().getPrice() * detailFromForm.getQuantity();
                    cartDetailInDB.setPrice(newPrice);

                    // Chỉ cộng giá gốc (no voucher)
                    newTotalCartPrice += newPrice;

                    // Create OrderDetail (without voucher)
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cartDetailInDB.getProduct());
                    orderDetail.setPrice(newPrice);
                    orderDetail.setQuantity(cartDetailInDB.getQuantity());
                    orderDetail.setShop(cartDetailInDB.getProduct().getShop());
                    orderDetail.setSize(cartDetailInDB.getSize());
                    orderDetail.setAddress(address);
                    orderDetail.setStatus("PENDING_PAYMENT");
                    if (carrierId != null) {
                        Carrier carrier = carrierRepository.findById(carrierId).orElse(null);
                        orderDetail.setCarrier(carrier);
                        orderDetail.setFinalPrice(newPrice + carrier.getDeliveryFee());
                    } else {

                        orderDetail.setFinalPrice(newPrice);
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
    public boolean handleCheckout(User user, String payment, Double shippingFee, Long orderId) {
        Cart cart = cartRepository.findByUser(user);
        try {
            UserAddress userAddress = user.getReceiver();
            // Find the order: prefer provided orderId, otherwise the most recent pending order
            Order order = null;
            if (orderId != null) {
                order = orderRepository.findById(orderId).orElse(null);
            }
            if (order == null) {
                order = orderRepository.findTopByUserAndPaymentStatusOrderByCreatedAtDesc(user, false);
            }

            if (order == null || order.getOrderDetails() == null || order.getOrderDetails().isEmpty()) {
                return false;
            }

            // Update payment info on the order
            order.setPaymentMethod(payment);

            if ("Direct Bank Transfer".equals(payment)) {
                order.setPaymentStatus(true);
            } else if ("Cash On Delivery".equals(payment)) {
                order.setPaymentStatus(true);
            }

            // Set status on each order detail (per-item) instead of on the whole order
            if (order.getOrderDetails() != null) {
                for (OrderDetail orderDetail : order.getOrderDetails()) {
                    // Move from PENDING_PAYMENT -> PENDING (waiting confirmation)
                    orderDetail.setStatus("PENDING");
                    orderDetail.setAddress(userAddress);
                }
            }

            // Handle Voucher: set voucherCode and mark user's UserVoucher as used (status=false) when payment recorded
            if (order.getVoucher() != null) {
                order.setVoucherCode(order.getVoucher().getCode());
                // mark the corresponding UserVoucher as used
                userVoucherRepository.findByUserAndVoucher(order.getUser(), order.getVoucher())
                        .ifPresent(userVoucher -> {
                            userVoucher.setStatus(false);
                            userVoucherRepository.save(userVoucher);
                        });
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

    // Backwards-compatible convenience method
    @Transactional
    public boolean handleCheckout(User user, String payment) {
        return handleCheckout(user, payment, null, null);
    }

    @Override
    @Transactional
    public Order handleApplyVoucherToOrder(String code, User user) {
        // Find the voucher safely (avoid calling Optional.get() on empty)
        Optional<Voucher> optVoucher = voucherRepository.findByCode(code);
        if (optVoucher == null || optVoucher.isEmpty()) {
            return null;
        }
        Voucher voucher = optVoucher.get();

        LocalDateTime now = LocalDateTime.now();
        // Only allow vouchers with explicit status 'Active' (case-insensitive).
        // Reject vouchers with other statuses (e.g., 'Expired', 'Inactive', etc.).
        if (voucher.getStatus() != null && !"Active".equalsIgnoreCase(voucher.getStatus())) {
            return null;
        }
        if (voucher.getStartDate() != null && voucher.getStartDate().isAfter(now)) {
            return null;
        }
        if (voucher.getEndDate() != null && voucher.getEndDate().isBefore(now)) {
            return null;
        }

        // Find the most recent pending order (by paymentStatus=false) for this user
        Order order = orderRepository.findTopByUserAndPaymentStatusOrderByCreatedAtDesc(user, false);
        if (order == null || order.getOrderDetails() == null || order.getOrderDetails().isEmpty()) {
            return null;
        }

        // If voucher is shop-specific, check for eligible products first.
        if (voucher.getShop() != null) {
            boolean anyEligible = order.getOrderDetails().stream()
                    .anyMatch(od -> od.getProduct() != null && od.getProduct().getShop() != null
                    && Objects.equals(od.getProduct().getShop().getId(), voucher.getShop().getId()));

            if (!anyEligible) {
                return order;
            }
        }

        // --- Apply the voucher ---
        double total = 0.0;
        for (OrderDetail od : order.getOrderDetails()) {
            double basePrice = od.getProduct().getPrice() * od.getQuantity();

            // Một sản phẩm được coi là hợp lệ nếu:
            // 1. Voucher này là voucher toàn hệ thống (voucher.getShop() == null).
            // 2. Hoặc, shop của sản phẩm khớp với shop của voucher.
            boolean isGlobalVoucher = voucher.getShop() == null;
            boolean isShopMatch = !isGlobalVoucher && od.getProduct() != null && od.getProduct().getShop() != null
                    && Objects.equals(od.getProduct().getShop().getId(), voucher.getShop().getId());
            boolean eligible = isGlobalVoucher || isShopMatch;

            if (eligible) {
                Double discountPercent = voucher.getDiscountPercent();
                double discounted = basePrice;
                if (discountPercent != null) {
                    discounted = basePrice * (1 - (discountPercent / 100.0));
                }
                od.setFinalPrice(discounted + order.getShippingFee());
                od.setPrice(basePrice);
                total += discounted;
            } else {
                // Non-eligible items keep their base price
                od.setFinalPrice(basePrice);
                od.setPrice(basePrice);
                total += basePrice;
            }
        }

        order.setVoucher(voucher);
        order.setVoucherCode(voucher.getCode());

        // Set the order totalPrice to the computed (possibly discounted) total.
        order.setTotalPrice(total + (order.getShippingFee() != null ? order.getShippingFee() : 0.0));

        orderRepository.save(order);
        return order;
    }

    @Override
    @Transactional
    public Order handleRemoveVoucherFromOrder(User user) {
        // Find the most recent pending order (by paymentStatus=false) for this user
        Order order = orderRepository.findTopByUserAndPaymentStatusOrderByCreatedAtDesc(user, false);
        if (order == null || order.getOrderDetails() == null || order.getOrderDetails().isEmpty()) {
            return null;
        }
        // Remove voucher from the order and reset all orderDetail prices/finalPrices to base prices
        order.setVoucher(null);
        order.setVoucherCode(null);

        for (OrderDetail od : order.getOrderDetails()) {
            double basePrice = od.getProduct().getPrice() * od.getQuantity();
            od.setPrice(basePrice);
            od.setFinalPrice(basePrice + order.getShippingFee());
        }

        double total = 0.0;
        for (OrderDetail od : order.getOrderDetails()) {
            total += od.getFinalPrice() != null ? od.getFinalPrice() : od.getPrice();
        }
        order.setTotalPrice(total + order.getShippingFee());
        orderRepository.save(order);
        return order;
    }

    @Override
    @Transactional
    public boolean updateOrderShipping(User user, Long orderId) {
        if (user == null) {
            return false;
        }
        // Find the order: prefer provided orderId, otherwise most recent pending
        Order order = null;
        if (orderId != null) {
            order = orderRepository.findById(orderId).orElse(null);
        }
        if (order == null) {
            order = orderRepository.findTopByUserAndPaymentStatusOrderByCreatedAtDesc(user, false);
        }
        if (order == null) {
            return false;
        }

        // Determine province from user's receiver
        String province = null;
        if (user.getReceiver() != null) {
            province = user.getReceiver().getReceiverDistrict();
        }

        Long carrierId = determineCarrierIdByProvince(province);
        Carrier carrier = null;
        Double shippingFee = 0.0;
        if (carrierId != null) {
            carrier = carrierRepository.findById(carrierId).orElse(null);
            if (carrier != null) {
                shippingFee = carrier.getDeliveryFee() != null ? carrier.getDeliveryFee() : 0.0;
                order.setShippingFee(shippingFee);
            }
        } else {
            // no carrier found -> clear shipping fee
            order.setShippingFee(0.0);
            shippingFee = 0.0;
        }

        // Update each orderDetail carrier if available
        double itemsTotal = 0.0;
        if (order.getOrderDetails() != null) {
            for (OrderDetail od : order.getOrderDetails()) {
                if (carrier != null) {
                    od.setCarrier(carrier);
                } else {
                    od.setCarrier(null);
                }
                // prefer finalPrice (after voucher) if present
                Double fp = od.getFinalPrice() != null ? od.getFinalPrice() : od.getPrice();
                itemsTotal += fp != null ? fp : 0.0;
            }
        }

        // Total price = items total + shippingFee
        order.setTotalPrice(itemsTotal + (shippingFee != null ? shippingFee : 0.0));

        orderRepository.save(order);
        return true;
    }

    /**
     * Map province name to carrier id: Bắc -> 1, Trung -> 2, Nam -> 3. Uses
     * simple normalized string matching against known province names.
     */
    private Long determineCarrierIdByProvince(String province) {
        if (province == null) {
            return null;
        }
        String p = ProvinceUtils.normalizeProvince(province);
        if (p.isEmpty()) {
            return null;
        }

        // North provinces (Bắc)
        Set<String> north = new HashSet<>(Arrays.asList(
                "ha noi", "ha giang", "cao bang", "bac kan", "lang son", "tuyen quang", "thai nguyen",
                "lao cai", "yen bai", "son la", "dien bien", "lai chau", "phu tho", "vinh phuc", "bac giang",
                "bac ninh", "hoa binh", "hai duong", "hai phong", "hung yen", "nam dinh", "ninh binh", "thai binh",
                "quang ninh"
        ));

        // Central provinces (Trung)
        Set<String> central = new HashSet<>(Arrays.asList(
                "thanh hoa", "nghe an", "ha tinh", "quang binh", "quang tri", "thua thien hue", "da nang",
                "quang nam", "quang ngai", "binh dinh", "phu yen", "khanh hoa", "ninh thuan", "binh thuan"
        ));

        // South provinces (Nam)
        Set<String> south = new HashSet<>(Arrays.asList(
                "kon tum", "gia lai", "dak lak", "dak nong", "lam dong", "binh phuoc", "tay ninh", "binh duong",
                "dong nai", "ba ria vung tau", "tp ho chi minh", "ho chi minh", "long an", "tien giang", "ben tre",
                "tra vinh", "vinh long", "can tho", "hau giang", "soc trang", "bac lieu", "ca mau", "an giang",
                "kien giang"
        ));

        // Try exact contains match
        for (String n : north) {
            if (p.contains(n)) {
                return 1L;
            }
        }
        for (String c : central) {
            if (p.contains(c)) {
                return 2L;
            }
        }
        for (String s2 : south) {
            if (p.contains(s2)) {
                return 3L;
            }
        }

        // Fallback: try to guess by keywords
        if (p.contains("hue") || p.contains("da nang") || p.contains("quang")) {
            return 2L;
        }
        if (p.contains("ho chi minh") || p.contains("tp hcm") || p.contains("hcm")) {
            return 3L;
        }

        return null;
    }
}
