package com.shop.shop.service.admin.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.Product;
import com.shop.shop.dto.CommissionSummaryDTO;
import com.shop.shop.dto.DashboardStatsDTO;
import com.shop.shop.dto.OrderStatsDTO;
import com.shop.shop.repository.OrderRepository;
import com.shop.shop.repository.OrderDetailRepository;
import com.shop.shop.repository.ProductRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.admin.CommissionService;
import com.shop.shop.service.admin.DashboardService;

@Service("adminDashboardService")
public class DashboardServiceImpl implements DashboardService {

    private final UserRepository userRepository;
    private final ShopRepository shopRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CommissionService commissionService;

    // Constructor for dependency injection
    public DashboardServiceImpl(UserRepository userRepository,
            ShopRepository shopRepository,
            ProductRepository productRepository,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            @Autowired(required = false) CommissionService commissionService) {
        this.userRepository = userRepository;
        this.shopRepository = shopRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.commissionService = commissionService; // May be null if not available

        // Log injection status
        System.out.println("DashboardServiceImpl initialized with commissionService: " +
                (commissionService != null ? "Available" : "NULL"));
    }

    @Override
    public DashboardStatsDTO getDashboardStats() {
        try {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime startOfMonth = now.with(TemporalAdjusters.firstDayOfMonth()).withHour(0).withMinute(0)
                    .withSecond(0);
            LocalDateTime startOfLastMonth = startOfMonth.minusMonths(1);
            LocalDateTime endOfLastMonth = startOfMonth.minusSeconds(1);

            // Current totals - safe calls
            Long totalUsers = userRepository.count();
            Long totalShops = shopRepository.count();
            Long totalProducts = productRepository.count();
            Long totalOrders = orderRepository.count();

            // This month data (User and Product don't have createdAt, so use 0 for growth
            // calculation)
            Long usersThisMonth = 0L;
            Long shopsThisMonth = 0L;
            Long productsThisMonth = 0L;
            Long ordersThisMonth = 0L;

            // Try to get shop and order counts
            try {
                shopsThisMonth = shopRepository.countByCreatedAtBetween(startOfMonth, now);
                ordersThisMonth = orderRepository.countByCreatedAtBetween(startOfMonth, now);
            } catch (Exception e) {
                System.err.println("Error getting monthly counts: " + e.getMessage());
            }

            // Last month data for comparison
            Long usersLastMonth = 0L;
            Long shopsLastMonth = 0L;
            Long productsLastMonth = 0L;

            try {
                shopsLastMonth = shopRepository.countByCreatedAtBetween(startOfLastMonth, endOfLastMonth);
            } catch (Exception e) {
                System.err.println("Error getting last month shop count: " + e.getMessage());
            }

            // Revenue and commission calculation using stored commission data
            BigDecimal revenueThisMonth = BigDecimal.ZERO;
            BigDecimal revenueLastMonth = BigDecimal.ZERO;
            BigDecimal commissionThisMonth = BigDecimal.ZERO;
            BigDecimal commissionLastMonth = BigDecimal.ZERO;

            try {
                if (commissionService != null) {
                    // Get commission data for this month (which includes total revenue)
                    CommissionSummaryDTO thisMonthCommission = commissionService.getCommissionSummary(
                            startOfMonth.toLocalDate(), now.toLocalDate());

                    if (thisMonthCommission != null) {
                        revenueThisMonth = thisMonthCommission.getTotalRevenue() != null
                                ? thisMonthCommission.getTotalRevenue()
                                : BigDecimal.ZERO;
                        commissionThisMonth = thisMonthCommission.getTotalCommissionAmount() != null
                                ? thisMonthCommission.getTotalCommissionAmount()
                                : BigDecimal.ZERO;
                    }

                    // Get commission data for last month
                    CommissionSummaryDTO lastMonthCommission = commissionService.getCommissionSummary(
                            startOfLastMonth.toLocalDate(), endOfLastMonth.toLocalDate());

                    if (lastMonthCommission != null) {
                        revenueLastMonth = lastMonthCommission.getTotalRevenue() != null
                                ? lastMonthCommission.getTotalRevenue()
                                : BigDecimal.ZERO;
                        commissionLastMonth = lastMonthCommission.getTotalCommissionAmount() != null
                                ? lastMonthCommission.getTotalCommissionAmount()
                                : BigDecimal.ZERO;
                    }
                } else {
                    // Fallback to order detail-based calculation since status is now in OrderDetail
                    Double revenueThisMonthDouble = orderDetailRepository.getTotalRevenueByDateRange(startOfMonth, now);
                    revenueThisMonth = revenueThisMonthDouble != null ? BigDecimal.valueOf(revenueThisMonthDouble)
                            : BigDecimal.ZERO;

                    Double revenueLastMonthDouble = orderDetailRepository.getTotalRevenueByDateRange(startOfLastMonth,
                            endOfLastMonth);
                    revenueLastMonth = revenueLastMonthDouble != null ? BigDecimal.valueOf(revenueLastMonthDouble)
                            : BigDecimal.ZERO;
                }
            } catch (Exception e) {
                System.err.println("Error getting commission/revenue data: " + e.getMessage());
            }

            // Calculate growth percentages
            Double userGrowthPercent = calculateGrowthPercent(usersThisMonth, usersLastMonth);
            Double shopGrowthPercent = calculateGrowthPercent(shopsThisMonth, shopsLastMonth);
            Double productGrowthPercent = calculateGrowthPercent(productsThisMonth, productsLastMonth);
            Double revenueGrowthPercent = calculateGrowthPercent(revenueThisMonth, revenueLastMonth);
            Double commissionGrowthPercent = calculateGrowthPercent(commissionThisMonth, commissionLastMonth);

            return DashboardStatsDTO.builder()
                    .totalUsers(totalUsers)
                    .totalShops(totalShops)
                    .totalProducts(totalProducts)
                    .totalOrders(totalOrders)
                    .totalRevenue(revenueThisMonth)
                    .userGrowthPercent(userGrowthPercent)
                    .shopGrowthPercent(shopGrowthPercent)
                    .productGrowthPercent(productGrowthPercent)
                    .revenueGrowthPercent(revenueGrowthPercent)
                    .newUsersThisMonth(usersThisMonth)
                    .newShopsThisMonth(shopsThisMonth)
                    .ordersThisMonth(ordersThisMonth)
                    .revenueThisMonth(revenueThisMonth)
                    .totalCommissionThisMonth(commissionThisMonth)
                    .totalCommissionLastMonth(commissionLastMonth)
                    .commissionGrowthPercent(commissionGrowthPercent)
                    .build();

        } catch (Exception e) {
            System.err.println("Error in getDashboardStats: " + e.getMessage());
            e.printStackTrace();

            // Return safe defaults
            return DashboardStatsDTO.builder()
                    .totalUsers(0L)
                    .totalShops(0L)
                    .totalProducts(0L)
                    .totalOrders(0L)
                    .totalRevenue(BigDecimal.ZERO)
                    .userGrowthPercent(0.0)
                    .shopGrowthPercent(0.0)
                    .productGrowthPercent(0.0)
                    .revenueGrowthPercent(0.0)
                    .newUsersThisMonth(0L)
                    .newShopsThisMonth(0L)
                    .ordersThisMonth(0L)
                    .revenueThisMonth(BigDecimal.ZERO)
                    .totalCommissionThisMonth(BigDecimal.ZERO)
                    .totalCommissionLastMonth(BigDecimal.ZERO)
                    .commissionGrowthPercent(0.0)
                    .build();
        }
    }

