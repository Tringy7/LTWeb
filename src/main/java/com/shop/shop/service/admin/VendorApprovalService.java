package com.shop.shop.service.admin;

import java.util.List;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.ShopSecurityInfo;

public interface VendorApprovalService {

    /**
     * Get all pending vendor applications
     */
    List<Shop> getPendingVendorApplications();

    /**
     * Get all approved vendors
     */
    List<Shop> getApprovedVendors();

    /**
     * Get all rejected vendor applications
     */
    List<Shop> getRejectedVendorApplications();

    /**
     * Approve a vendor application
     * - Change user role from ROLE_USER to ROLE_VENDOR
     * - Update shop security info status to "Approved"
     */
    boolean approveVendor(Long shopId);

    /**
     * Reject a vendor application
     * - Update shop security info status to "Rejected"
     * - Keep user role as ROLE_USER
     */
    boolean rejectVendor(Long shopId, String rejectionReason);

    /**
     * Get vendor application details
     */
    Shop getVendorApplicationDetails(Long shopId);

    /**
     * Get vendor statistics
     */
    VendorStatisticsDto getVendorStatistics();

    /**
     * DTO for vendor statistics
     */
    class VendorStatisticsDto {
        private long totalApplications;
        private long pendingApplications;
        private long approvedVendors;
        private long rejectedApplications;

        // Constructor
        public VendorStatisticsDto(long totalApplications, long pendingApplications,
                long approvedVendors, long rejectedApplications) {
            this.totalApplications = totalApplications;
            this.pendingApplications = pendingApplications;
            this.approvedVendors = approvedVendors;
            this.rejectedApplications = rejectedApplications;
        }

        // Getters
        public long getTotalApplications() {
            return totalApplications;
        }

        public long getPendingApplications() {
            return pendingApplications;
        }

        public long getApprovedVendors() {
            return approvedVendors;
        }

        public long getRejectedApplications() {
            return rejectedApplications;
        }

        // Setters
        public void setTotalApplications(long totalApplications) {
            this.totalApplications = totalApplications;
        }

        public void setPendingApplications(long pendingApplications) {
            this.pendingApplications = pendingApplications;
        }

        public void setApprovedVendors(long approvedVendors) {
            this.approvedVendors = approvedVendors;
        }

        public void setRejectedApplications(long rejectedApplications) {
            this.rejectedApplications = rejectedApplications;
        }
    }
}
