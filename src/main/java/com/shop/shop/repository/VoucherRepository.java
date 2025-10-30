package com.shop.shop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Voucher;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {

    // Find all system vouchers (shop_id is null)
    @Query("SELECT v FROM Voucher v WHERE v.shop IS NULL ORDER BY v.startDate DESC")
    List<Voucher> findAllSystemVouchers();

    // Find all vouchers including shop vouchers
    @Query("SELECT v FROM Voucher v ORDER BY v.startDate DESC")
    List<Voucher> findAllVouchers();

    // Find vouchers by status
    List<Voucher> findByStatusOrderByStartDateDesc(String status);

    // Find system vouchers by status
    @Query("SELECT v FROM Voucher v WHERE v.shop IS NULL AND v.status = :status ORDER BY v.startDate DESC")
    List<Voucher> findSystemVouchersByStatus(@Param("status") String status);

    // Find voucher by code
    Optional<Voucher> findByCode(String code);

    // Find active vouchers (system-wide)
    @Query("SELECT v FROM Voucher v WHERE v.shop IS NULL AND v.status = 'Active' AND v.startDate <= :now AND v.endDate >= :now ORDER BY v.startDate DESC")
    List<Voucher> findActiveSystemVouchers(@Param("now") LocalDateTime now);

    // Search vouchers by code or status
    @Query("SELECT v FROM Voucher v WHERE v.shop IS NULL AND (LOWER(v.code) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(v.status) LIKE LOWER(CONCAT('%', :keyword, '%'))) ORDER BY v.startDate DESC")
    List<Voucher> searchSystemVouchers(@Param("keyword") String keyword);

    // Count total system vouchers
    @Query("SELECT COUNT(v) FROM Voucher v WHERE v.shop IS NULL")
    long countSystemVouchers();

    // Count active system vouchers
    @Query("SELECT COUNT(v) FROM Voucher v WHERE v.shop IS NULL AND v.status = 'Active' AND v.startDate <= :now AND v.endDate >= :now")
    long countActiveSystemVouchers(@Param("now") LocalDateTime now);

    // Check if code exists
    boolean existsByCode(String code);

    // Find vouchers by shop ID
    @Query("SELECT v FROM Voucher v WHERE v.shop.id = :shopId ORDER BY v.startDate DESC")
    List<Voucher> findByShopId(@Param("shopId") Long shopId);

    List<Voucher> findByShop_Id(Long shopId);

    @Query("SELECT COUNT(p) FROM Voucher p WHERE p.shop.id = :shopId")
    long countByShopId(Long shopId);
}
