package com.shop.shop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserVoucher;
import com.shop.shop.domain.Voucher;

@Repository
public interface UserVoucherRepository extends JpaRepository<UserVoucher, Long> {

    // Find user vouchers by user ID
    List<UserVoucher> findByUserId(Long userId);

    // Find user vouchers by voucher ID
    List<UserVoucher> findByVoucherId(Long voucherId);

    // Find user voucher by user ID and voucher ID
    Optional<UserVoucher> findByUserIdAndVoucherId(Long userId, Long voucherId);

    // Find available vouchers for a user (status = true)
    @Query("SELECT uv FROM UserVoucher uv WHERE uv.user.id = :userId AND uv.status = true")
    List<UserVoucher> findAvailableVouchersByUserId(@Param("userId") Long userId);

    // Find used vouchers for a user (status = false)
    @Query("SELECT uv FROM UserVoucher uv WHERE uv.user.id = :userId AND uv.status = false")
    List<UserVoucher> findUsedVouchersByUserId(@Param("userId") Long userId);

    // Check if user has a specific voucher
    boolean existsByUserIdAndVoucherId(Long userId, Long voucherId);

    // Count total vouchers for a user
    long countByUserId(Long userId);

    // Count available vouchers for a user
    @Query("SELECT COUNT(uv) FROM UserVoucher uv WHERE uv.user.id = :userId AND uv.status = true")
    long countAvailableVouchersByUserId(@Param("userId") Long userId);

    // Count how many users have a specific voucher
    long countByVoucherId(Long voucherId);

    // Get all users who have a specific voucher
    @Query("SELECT uv FROM UserVoucher uv WHERE uv.voucher.id = :voucherId")
    List<UserVoucher> findAllByVoucherId(@Param("voucherId") Long voucherId);

    // Get user IDs who have a specific voucher
    @Query("SELECT uv.user.id FROM UserVoucher uv WHERE uv.voucher.id = :voucherId")
    List<Long> findUserIdsByVoucherId(@Param("voucherId") Long voucherId);

    @Query("SELECT uv FROM UserVoucher uv WHERE uv.user = :user AND uv.status = :status")
    List<UserVoucher> findByUserAndStatus(@Param("user") User user, @Param("status") Boolean status);

    @Query("SELECT uv FROM UserVoucher uv WHERE uv.user = :user AND uv.voucher = :voucher")
    Optional<UserVoucher> findByUserAndVoucher(@Param("user") User user, @Param("voucher") Voucher voucher);
}
