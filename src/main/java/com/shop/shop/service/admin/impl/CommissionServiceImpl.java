package com.shop.shop.service.admin.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Commission;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.Shop;
import com.shop.shop.dto.CommissionCalculationRequestDTO;
import com.shop.shop.dto.CommissionResponseDTO;
import com.shop.shop.dto.CommissionSummaryDTO;
import com.shop.shop.mapper.CommissionMapper;
import com.shop.shop.repository.CommissionRepository;
import com.shop.shop.repository.OrderRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.service.admin.CommissionService;

import lombok.RequiredArgsConstructor;

@Service("adminCommissionService")
@RequiredArgsConstructor
public class CommissionServiceImpl implements CommissionService {

        private final CommissionRepository commissionRepository;
        private final OrderRepository orderRepository;
        private final ShopRepository shopRepository;
        private final CommissionMapper commissionMapper;

        private static final BigDecimal DEFAULT_COMMISSION_RATE = new BigDecimal("5.00"); // 5%

        @Override
        @Transactional
        public List<CommissionResponseDTO> calculateCommissions(CommissionCalculationRequestDTO request) {
                LocalDate fromDate = request.getFromDate();
                LocalDate toDate = request.getToDate();

                // Create a final variable for the actual end date
                final LocalDate actualToDate = (request.getCalculateUpToNow() != null && request.getCalculateUpToNow())
                                ? LocalDate.now()
                                : toDate;

                LocalDateTime fromDateTime = fromDate.atStartOfDay();
                LocalDateTime toDateTime = actualToDate.atTime(23, 59, 59);

                // Get all delivered orders in the date range
                List<Order> deliveredOrders = orderRepository.findByStatusAndCreatedAtBetween("DELIVERED", fromDateTime,
                                toDateTime);

                // Group orders by shop and by month-year
                Map<Long, Map<YearMonth, List<Order>>> ordersByShopAndMonth = deliveredOrders.stream()
                                .filter(order -> order.getShop() != null && order.getTotalPrice() != null)
                                .collect(Collectors.groupingBy(
                                                order -> order.getShop().getId(),
                                                Collectors.groupingBy(order -> YearMonth.from(order.getCreatedAt()))));

                List<CommissionResponseDTO> results = new ArrayList<>();

                // For each shop and each month, calculate commission if not already exists
                for (Map.Entry<Long, Map<YearMonth, List<Order>>> shopEntry : ordersByShopAndMonth.entrySet()) {
                        Long shopId = shopEntry.getKey();
                        Map<YearMonth, List<Order>> monthlyOrders = shopEntry.getValue();

                        for (Map.Entry<YearMonth, List<Order>> monthEntry : monthlyOrders.entrySet()) {
                                YearMonth yearMonth = monthEntry.getKey();
                                List<Order> ordersInMonth = monthEntry.getValue();

                                Optional<CommissionResponseDTO> commission = calculateMonthlyCommissionForShop(
                                                shopId, yearMonth, ordersInMonth);
                                if (commission.isPresent()) {
                                        results.add(commission.get());
                                }
                        }
                }

                return results;
        }

