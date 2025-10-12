package com.shop.shop.service.admin;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import com.shop.shop.dto.CommissionCalculationRequestDTO;
import com.shop.shop.dto.CommissionResponseDTO;
import com.shop.shop.dto.CommissionSummaryDTO;

public interface CommissionService {

    // Calculate commissions based on request
    List<CommissionResponseDTO> calculateCommissions(CommissionCalculationRequestDTO request);

    // Calculate this month's commissions
    List<CommissionResponseDTO> calculateThisMonthCommissions();

    // Calculate commissions up to now
    List<CommissionResponseDTO> calculateCommissionsUpToNow();

    // Get all commissions
    List<CommissionResponseDTO> getAllCommissions();

    // Get commissions by date range
    List<CommissionResponseDTO> getCommissionsByDateRange(LocalDate fromDate, LocalDate toDate);

    // Get commissions by shop - INTERFACE METHOD (NO BODY)
    List<CommissionResponseDTO> getCommissionsByShop(Long shopId);

    // Get commission by ID
    Optional<CommissionResponseDTO> getCommissionById(Long id);

    // Mark commission as collected
    CommissionResponseDTO markAsCollected(Long commissionId);

    // Get commission summary
    CommissionSummaryDTO getCommissionSummary(LocalDate fromDate, LocalDate toDate);

    // Delete commission
    void deleteCommission(Long id);
}