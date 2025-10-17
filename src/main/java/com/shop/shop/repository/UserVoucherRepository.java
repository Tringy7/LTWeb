package com.shop.shop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserVoucher;
import com.shop.shop.domain.Voucher;

public interface UserVoucherRepository extends JpaRepository<UserVoucher, Long> {

    @Query("SELECT uv FROM UserVoucher uv WHERE uv.user = :user AND uv.status = :status")
    List<UserVoucher> findByUserAndStatus(@Param("user") User user, @Param("status") Boolean status);

    @Query("SELECT uv FROM UserVoucher uv WHERE uv.user = :user AND uv.voucher = :voucher")
    Optional<UserVoucher> findByUserAndVoucher(@Param("user") User user, @Param("voucher") Voucher voucher);
}
