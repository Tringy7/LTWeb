package com.shop.shop.controller.client;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.shop.config.VNPAYConfig;
import com.shop.shop.domain.Order;
import com.shop.shop.repository.OrderRepository;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private VNPAYConfig vnpConfig;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/create-payment")
    @ResponseBody
    public String createPayment(
            @RequestParam("amount") Long amount,
            @RequestParam("orderId") Long orderId,
            HttpServletRequest request) throws Exception {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String vnp_OrderInfo = "Thanh toan don hang #" + orderId;
        String orderType = "billpayment";
        String vnp_TxnRef = String.valueOf(orderId); // Sử dụng orderId làm transaction reference

        String vnp_IpAddr = request.getRemoteAddr();
        String vnp_TmnCode = vnpConfig.getVnpTmnCode();
        String vnp_HashSecret = vnpConfig.getVnpHashSecret();

        long amountVND = amount * 100; // nhân 100 vì VNPAY tính theo đồng
        String vnp_CreateDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        Calendar cld = Calendar.getInstance();
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = new SimpleDateFormat("yyyyMMddHHmmss").format(cld.getTime());

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amountVND));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnpConfig.getVnpReturnUrl());
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        // Sắp xếp tham số theo alphabet
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=')
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()))
                        .append('=')
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                    hashData.append('&');
                    query.append('&');
                }
            }
        }

        // Sinh mã bảo mật
        String secureHash = hmacSHA512(vnpConfig.getVnpHashSecret(), hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        String paymentUrl = vnpConfig.getVnpPayUrl() + "?" + query;
        return paymentUrl;
    }

    private String hmacSHA512(String key, String data) throws Exception {
        javax.crypto.Mac hmac512 = javax.crypto.Mac.getInstance("HmacSHA512");
        javax.crypto.spec.SecretKeySpec secretKey
                = new javax.crypto.spec.SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        hmac512.init(secretKey);
        byte[] hash = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder result = new StringBuilder();
        for (byte b : hash) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }

    @GetMapping("/vnpay-return")
    public String vnpayReturn(@RequestParam Map<String, String> allParams, Model model) throws Exception {
        String vnp_SecureHash = allParams.remove("vnp_SecureHash");
        allParams.remove("vnp_SecureHashType"); // 👈 thêm dòng này

        List<String> fieldNames = new ArrayList<>(allParams.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();

        for (String fieldName : fieldNames) {
            String fieldValue = allParams.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                // 👇 encode giống khi tạo thanh toán
                hashData.append(fieldName)
                        .append('=')
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                    hashData.append('&');
                }
            }
        }

        String computedHash = hmacSHA512(vnpConfig.getVnpHashSecret(), hashData.toString());

        String responseCode = allParams.get("vnp_ResponseCode");
        String txnRef = allParams.get("vnp_TxnRef"); // Order ID
        String message;
        boolean success = false;

        if (computedHash.equals(vnp_SecureHash)) {
            if ("00".equals(responseCode)) {
                // Thanh toán thành công - cập nhật order
                try {
                    Long orderId = Long.parseLong(txnRef);
                    Order order = orderRepository.findById(orderId).orElse(null);
                    if (order != null) {
                        order.setPaymentStatus(true);
                        order.setPaymentMethod("Direct Bank Transfer");
                        // order.setStatus("PENDING"); // Chuyển sang trạng thái chờ xác nhận
                        order.setTxnRef(txnRef);
                        orderRepository.save(order);
                        message = "Thanh toán thành công!";
                        success = true;
                    } else {
                        message = "Không tìm thấy đơn hàng!";
                    }
                } catch (Exception e) {
                    message = "Lỗi khi cập nhật đơn hàng: " + e.getMessage();
                }
            } else {
                message = "Thanh toán thất bại! Mã lỗi: " + responseCode;
            }
        } else {
            message = "Chữ ký không hợp lệ!";
        }

        model.addAttribute("message", message);
        model.addAttribute("success", success);
        model.addAttribute("orderId", txnRef);

        return "client/payment/result";
    }
}
