package com.shop.shop.service.vendor;

import com.shop.shop.domain.Order;
import com.shop.shop.repository.OrderRepository;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.FileOutputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.io.File;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public List<Order> filterOrders(String status, LocalDate fromDate, LocalDate toDate) {
        LocalDateTime start = (fromDate != null) ? fromDate.atStartOfDay() : null;
        LocalDateTime end = (toDate != null) ? toDate.atTime(23, 59, 59) : null;

        return orderRepository.filterOrders(status, start, end);
    }

    public List<Order> filterOrdersByShop(Long shopId, String status, LocalDateTime start, LocalDateTime end) {
        return orderRepository.filterOrdersByShop(shopId, status, start, end);
    }

    public Order save(Order order) {
        return orderRepository.save(order);
    }

    public boolean updateStatus(Long orderId, String newStatus) {
        Order order = getOrderById(orderId);
        if (order == null)
            return false;
        order.setStatus(newStatus);
        orderRepository.save(order);
        return true;
    }

    public String exportOrdersToPDF(List<Order> orders) {
        try {
            // Đường dẫn tới Desktop
            String desktopPath = System.getProperty("user.home") + "/Desktop/orders_report.pdf";
            File file = new File(desktopPath);

            Document document = new Document(PageSize.A4, 36, 36, 54, 36);
            PdfWriter.getInstance(document, new FileOutputStream(file));
            document.open();

            // 🔹 Load font Times New Roman có hỗ trợ Unicode tiếng Việt
            String fontPath = "src/main/resources/fonts/times.ttf";
            BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font titleFont = new Font(bf, 18, Font.BOLD, BaseColor.BLUE);
            Font headerFont = new Font(bf, 12, Font.BOLD, BaseColor.WHITE);
            Font dataFont = new Font(bf, 11, Font.NORMAL, BaseColor.BLACK);

            // --- Tiêu đề ---
            Paragraph title = new Paragraph("DANH SÁCH ĐƠN HÀNG", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // --- Bảng ---
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            table.setWidths(new float[] { 1f, 2f, 2.5f, 2.5f, 2f, 2f });

            // Header
            BaseColor headerBg = new BaseColor(0, 121, 182);
            String[] headers = { "ID", "Người đặt", "Ngày tạo", "Thanh toán", "Tổng tiền", "Trạng thái" };
            for (String h : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(h, headerFont));
                cell.setBackgroundColor(headerBg);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(6);
                table.addCell(cell);
            }

            // Dữ liệu
            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            for (Order o : orders) {
                table.addCell(new PdfPCell(new Phrase(String.valueOf(o.getId()), dataFont)));
                table.addCell(new PdfPCell(new Phrase(o.getUser().getFullName(), dataFont)));
                table.addCell(new PdfPCell(new Phrase(o.getCreatedAt().format(df), dataFont)));
                table.addCell(new PdfPCell(new Phrase(o.getPaymentMethod(), dataFont)));
                table.addCell(new PdfPCell(new Phrase(String.format("%,.0f ₫", o.getTotalPrice()), dataFont)));
                table.addCell(new PdfPCell(new Phrase(o.getStatus(), dataFont)));
            }

            document.add(table);
            document.close();

            return " File PDF đã được lưu tại: " + desktopPath;

        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi khi tạo file PDF: " + e.getMessage();
        }
    }

    public Order getOrderById(Long orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        return optionalOrder.orElse(null);
    }

    public List<Order> getOrdersByShopId(Long shopId) {
        return orderRepository.findByShopId(shopId);
    }

    public boolean updateOrderStatus(Long orderId, String status) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus(status);
            orderRepository.save(order);
            return true;
        }
        return false;
    }

    public List<Order> getOrdersByStatus(String status) {
        return orderRepository.findByStatus(status);
    }

    public List<Order> getOrdersByShopIdAndStatus(Long shopId, String status) {
        return orderRepository.findByShopIdAndStatus(shopId, status);
    }

}
