package com.shop.shop.service.vendor;

import java.io.File;
import java.io.FileOutputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.repository.OrderDetailRepository;
import com.shop.shop.repository.OrderRepository;

@Service("vendorOrderService")
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private OrderDetailService orderDetailService;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public List<Order> filterOrders(String status, LocalDate fromDate, LocalDate toDate) {
        LocalDateTime start = (fromDate != null) ? fromDate.atStartOfDay() : null;
        LocalDateTime end = (toDate != null) ? toDate.atTime(23, 59, 59) : null;

        return orderRepository.filterOrders(status, start, end);
    }

    // public List<Order> filterOrdersByShop(Long shopId, String status,
    // LocalDateTime start, LocalDateTime end) {
    // return orderRepository.filterOrdersByShop(shopId, status, start, end);
    // }

    public Order save(Order order) {
        return orderRepository.save(order);
    }

    public boolean updateStatus(Long orderId, String newStatus) {
        Order order = getOrderById(orderId);
        if (order == null)
            return false;
        // order.setStatus(newStatus);
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

    // public Order getOrderById(Long orderId) {
    // Optional<Order> optionalOrder = orderRepository.findById(orderId);
    // return optionalOrder.orElse(null);
    // }

    // public List<Order> getOrdersByShopId(Long shopId) {
    // return orderRepository.findByShopId(shopId);
    // }

    public boolean updateOrderStatus(Long orderId, String status) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            // order.setStatus(status);
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

    public List<Order> filterOrdersByShop(Long shopId, String shopStatus, LocalDateTime start, LocalDateTime end) {
        String statusParam = (shopStatus == null || shopStatus.isBlank()) ? null : shopStatus.toUpperCase();
        return orderRepository.findOrdersByShop(shopId, statusParam, start, end);
    }

    public List<Order> getOrdersByShopId(Long shopId) {
        return orderRepository.findByShopId(shopId);
    }

    public List<Order> getOrdersByShopIdAndOrderStatus(Long shopId, String orderStatus) {
        return orderRepository.findByShopIdAndOrderStatus(shopId,
                orderStatus == null ? null : orderStatus.toUpperCase());
    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    // Export PDF cho vendor: chỉ in phần Order (và chỉ tính/tổng phần thuộc shop)
    public String exportOrdersToPDFForShop(Long shopId, List<Order> orders) {
        try {
            String desktopPath = System.getProperty("user.home") + "/Desktop/orders_report_shop_" + shopId + ".pdf";
            File file = new File(desktopPath);

            Document document = new Document(PageSize.A4, 36, 36, 54, 36);
            PdfWriter.getInstance(document, new FileOutputStream(file));
            document.open();

            // font (đường dẫn file font trong dự án)
            String fontPath = "src/main/resources/fonts/times.ttf";
            BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font titleFont = new Font(bf, 16, Font.BOLD);
            Font headerFont = new Font(bf, 12, Font.BOLD);
            Font dataFont = new Font(bf, 11, Font.NORMAL);

            Paragraph title = new Paragraph("BÁO CÁO ĐƠN HÀNG - SHOP " + shopId, titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(12);
            document.add(title);

            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            for (Order o : orders) {
                // Lấy phần OrderDetail của shop này
                List<OrderDetail> details = orderDetailRepository.findByOrder_IdAndShop_Id(o.getId(), shopId);
                if (details == null || details.isEmpty())
                    continue;

                Paragraph pOrder = new Paragraph("Order ID: " + o.getId() + " - Người đặt: "
                        + (o.getUser() != null ? o.getUser().getFullName() : "") + " - Ngày: "
                        + o.getCreatedAt().format(df), dataFont);
                pOrder.setSpacingBefore(8);
                document.add(pOrder);

                PdfPTable table = new PdfPTable(new float[] { 1f, 3f, 1f, 1f, 1f });
                table.setWidthPercentage(100);
                table.addCell(new PdfPCell(new Phrase("STT", headerFont)));
                table.addCell(new PdfPCell(new Phrase("Sản phẩm", headerFont)));
                table.addCell(new PdfPCell(new Phrase("Số lượng", headerFont)));
                table.addCell(new PdfPCell(new Phrase("Đơn giá", headerFont)));
                table.addCell(new PdfPCell(new Phrase("Thành tiền", headerFont)));

                double subtotal = 0.0;
                int idx = 1;
                for (OrderDetail od : details) {
                    double line = (od.getPrice() != null ? od.getPrice() : 0.0)
                            * (od.getQuantity() != null ? od.getQuantity() : 0L);
                    subtotal += line;
                    table.addCell(new PdfPCell(new Phrase(String.valueOf(idx++), dataFont)));
                    String productName = od.getProduct() != null ? od.getProduct().getName() : "N/A";
                    table.addCell(new PdfPCell(new Phrase(productName, dataFont)));
                    table.addCell(new PdfPCell(new Phrase(String.valueOf(od.getQuantity()), dataFont)));
                    table.addCell(new PdfPCell(new Phrase(String.format("%,.0f ₫", od.getPrice()), dataFont)));
                    table.addCell(new PdfPCell(new Phrase(String.format("%,.0f ₫", line), dataFont)));
                }

                PdfPCell blank = new PdfPCell(new Phrase(""));
                blank.setColspan(3);
                table.addCell(blank);

                PdfPCell cellLabel = new PdfPCell(new Phrase("Tổng (shop)", headerFont));
                cellLabel.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cellLabel);

                PdfPCell cellSubtotal = new PdfPCell(new Phrase(String.format("%,.0f ₫", subtotal), dataFont));
                table.addCell(cellSubtotal);

                document.add(table);
            }

            document.close();
            return "File PDF đã lưu tại: " + desktopPath;
        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi khi tạo file PDF: " + e.getMessage();
        }
    }

    public List<Order> getOrdersByShopThroughDetails(Long shopId) {
        List<Long> orderIds = orderDetailService.getOrderIdsByShopId(shopId);
        if (orderIds.isEmpty())
            return Collections.emptyList();

        List<Order> orders = orderRepository.findAllById(orderIds);

        // 🔹 Cập nhật trạng thái đơn hàng dựa theo chi tiết
        for (Order order : orders) {
            List<OrderDetail> details = orderDetailRepository.findByOrder_Id(order.getId());
            if (details == null || details.isEmpty())
                continue;

            boolean allReturned = details.stream().allMatch(d -> "RETURNED".equalsIgnoreCase(d.getStatus()));
            boolean allCancelled = details.stream().allMatch(d -> "CANCELLED".equalsIgnoreCase(d.getStatus()));
            boolean allDelivered = details.stream().allMatch(d -> "DELIVERED".equalsIgnoreCase(d.getStatus()));
            boolean anyShipping = details.stream().anyMatch(d -> "SHIPPING".equalsIgnoreCase(d.getStatus()));
            boolean anyConfirmed = details.stream().anyMatch(d -> "CONFIRMED".equalsIgnoreCase(d.getStatus()));
            boolean anyPending = details.stream().anyMatch(d -> "PENDING".equalsIgnoreCase(d.getStatus()));

            String newStatus;
            if (allReturned)
                newStatus = "RETURNED";
            else if (allCancelled)
                newStatus = "CANCELLED";
            else if (allDelivered)
                newStatus = "DELIVERED";
            else if (anyShipping)
                newStatus = "SHIPPING";
            else if (anyConfirmed)
                newStatus = "CONFIRMED";
            else if (anyPending)
                newStatus = "PENDING";
            else
                newStatus = "PENDING";

            if (!newStatus.equals(order.getStatus())) {
                // order.setStatus(newStatus);
                orderRepository.save(order);
            }
        }

        return orders;
    }

    public void updateOrderStatusFromDetails(Long orderId) {
        List<OrderDetail> details = orderDetailRepository.findByOrder_Id(orderId);
        if (details == null || details.isEmpty())
            return;

        boolean allReturned = details.stream().allMatch(d -> d.getStatus().equals("RETURNED"));
        boolean allCancelled = details.stream().allMatch(d -> d.getStatus().equals("CANCELLED"));
        boolean allDelivered = details.stream().allMatch(d -> d.getStatus().equals("DELIVERED"));

        boolean anyShipping = details.stream().anyMatch(d -> d.getStatus().equals("SHIPPING"));
        boolean anyConfirmed = details.stream().anyMatch(d -> d.getStatus().equals("CONFIRMED"));
        boolean anyPending = details.stream().anyMatch(d -> d.getStatus().equals("PENDING"));

        String newStatus;

        if (allReturned)
            newStatus = "RETURNED";
        else if (allCancelled)
            newStatus = "CANCELLED";
        else if (allDelivered)
            newStatus = "DELIVERED";
        else if (anyShipping)
            newStatus = "SHIPPING";
        else if (anyConfirmed)
            newStatus = "CONFIRMED";
        else if (anyPending)
            newStatus = "PENDING";
        else
            newStatus = "PENDING";

        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null && !newStatus.equals(order.getStatus())) {
            // order.setStatus(newStatus);
            orderRepository.save(order);
        }
    }

}
