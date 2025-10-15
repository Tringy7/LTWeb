package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.ProductVoucher;

@Repository
public interface ProductVoucherRepository extends JpaRepository<ProductVoucher, Long> {
    List<ProductVoucher> findAllByOrderByStartDateDesc();

    @Query("SELECT v FROM ProductVoucher v JOIN v.product p WHERE p.shop.id = :shopId ORDER BY v.startDate DESC")
    List<ProductVoucher> findAllByShopId(Long shopId);

    boolean existsByCode(String code);

    @Query("SELECT COUNT(v) FROM ProductVoucher v JOIN v.product p WHERE p.shop.id = :shopId")
    long countByShopId(Long shopId);
}
