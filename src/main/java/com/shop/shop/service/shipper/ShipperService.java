package com.shop.shop.service.shipper;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.shop.domain.Shipper;
import com.shop.shop.repository.ShipperRepository;

@Service
public class ShipperService {

    @Autowired
    private ShipperRepository shipperRepository;

    public Optional<Shipper> getShipperByUserId(Long userId) {
        return shipperRepository.findByUser_Id(userId);
    }

    public Shipper getById(Long id) {
        return shipperRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Shipper không tồn tại"));
    }

    public void save(Shipper shipper) {
        shipperRepository.save(shipper);
    }

    public Shipper getByUserId(Long userId) {
        return shipperRepository.findByUserId(userId);
    }
}
