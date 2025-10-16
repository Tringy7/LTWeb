package com.shop.shop.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.shop.shop.domain.User;
import com.shop.shop.service.client.UserService;

@Component
public class UserAfterLogin {

    @Autowired
    private UserService userService;

    public User getUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }
        return (User) authentication.getPrincipal();
    }

    public void updateUserInSession(Long userId) {
        User latestUser = userService.findById(userId);

        if (latestUser != null) {
            Authentication currentAuth = SecurityContextHolder.getContext().getAuthentication();
            Authentication newAuth = new UsernamePasswordAuthenticationToken(
                    latestUser,
                    currentAuth.getCredentials(), // Giữ nguyên credentials
                    currentAuth.getAuthorities() // Giữ nguyên quyền
            );

            SecurityContextHolder.getContext().setAuthentication(newAuth);
        }
    }
}