    @Override
    public OrderStatsDTO getOrderStats() {
        try {
            Long totalOrders = orderRepository.count();
            Long newOrders = 0L;
            Long processingOrders = 0L;
            Long deliveredOrders = 0L;
            Long cancelledOrders = 0L;

            try {
                // Count distinct orders that have order details with specific statuses
                newOrders = orderDetailRepository.countDistinctOrdersByStatus("NEW");
                processingOrders = orderDetailRepository.countDistinctOrdersByStatus("PROCESSING");
                deliveredOrders = orderDetailRepository.countDistinctOrdersByStatus("DELIVERED");
                cancelledOrders = orderDetailRepository.countDistinctOrdersByStatus("CANCELLED");
            } catch (Exception e) {
                System.err.println("Error counting orders by status: " + e.getMessage());
            }

            return OrderStatsDTO.builder()
                    .totalOrders(totalOrders)
                    .newOrders(newOrders)
                    .processingOrders(processingOrders)
                    .deliveredOrders(deliveredOrders)
                    .cancelledOrders(cancelledOrders)
                    .build();

        } catch (Exception e) {
            System.err.println("Error in getOrderStats: " + e.getMessage());
            return OrderStatsDTO.builder()
                    .totalOrders(0L)
                    .newOrders(0L)
                    .processingOrders(0L)
                    .deliveredOrders(0L)
                    .cancelledOrders(0L)
                    .build();
        }
    }

