package com.shop.shop.service.admin.impl;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Role;
import com.shop.shop.domain.Shop;
import com.shop.shop.domain.ShopSecurityInfo;
import com.shop.shop.domain.User;
import com.shop.shop.repository.RoleRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.repository.ShopSecurityInfoRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.admin.VendorApprovalService;

@Service
@Transactional
public class VendorApprovalServiceImpl implements VendorApprovalService {

    private static final Logger logger = LoggerFactory.getLogger(VendorApprovalServiceImpl.class);

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private ShopSecurityInfoRepository shopSecurityInfoRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public List<Shop> getPendingVendorApplications() {
        return shopRepository.findBySecurityInfo_VerificationStatus("Pending");
    }

    @Override
    public List<Shop> getApprovedVendors() {
        return shopRepository.findBySecurityInfo_VerificationStatus("Approved");
    }

    @Override
    public List<Shop> getRejectedVendorApplications() {
        return shopRepository.findBySecurityInfo_VerificationStatus("Rejected");
    }

    @Override
    public boolean approveVendor(Long shopId) {
        try {
            Optional<Shop> shopOpt = shopRepository.findById(shopId);
            if (shopOpt.isEmpty()) {
                logger.error("Shop not found with id: {}", shopId);
                return false;
            }

            Shop shop = shopOpt.get();
            shop.setStatus("Active");
            User user = shop.getUser();
            ShopSecurityInfo securityInfo = shop.getSecurityInfo();

            if (user == null || securityInfo == null) {
                logger.error("User or security info not found for shop id: {}", shopId);
                return false;
            }

            // Check if already approved
            if ("APPROVED".equals(securityInfo.getVerificationStatus())) {
                logger.warn("Vendor already approved for shop id: {}", shopId);
                return true;
            }

            // Get ROLE_VENDOR
            Optional<Role> vendorRoleOpt = roleRepository.findByName("ROLE_VENDOR");
            if (vendorRoleOpt.isEmpty()) {
                logger.error("ROLE_VENDOR not found in database");
                return false;
            }

            Role vendorRole = vendorRoleOpt.get();

            // Update user role to ROLE_VENDOR
            user.setRole(vendorRole);
            userRepository.save(user);

            // Update shop security info status to Approved
            securityInfo.setVerificationStatus("APPROVED");
            shopSecurityInfoRepository.save(securityInfo);
            shopRepository.save(shop);

            logger.info("Successfully approved vendor for shop id: {}, user: {}", shopId, user.getEmail());
            return true;

        } catch (Exception e) {
            logger.error("Error approving vendor for shop id: {}", shopId, e);
            return false;
        }
    }

    @Override
    public boolean rejectVendor(Long shopId, String rejectionReason) {
        try {
            Optional<Shop> shopOpt = shopRepository.findById(shopId);
            if (shopOpt.isEmpty()) {
                logger.error("Shop not found with id: {}", shopId);
                return false;
            }

            Shop shop = shopOpt.get();
            ShopSecurityInfo securityInfo = shop.getSecurityInfo();

            if (securityInfo == null) {
                logger.error("Security info not found for shop id: {}", shopId);
                return false;
            }

            // Update shop security info status to Rejected
            securityInfo.setVerificationStatus("Rejected");
            shopSecurityInfoRepository.save(securityInfo);

            // Note: We keep the user role as ROLE_USER (no change needed)
            logger.info("Successfully rejected vendor for shop id: {}, reason: {}", shopId, rejectionReason);
            return true;

        } catch (Exception e) {
            logger.error("Error rejecting vendor for shop id: {}", shopId, e);
            return false;
        }
    }

    @Override
    public Shop getVendorApplicationDetails(Long shopId) {
        return shopRepository.findById(shopId).orElse(null);
    }

    @Override
    public VendorStatisticsDto getVendorStatistics() {
        long totalApplications = shopRepository.count();
        long pendingApplications = shopRepository.countBySecurityInfo_VerificationStatus("Pending");
        long approvedVendors = shopRepository.countBySecurityInfo_VerificationStatus("Approved");
        long rejectedApplications = shopRepository.countBySecurityInfo_VerificationStatus("Rejected");

        return new VendorStatisticsDto(totalApplications, pendingApplications, approvedVendors, rejectedApplications);
    }
}
