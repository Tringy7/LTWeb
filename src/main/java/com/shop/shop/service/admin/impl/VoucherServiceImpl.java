package com.shop.shop.service.admin.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Voucher;
import com.shop.shop.domain.User;
import com.shop.shop.domain.UserVoucher;
import com.shop.shop.dto.VoucherCreateDTO;
import com.shop.shop.dto.VoucherResponseDTO;
import com.shop.shop.dto.VoucherUpdateDTO;
import com.shop.shop.mapper.VoucherMapper;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.repository.UserVoucherRepository;
import com.shop.shop.repository.VoucherRepository;
import com.shop.shop.service.admin.VoucherService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class VoucherServiceImpl implements VoucherService {

    private final VoucherRepository voucherRepository;
    private final UserRepository userRepository;
    private final UserVoucherRepository userVoucherRepository;
    private final VoucherMapper voucherMapper;

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getAllSystemVouchers() {
        return voucherRepository.findAllSystemVouchers();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getAllVouchers() {
        return voucherRepository.findAllVouchers();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Voucher> getVoucherById(Long id) {
        return voucherRepository.findById(id);
    }

    @Override
    public Voucher createSystemVoucher(VoucherCreateDTO createDTO) {
        // Validate input
        if (!isValidDateRange(createDTO)) {
            throw new IllegalArgumentException("Invalid date range: end date must be after start date");
        }

        if (existsByCode(createDTO.getCode())) {
            throw new IllegalArgumentException("Voucher code already exists: " + createDTO.getCode());
        }

        // Create voucher entity
        Voucher voucher = voucherMapper.toVoucherEntity(createDTO);
        voucher.setShop(null); // System voucher

        // Save the voucher
        Voucher savedVoucher = voucherRepository.save(voucher);

        // Automatically assign this system voucher to all existing users
        assignVoucherToAllUsers(savedVoucher.getId());

        return savedVoucher;
    }

    @Override
    public Voucher updateVoucher(VoucherUpdateDTO updateDTO) {
        // Validate input
        if (!isValidDateRange(updateDTO)) {
            throw new IllegalArgumentException("Invalid date range: end date must be after start date");
        }

        if (existsByCodeAndNotId(updateDTO.getCode(), updateDTO.getId())) {
            throw new IllegalArgumentException("Voucher code already exists: " + updateDTO.getCode());
        }

        // Get existing voucher
        Voucher voucher = voucherRepository.findById(updateDTO.getId())
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + updateDTO.getId()));

        // Update voucher
        voucherMapper.updateVoucherFromDTO(updateDTO, voucher);

        return voucherRepository.save(voucher);
    }

    @Override
    public void deleteVoucher(Long id) {
        if (!voucherRepository.existsById(id)) {
            throw new IllegalArgumentException("Voucher not found with ID: " + id);
        }
        voucherRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> searchSystemVouchers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllSystemVouchers();
        }
        return voucherRepository.searchSystemVouchers(keyword.trim());
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getVouchersByStatus(String status) {
        return voucherRepository.findByStatusOrderByStartDateDesc(status);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getSystemVouchersByStatus(String status) {
        return voucherRepository.findSystemVouchersByStatus(status);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getActiveSystemVouchers() {
        return voucherRepository.findActiveSystemVouchers(LocalDateTime.now());
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByCode(String code) {
        return voucherRepository.existsByCode(code);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByCodeAndNotId(String code, Long id) {
        Optional<Voucher> existing = voucherRepository.findByCode(code);
        return existing.isPresent() && !existing.get().getId().equals(id);
    }

    @Override
    public boolean isValidDateRange(VoucherCreateDTO createDTO) {
        if (createDTO.getStartDate() == null || createDTO.getEndDate() == null) {
            return false;
        }
        return createDTO.getEndDate().isAfter(createDTO.getStartDate());
    }

    @Override
    public boolean isValidDateRange(VoucherUpdateDTO updateDTO) {
        if (updateDTO.getStartDate() == null || updateDTO.getEndDate() == null) {
            return false;
        }
        return updateDTO.getEndDate().isAfter(updateDTO.getStartDate());
    }

    @Override
    public void lockVoucherForViolation(Long voucherId, String reason) {
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + voucherId));

        voucher.setStatus("false");
        voucherRepository.save(voucher);
    }

    @Override
    public void unlockVoucher(Long voucherId) {
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + voucherId));

        voucher.setStatus("true");
        voucherRepository.save(voucher);
    }

    @Override
    public void activateVoucher(Long voucherId) {
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + voucherId));

        voucher.setStatus("true");
        voucherRepository.save(voucher);
    }

    @Override
    public void deactivateVoucher(Long voucherId) {
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + voucherId));

        voucher.setStatus("false");
        voucherRepository.save(voucher);
    }

    @Override
    @Transactional(readOnly = true)
    public long getTotalSystemVouchersCount() {
        return voucherRepository.countSystemVouchers();
    }

    @Override
    @Transactional(readOnly = true)
    public long getActiveSystemVouchersCount() {
        return voucherRepository.countActiveSystemVouchers(LocalDateTime.now());
    }

    @Override
    @Transactional(readOnly = true)
    public int getVoucherUsageCount(Long voucherId) {
        // Count how many users have this voucher (assigned users)
        return (int) userVoucherRepository.countByVoucherId(voucherId);
    }

    @Override
    public void enrichVoucherResponseDTO(VoucherResponseDTO dto) {
        if (dto == null || dto.getId() == null) {
            return;
        }

        // Set usage count
        dto.setUsageCount(getVoucherUsageCount(dto.getId()));

        // Update calculated fields based on current time
        LocalDateTime now = LocalDateTime.now();
        dto.setExpired(dto.getEndDate().isBefore(now));
        dto.setActive("true".equals(dto.getStatus()) &&
                dto.getStartDate().isBefore(now) &&
                dto.getEndDate().isAfter(now));
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getVouchersByShopId(Long shopId) {
        return voucherRepository.findByShopId(shopId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Voucher> getShopVouchersForModeration() {
        // Return shop vouchers that may need moderation
        // This could be based on various criteria like recent creation, suspicious
        // activity, etc.
        // For now, returning all non-system vouchers with "true" status (active)
        return voucherRepository.findAll().stream()
                .filter(v -> v.getShop() != null && "true".equals(v.getStatus()))
                .toList();
    }

    // ===== User Voucher Assignment Implementation =====

    @Override
    public void assignVoucherToAllUsers(Long voucherId) {
        // Get the voucher
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + voucherId));

        // Only assign system vouchers (vouchers with no shop)
        if (voucher.getShop() != null) {
            throw new IllegalArgumentException("Only system vouchers can be automatically assigned to all users");
        }

        // Get all users with ROLE_USER only
        List<User> allUsers = userRepository.findAll();
        List<User> regularUsers = allUsers.stream()
                .filter(user -> "ROLE_USER".equals(user.getRole().getName()))
                .toList();

        // Filter out users who already have this voucher
        List<Long> usersWithVoucherIds = userVoucherRepository.findUserIdsByVoucherId(voucherId);
        List<User> usersToAssign = regularUsers.stream()
                .filter(user -> !usersWithVoucherIds.contains(user.getId()))
                .toList();

        // Create UserVoucher entries for each regular user only
        List<UserVoucher> userVouchers = usersToAssign.stream()
                .map(user -> UserVoucher.builder()
                        .user(user)
                        .voucher(voucher)
                        .status(true) // Available for use
                        .build())
                .toList();

        // Batch save all user vouchers
        if (!userVouchers.isEmpty()) {
            userVoucherRepository.saveAll(userVouchers);
        }

        System.out.println("Assigned system voucher '" + voucher.getCode() + "' to " + userVouchers.size()
                + " regular users (ROLE_USER only). Skipped " + (regularUsers.size() - userVouchers.size())
                + " users who already had the voucher.");
    }

    @Override
    public void assignVoucherToUser(Long voucherId, Long userId) {
        // Get the voucher
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new IllegalArgumentException("Voucher not found with ID: " + voucherId));

        // Get the user
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with ID: " + userId));

        // Only assign vouchers to users with ROLE_USER
        if (!"ROLE_USER".equals(user.getRole().getName())) {
            throw new IllegalArgumentException("Vouchers can only be assigned to users with ROLE_USER. User "
                    + user.getEmail() + " has role: " + user.getRole().getName());
        }

        // Check if user already has this voucher
        if (userVoucherRepository.existsByUserIdAndVoucherId(userId, voucherId)) {
            throw new IllegalArgumentException("User already has this voucher");
        }

        // Create UserVoucher entry
        UserVoucher userVoucher = UserVoucher.builder()
                .user(user)
                .voucher(voucher)
                .status(true) // Available for use
                .build();

        userVoucherRepository.save(userVoucher);

        System.out.println("Assigned voucher '" + voucher.getCode() + "' to user: " + user.getEmail());
    }

    @Override
    public void assignAllSystemVouchersToUser(Long userId) {
        // Get the user
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with ID: " + userId));

        // Only assign vouchers to users with ROLE_USER
        if (!"ROLE_USER".equals(user.getRole().getName())) {
            System.out.println("Skipping voucher assignment for user: " + user.getEmail() + " (Role: "
                    + user.getRole().getName() + ")");
            return;
        }

        // Get all active system vouchers
        List<Voucher> systemVouchers = getActiveSystemVouchers();

        // Get vouchers that the user already has
        List<UserVoucher> existingUserVouchers = userVoucherRepository.findByUserId(userId);
        List<Long> existingVoucherIds = existingUserVouchers.stream()
                .map(uv -> uv.getVoucher().getId())
                .toList();

        // Filter out vouchers the user already has
        List<Voucher> vouchersToAssign = systemVouchers.stream()
                .filter(voucher -> !existingVoucherIds.contains(voucher.getId()))
                .toList();

        // Create UserVoucher entries for new vouchers
        List<UserVoucher> userVouchers = vouchersToAssign.stream()
                .map(voucher -> UserVoucher.builder()
                        .user(user)
                        .voucher(voucher)
                        .status(true) // Available for use
                        .build())
                .toList();

        // Batch save all user vouchers
        if (!userVouchers.isEmpty()) {
            userVoucherRepository.saveAll(userVouchers);
            System.out.println("Assigned " + userVouchers.size() + " system vouchers to new user: " + user.getEmail());
        }
    }
}