    @Override
    public List<Order> getRecentOrders(int limit) {
        try {
            Pageable pageable = PageRequest.of(0, limit);
            List<Order> orders = orderRepository.findAllByOrderByCreatedAtDesc(pageable).getContent();

            // Ensure order details are loaded for status calculation
            orders.forEach(order -> {
                if (order.getOrderDetails() != null) {
                    order.getOrderDetails().size(); // Force lazy loading
                }
            });

            return orders;
        } catch (Exception e) {
            System.err.println("Error getting recent orders: " + e.getMessage());
            return List.of();
        }
    }

    @Override
    public List<Product> getTopProducts(int limit) {
        try {
            Pageable pageable = PageRequest.of(0, limit);
            return productRepository.findAllByOrderByIdDesc(pageable).getContent();
        } catch (Exception e) {
            System.err.println("Error getting top products: " + e.getMessage());
            return List.of();
        }
    }

    @Override
    public CommissionSummaryDTO getCommissionSummary() {
        System.out.println("=== getCommissionSummary called ===");
        System.out.println("CommissionService status: " + (commissionService != null ? "Available" : "NULL"));

        try {
            // Try to use commission service if available
            if (commissionService != null) {
                System.out.println("Attempting to call commission service...");
                LocalDateTime now = LocalDateTime.now();
                CommissionSummaryDTO result = commissionService.getCommissionSummary(
                        now.toLocalDate().withDayOfMonth(1),
                        now.toLocalDate());
                System.out.println("Commission service returned: " + result);
                return result;
            } else {
                System.out.println("CommissionService is null - using default values");
            }
        } catch (Exception e) {
            System.err.println("Error getting commission summary: " + e.getMessage());
            e.printStackTrace();
        }

        // Always return safe default
        System.out.println("Returning default commission summary");
        return CommissionSummaryDTO.builder()
                .totalCommissionAmount(BigDecimal.ZERO)
                .collectedAmount(BigDecimal.ZERO)
                .pendingAmount(BigDecimal.ZERO)
                .totalShops(0)
                .totalRevenue(BigDecimal.ZERO)
                .build();
    }

    @Override
    public Long getTotalUsersThisMonth() {
        return 0L; // User entity doesn't have createdAt field
    }

