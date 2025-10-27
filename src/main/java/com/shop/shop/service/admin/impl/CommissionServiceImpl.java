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
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Shop;
import com.shop.shop.dto.CommissionCalculationRequestDTO;
import com.shop.shop.dto.CommissionResponseDTO;
import com.shop.shop.dto.CommissionSummaryDTO;
import com.shop.shop.mapper.CommissionMapper;
import com.shop.shop.repository.CommissionRepository;
import com.shop.shop.repository.OrderDetailRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.service.admin.CommissionService;

import lombok.RequiredArgsConstructor;

@Service("adminCommissionService")
@RequiredArgsConstructor
public class CommissionServiceImpl implements CommissionService {

        private final CommissionRepository commissionRepository;
        private final OrderDetailRepository orderDetailRepository;
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

                // Debug logging
                System.out.println("=== Commission Calculation Debug ===");
                System.out.println("From: " + fromDateTime + ", To: " + toDateTime);

                // Get all delivered order details in the date range
                List<OrderDetail> deliveredOrderDetails = orderDetailRepository
                                .findByStatusAndOrderCreatedAtBetween("DELIVERED", fromDateTime, toDateTime);

                System.out.println("Found " + deliveredOrderDetails.size() + " delivered order details");

                // Debug: Print some sample order details
                if (!deliveredOrderDetails.isEmpty()) {
                        OrderDetail sample = deliveredOrderDetails.get(0);
                        System.out.println("Sample OrderDetail - ID: " + sample.getId() +
                                        ", Status: " + sample.getStatus() +
                                        ", FinalPrice: " + sample.getFinalPrice() +
                                        ", Shop: " + (sample.getShop() != null ? sample.getShop().getId() : "null") +
                                        ", Order Date: "
                                        + (sample.getOrder() != null ? sample.getOrder().getCreatedAt() : "null"));
                }

                // Group by shop and month
                Map<Long, Map<YearMonth, List<OrderDetail>>> detailsByShopAndMonth = deliveredOrderDetails.stream()
                                .filter(detail -> detail.getShop() != null && detail.getOrder() != null &&
                                                detail.getFinalPrice() != null)
                                .collect(Collectors.groupingBy(
                                                detail -> detail.getShop().getId(),
                                                Collectors.groupingBy(
                                                                detail -> YearMonth.from(
                                                                                detail.getOrder().getCreatedAt()))));

        List<CommissionResponseDTO> results = new ArrayList<>();

                System.out.println("Grouped by " + detailsByShopAndMonth.size() + " shops");

                // Calculate commission for each shop per month
                for (Map.Entry<Long, Map<YearMonth, List<OrderDetail>>> shopEntry : detailsByShopAndMonth.entrySet()) {
                        Long shopId = shopEntry.getKey();
                        Map<YearMonth, List<OrderDetail>> monthlyOrderDetails = shopEntry.getValue();

                        System.out.println("Processing shop " + shopId + " with " + monthlyOrderDetails.size()
                                        + " months");

                        for (Map.Entry<YearMonth, List<OrderDetail>> monthEntry : monthlyOrderDetails.entrySet()) {
                                YearMonth yearMonth = monthEntry.getKey();
                                List<OrderDetail> orderDetails = monthEntry.getValue();

                                System.out.println("  Month " + yearMonth + " has " + orderDetails.size()
                                                + " order details");

                                Optional<CommissionResponseDTO> commission = calculateMonthlyCommissionForShop(
                                                shopId, yearMonth, orderDetails);
                                if (commission.isPresent()) {
                                        results.add(commission.get());
                                        System.out.println("  ✓ Commission created for shop " + shopId + " month "
                                                        + yearMonth);
                                } else {
                                        System.out.println("  ✗ No commission created for shop " + shopId + " month "
                                                        + yearMonth);
                                }
                        }
                }

        return results;
    }

        private Optional<CommissionResponseDTO> calculateMonthlyCommissionForShop(Long shopId,
                        YearMonth yearMonth,
                        List<OrderDetail> orderDetails) {

                System.out.println("    calculateMonthlyCommissionForShop - Shop: " + shopId + ", Month: " + yearMonth);

                // Get shop information
                Optional<Shop> shopOpt = shopRepository.findById(shopId);
                if (shopOpt.isEmpty()) {
                        System.out.println("    ✗ Shop not found: " + shopId);
                        return Optional.empty();
                }
                Shop shop = shopOpt.get();

                // Set period start and end for the month
                LocalDate periodStart = yearMonth.atDay(1);
                LocalDate periodEnd = yearMonth.atEndOfMonth();

                // Check if commission already exists for this shop and period
                boolean commissionExists = commissionRepository.existsByShopIdAndPeriodStartAndPeriodEnd(
                                shopId, periodStart, periodEnd);

                if (commissionExists) {
                        System.out.println("    ✗ Commission already exists for shop " + shopId + " period "
                                        + periodStart + " to " + periodEnd);
                        return Optional.empty();
                }

                // Calculate total revenue from delivered order details (finalPrice is already
                // the total)
                BigDecimal totalRevenue = orderDetails.stream()
                                .filter(detail -> detail.getFinalPrice() != null)
                                .map(detail -> new BigDecimal(detail.getFinalPrice().toString()))
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                System.out.println("    Total revenue calculated: " + totalRevenue);

                // Only create commission if there's revenue
                if (totalRevenue.compareTo(BigDecimal.ZERO) <= 0) {
                        System.out.println("    ✗ No revenue found for shop " + shopId);
                        return Optional.empty();
                }

                // Calculate commission amount
                BigDecimal commissionAmount = totalRevenue
                                .multiply(DEFAULT_COMMISSION_RATE.divide(new BigDecimal("100"), 4,
                                                RoundingMode.HALF_UP));

                // Create and save commission record
                Commission commission = Commission.builder()
                                .shop(shop)
                                .periodStart(periodStart)
                                .periodEnd(periodEnd)
                                .totalRevenue(totalRevenue)
                                .percent(DEFAULT_COMMISSION_RATE)
                                .amount(commissionAmount)
                                .status("pending") // Use consistent lowercase status
                                .createdAt(LocalDateTime.now())
                                .build();

                Commission savedCommission = commissionRepository.save(commission);

                // Convert to DTO
                CommissionResponseDTO responseDTO = new CommissionResponseDTO();
                responseDTO.setId(savedCommission.getId());
                responseDTO.setShopId(savedCommission.getShopId());
                responseDTO.setShopName(savedCommission.getShop().getShopName());
                responseDTO.setFromDate(savedCommission.getFromDate());
                responseDTO.setToDate(savedCommission.getToDate());
                responseDTO.setTotalRevenue(savedCommission.getTotalRevenue());
                responseDTO.setCommissionRate(savedCommission.getCommissionRate());
                responseDTO.setCommissionAmount(savedCommission.getCommissionAmount());
                responseDTO.setCalculationDate(savedCommission.getCalculationDate());
                responseDTO.setStatus(savedCommission.getStatus());

                return Optional.of(responseDTO);
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