        private Optional<CommissionResponseDTO> calculateMonthlyCommissionForShop(Long shopId, YearMonth yearMonth,
                        List<Order> ordersInMonth) {
                try {
                        // Get shop information
                        Optional<Shop> shopOpt = shopRepository.findById(shopId);
                        if (shopOpt.isEmpty()) {
                                return Optional.empty();
                        }
                        Shop shop = shopOpt.get();

                        // Define the period for this month
                        LocalDate periodStart = yearMonth.atDay(1);
                        LocalDate periodEnd = yearMonth.atEndOfMonth();

                        // Check if commission already exists for this shop and month
                        boolean exists = commissionRepository.existsByShopIdAndPeriodStartAndPeriodEnd(shopId,
                                        periodStart,
                                        periodEnd);
                        if (exists) {
                                return Optional.empty(); // Skip if already calculated for this month
                        }

                        // Calculate total revenue for this month using the orders provided
                        BigDecimal totalRevenue = ordersInMonth.stream()
                                        .filter(order -> order.getTotalPrice() != null)
                                        .map(this::getOrderTotal)
                                        .filter(amount -> amount != null)
                                        .reduce(BigDecimal.ZERO, BigDecimal::add);

                        if (totalRevenue.compareTo(BigDecimal.ZERO) <= 0) {
                                return Optional.empty(); // No revenue to calculate commission
                        }

                        // Calculate commission amount (totalRevenue * percent / 100)
                        BigDecimal commissionAmount = totalRevenue.multiply(DEFAULT_COMMISSION_RATE)
                                        .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

                        // Create and save commission record for this specific month
                        Commission commission = Commission.builder()
                                        .shop(shop)
                                        .periodStart(periodStart)
                                        .periodEnd(periodEnd)
                                        .totalRevenue(totalRevenue)
                                        .percent(DEFAULT_COMMISSION_RATE)
                                        .amount(commissionAmount)
                                        .status("pending")
                                        .createdAt(LocalDateTime.now())
                                        .build();

                        Commission savedCommission = commissionRepository.save(commission);

                        // Convert to DTO using mapper
                        CommissionResponseDTO dto = commissionMapper.toResponseDTO(savedCommission);
                        dto.setShopName(shop.getShopName());

                        return Optional.of(dto);

                } catch (Exception e) {
                        // Log error and continue with other shops
                        System.err.println("Error calculating commission for shop " + shopId + " for month " + yearMonth
                                        + ": "
                                        + e.getMessage());
                        return Optional.empty();
                }
        }

        @Override
        public List<CommissionResponseDTO> calculateThisMonthCommissions() {
                YearMonth currentMonth = YearMonth.now();
                LocalDate fromDate = currentMonth.atDay(1);
                LocalDate toDate = currentMonth.atEndOfMonth();

                CommissionCalculationRequestDTO request = new CommissionCalculationRequestDTO(fromDate, toDate, false);
                return calculateCommissions(request);
        }

        @Override
        public List<CommissionResponseDTO> calculateCommissionsUpToNow() {
                // Calculate commissions from January 2020 to now, month by month
                LocalDate startDate = LocalDate.of(2020, 1, 1);
                LocalDate endDate = LocalDate.now();

                CommissionCalculationRequestDTO request = new CommissionCalculationRequestDTO(startDate, endDate, true);
                return calculateCommissions(request);
        }

        @Override
        public List<CommissionResponseDTO> getCommissionsByShop(Long shopId) {
                List<Commission> commissions = commissionRepository.findByShop_IdOrderByCreatedAtDesc(shopId);
                return commissions.stream()
                                .map(this::enrichCommissionWithShopName)
                                .collect(Collectors.toList());
        }

        @Override
        public List<CommissionResponseDTO> getCommissionsByDateRange(LocalDate fromDate, LocalDate toDate) {
                LocalDateTime fromDateTime = fromDate.atStartOfDay();
                LocalDateTime toDateTime = toDate.atTime(23, 59, 59);

                List<Commission> commissions = commissionRepository.findByCreatedAtBetweenOrderByCreatedAtDesc(
                                fromDateTime,
                                toDateTime);
                return commissions.stream()
                                .map(this::enrichCommissionWithShopName)
                                .collect(Collectors.toList());
        }

        @Override
        public List<CommissionResponseDTO> getAllCommissions() {
                List<Commission> commissions = commissionRepository.findAll();
                return commissions.stream()
                                .map(this::enrichCommissionWithShopName)
                                .collect(Collectors.toList());
        }

        @Override
        public Optional<CommissionResponseDTO> getCommissionById(Long id) {
                Optional<Commission> commission = commissionRepository.findById(id);
                return commission.map(this::enrichCommissionWithShopName);
        }

        @Override
        @Transactional
        public CommissionResponseDTO markAsCollected(Long commissionId) {
                Commission commission = commissionRepository.findById(commissionId)
                                .orElseThrow(() -> new RuntimeException(
                                                "Commission not found with id: " + commissionId));

                commission.setStatus("collected"); // Use lowercase to match entity
                commission.setCreatedAt(LocalDateTime.now()); // Update timestamp

                Commission savedCommission = commissionRepository.save(commission);
                return enrichCommissionWithShopName(savedCommission);
        }

