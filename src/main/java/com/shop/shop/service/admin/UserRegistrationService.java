package com.shop.shop.service.admin;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.User;

import lombok.RequiredArgsConstructor;

//Service to handle user registration events
// Automatically assigns system vouchers to new users

@Service
@RequiredArgsConstructor
@Transactional
public class UserRegistrationService {

    private final VoucherService voucherService;

    // Called after a new user is successfully registered
    // Automatically assigns all active system vouchers to the new user

    public void handleNewUserRegistration(User newUser) {
        try {
            voucherService.assignAllSystemVouchersToUser(newUser.getId());
            System.out.println("Successfully assigned system vouchers to new user: " + newUser.getEmail());
        } catch (Exception e) {
            System.err.println(
                    "Failed to assign system vouchers to new user " + newUser.getEmail() + ": " + e.getMessage());
            // Log the error but don't fail the registration process
        }
    }

    /**
     * Called after a new user is successfully registered (using user ID)
     */
    public void handleNewUserRegistration(Long userId) {
        try {
            voucherService.assignAllSystemVouchersToUser(userId);
            System.out.println("Successfully assigned system vouchers to new user with ID: " + userId);
        } catch (Exception e) {
            System.err
                    .println("Failed to assign system vouchers to new user with ID " + userId + ": " + e.getMessage());
            // Log the error but don't fail the registration process
        }
    }
}
