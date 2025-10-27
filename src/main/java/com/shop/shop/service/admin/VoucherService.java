package com.shop.shop.service.admin;

import java.util.List;
import java.util.Optional;

import com.shop.shop.domain.Voucher;
import com.shop.shop.dto.VoucherCreateDTO;
import com.shop.shop.dto.VoucherResponseDTO;
import com.shop.shop.dto.VoucherUpdateDTO;

public interface VoucherService {

    // Get all system vouchers (shop_id is null)
    List<Voucher> getAllSystemVouchers();

    // Get all vouchers (system and shop vouchers)
    List<Voucher> getAllVouchers();

    // Get voucher by ID
    Optional<Voucher> getVoucherById(Long id);

    // Create new system voucher
    Voucher createSystemVoucher(VoucherCreateDTO createDTO);

    // Update voucher
    Voucher updateVoucher(VoucherUpdateDTO updateDTO);

    // Delete voucher by ID
    void deleteVoucher(Long id);

    // ===== Search and Filter =====

    // Search system vouchers by keyword (code, status)
    List<Voucher> searchSystemVouchers(String keyword);

    // Get vouchers by status
    List<Voucher> getVouchersByStatus(String status);

    // Get system vouchers by status
    List<Voucher> getSystemVouchersByStatus(String status);

    // Get active system vouchers
    List<Voucher> getActiveSystemVouchers();

    // ===== Voucher Validation =====

    // Check if voucher code exists
    boolean existsByCode(String code);

    // Check if voucher code exists for other voucher (for updates)
    boolean existsByCodeAndNotId(String code, Long id);

    // Validate voucher dates
    boolean isValidDateRange(VoucherCreateDTO createDTO);

    // Validate voucher dates for update
    boolean isValidDateRange(VoucherUpdateDTO updateDTO);

    // ===== Admin Moderation Actions =====

    // Lock voucher for policy violation (disable voucher)
    void lockVoucherForViolation(Long voucherId, String reason);

    // Unlock voucher (re-enable voucher)
    void unlockVoucher(Long voucherId);

    // Activate voucher
    void activateVoucher(Long voucherId);

    // Deactivate voucher
    void deactivateVoucher(Long voucherId);

    // ===== Statistics =====

    // Get total system vouchers count
    long getTotalSystemVouchersCount();

    // Get active system vouchers count
    long getActiveSystemVouchersCount();

    // Get voucher usage count
    int getVoucherUsageCount(Long voucherId);

    // Enrich VoucherResponseDTO with calculated fields
    void enrichVoucherResponseDTO(VoucherResponseDTO dto);

    // ===== Shop Voucher Management =====

    // Get vouchers by shop ID
    List<Voucher> getVouchersByShopId(Long shopId);

    // Get shop vouchers that violate policies (for moderation)
    List<Voucher> getShopVouchersForModeration();

    // ===== User Voucher Assignment =====

    /**
     * Assign system voucher to all existing users
     * This is automatically called when creating a system voucher
     */
    void assignVoucherToAllUsers(Long voucherId);

    // Assign voucher to a specific user
    void assignVoucherToUser(Long voucherId, Long userId);

    // Assign all active system vouchers to a new user (for new user registration)
    void assignAllSystemVouchersToUser(Long userId);
}