        @Override
        public CommissionSummaryDTO getCommissionSummary(LocalDate fromDate, LocalDate toDate) {
                LocalDateTime fromDateTime = fromDate.atStartOfDay();
                LocalDateTime toDateTime = toDate.atTime(23, 59, 59);

                // Get all commissions in the date range using simple repository method
                List<Commission> commissions = commissionRepository.findByCreatedAtBetweenOrderByCreatedAtDesc(
                                fromDateTime,
                                toDateTime);

                // Calculate summary using Java streams instead of SQL
                BigDecimal totalCommissionAmount = commissions.stream()
                                .map(Commission::getAmount)
                                .filter(amount -> amount != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                Long uniqueShops = commissions.stream()
                                .filter(c -> c.getShop() != null) // Filter out null shops
                                .map(c -> c.getShop().getId())
                                .distinct()
                                .count();

                Integer totalShops = uniqueShops.intValue();

                // Calculate total platform revenue (commission amount * 100 / commission rate)
                BigDecimal totalPlatformRevenue = totalCommissionAmount.compareTo(BigDecimal.ZERO) > 0
                                ? totalCommissionAmount.multiply(BigDecimal.valueOf(100)).divide(
                                                DEFAULT_COMMISSION_RATE, 2,
                                                RoundingMode.HALF_UP)
                                : BigDecimal.ZERO;

                // Calculate average commission per shop
                BigDecimal averageCommissionPerShop = totalShops > 0
                                ? totalCommissionAmount.divide(new BigDecimal(totalShops), 2, RoundingMode.HALF_UP)
                                : BigDecimal.ZERO;

                // Count collected and pending commissions
                Integer collectedCommissions = (int) commissions.stream()
                                .filter(c -> "collected".equalsIgnoreCase(c.getStatus()))
                                .count();

                Integer pendingCommissions = (int) commissions.stream()
                                .filter(c -> "pending".equalsIgnoreCase(c.getStatus()))
                                .count();

                // Calculate collected and pending amounts
                BigDecimal collectedAmount = commissions.stream()
                                .filter(c -> "collected".equalsIgnoreCase(c.getStatus()))
                                .map(Commission::getAmount)
                                .filter(amount -> amount != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                BigDecimal pendingAmount = commissions.stream()
                                .filter(c -> "pending".equalsIgnoreCase(c.getStatus()))
                                .map(Commission::getAmount)
                                .filter(amount -> amount != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                return CommissionSummaryDTO.builder()
                                .totalShops(totalShops)
                                .totalRevenue(totalPlatformRevenue)
                                .totalCommissionAmount(totalCommissionAmount)
                                .averageCommissionPerShop(averageCommissionPerShop)
                                .commissionPercent(DEFAULT_COMMISSION_RATE)
                                .summaryDate(LocalDate.now())
                                .periodType("CUSTOM")
                                .periodStart(fromDate)
                                .periodEnd(toDate)
                                .collectedCommissions(collectedCommissions)
                                .pendingCommissions(pendingCommissions)
                                .collectedAmount(collectedAmount)
                                .pendingAmount(pendingAmount)
                                .build();
        }

        @Override
        @Transactional
        public void deleteCommission(Long id) {
                commissionRepository.deleteById(id);
        }

        private CommissionResponseDTO enrichCommissionWithShopName(Commission commission) {
                CommissionResponseDTO dto = commissionMapper.toResponseDTO(commission);

                if (commission.getShop() != null) {
                        dto.setShopName(commission.getShop().getShopName()); // Fixed: Use getName() instead of
                                                                             // getShopName()
                }

                return dto;
        }

        // Helper method to get order total - you need to replace this with the correct
        // field name from Order entity
        private BigDecimal getOrderTotal(Order order) {
                // The Order entity has a field called "totalPrice" of type Double
                if (order != null && order.getTotalPrice() != null) {
                        return BigDecimal.valueOf(order.getTotalPrice());
                }
                return BigDecimal.ZERO;
        }
}