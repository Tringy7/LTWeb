package com.shop.shop.repository;

import com.shop.shop.domain.UserVoucher;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserVoucherRepository extends JpaRepository<UserVoucher, Long> {
}