    @Override
    public Long getTotalShopsThisMonth() {
        try {
            LocalDateTime startOfMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()).withHour(0)
                    .withMinute(0).withSecond(0);
            return shopRepository.countByCreatedAtBetween(startOfMonth, LocalDateTime.now());
        } catch (Exception e) {
            System.err.println("Error getting shops this month: " + e.getMessage());
            return 0L;
        }
    }

    @Override
    public Long getTotalOrdersThisMonth() {
        try {
            LocalDateTime startOfMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()).withHour(0)
                    .withMinute(0).withSecond(0);
            return orderRepository.countByCreatedAtBetween(startOfMonth, LocalDateTime.now());
        } catch (Exception e) {
            System.err.println("Error getting orders this month: " + e.getMessage());
            return 0L;
        }
    }

    @Override
    public Double getRevenueGrowthPercent() {
        try {
            if (commissionService != null) {
                LocalDateTime now = LocalDateTime.now();
                LocalDateTime startOfMonth = now.with(TemporalAdjusters.firstDayOfMonth()).withHour(0).withMinute(0)
                        .withSecond(0);
                LocalDateTime startOfLastMonth = startOfMonth.minusMonths(1);
                LocalDateTime endOfLastMonth = startOfMonth.minusSeconds(1);

                // Get revenue from commission data
                CommissionSummaryDTO thisMonthCommission = commissionService.getCommissionSummary(
                        startOfMonth.toLocalDate(), now.toLocalDate());
                BigDecimal revenueThisMonth = thisMonthCommission != null
                        && thisMonthCommission.getTotalRevenue() != null
                                ? thisMonthCommission.getTotalRevenue()
                                : BigDecimal.ZERO;

                CommissionSummaryDTO lastMonthCommission = commissionService.getCommissionSummary(
                        startOfLastMonth.toLocalDate(), endOfLastMonth.toLocalDate());
                BigDecimal revenueLastMonth = lastMonthCommission != null
                        && lastMonthCommission.getTotalRevenue() != null
                                ? lastMonthCommission.getTotalRevenue()
                                : BigDecimal.ZERO;

                return calculateGrowthPercent(revenueThisMonth, revenueLastMonth);
            } else {
                // Fallback to order-based calculation
                LocalDateTime now = LocalDateTime.now();
                LocalDateTime startOfMonth = now.with(TemporalAdjusters.firstDayOfMonth()).withHour(0).withMinute(0)
                        .withSecond(0);
                LocalDateTime startOfLastMonth = startOfMonth.minusMonths(1);
                LocalDateTime endOfLastMonth = startOfMonth.minusSeconds(1);

                // Calculate revenue from delivered order details
                Double revenueThisMonthDouble = orderDetailRepository.getTotalRevenueByDateRange(startOfMonth, now);
                BigDecimal revenueThisMonth = revenueThisMonthDouble != null
                        ? BigDecimal.valueOf(revenueThisMonthDouble)
                        : BigDecimal.ZERO;

                Double revenueLastMonthDouble = orderDetailRepository.getTotalRevenueByDateRange(startOfLastMonth,
                        endOfLastMonth);
                BigDecimal revenueLastMonth = revenueLastMonthDouble != null
                        ? BigDecimal.valueOf(revenueLastMonthDouble)
                        : BigDecimal.ZERO;

                return calculateGrowthPercent(revenueThisMonth, revenueLastMonth);
            }
        } catch (Exception e) {
            System.err.println("Error calculating revenue growth: " + e.getMessage());
            return 0.0;
        }
    }

    private Double calculateGrowthPercent(Long current, Long previous) {
        if (previous == null || previous == 0) {
            return current != null && current > 0 ? 100.0 : 0.0;
        }
        if (current == null)
            current = 0L;
        return ((current.doubleValue() - previous.doubleValue()) / previous.doubleValue()) * 100;
    }

    private Double calculateGrowthPercent(BigDecimal current, BigDecimal previous) {
        if (previous == null || previous.compareTo(BigDecimal.ZERO) == 0) {
            return current != null && current.compareTo(BigDecimal.ZERO) > 0 ? 100.0 : 0.0;
        }
        if (current == null)
            current = BigDecimal.ZERO;
        return current.subtract(previous).divide(previous, 4, RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100)).doubleValue();
    }
}