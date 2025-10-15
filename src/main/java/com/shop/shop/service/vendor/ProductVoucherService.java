package com.shop.shop.service.vendor;

import com.shop.shop.domain.ProductVoucher;
import com.shop.shop.repository.ProductVoucherRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductVoucherService {

    @Autowired
    private ProductVoucherRepository voucherRepository;

    public List<ProductVoucher> getAllVouchers() {
        return voucherRepository.findAllByOrderByStartDateDesc();
    }

    public List<ProductVoucher> getVouchersByShopId(Long shopId) {
        return voucherRepository.findAllByShopId(shopId);
    }

    public ProductVoucher saveVoucher(ProductVoucher voucher) {
        return voucherRepository.save(voucher);
    }

    public ProductVoucher getVoucherById(Long id) {
        return voucherRepository.findById(id).orElse(null);
    }

    public void deleteVoucher(Long id) {
        voucherRepository.deleteById(id);
    }
}
