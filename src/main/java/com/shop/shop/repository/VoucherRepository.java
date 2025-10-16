package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.User;
import com.shop.shop.domain.Voucher;

public interface VoucherRepository extends JpaRepository<Voucher, Long> {

    List<Voucher> findByUserAndStatus(User user, boolean status);

    Voucher findByCode(String code);
}
