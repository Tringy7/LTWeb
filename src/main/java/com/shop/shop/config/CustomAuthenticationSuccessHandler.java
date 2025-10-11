package com.shop.shop.config;

import java.io.IOException;
import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if (savedRequest != null) {
            // Nếu có yêu cầu đã lưu (người dùng cố truy cập trang được bảo vệ trước khi đăng nhập),
            // chuyển hướng họ đến đó.
            redirectStrategy.sendRedirect(request, response, savedRequest.getRedirectUrl());
            clearAuthenticationAttributes(request);
            return;
        }

        // Nếu không, chuyển hướng dựa trên vai trò
        String targetUrl = determineTargetUrl(authentication.getAuthorities());

        if (response.isCommitted()) {
            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
        clearAuthenticationAttributes(request);
    }

    protected String determineTargetUrl(Collection<? extends GrantedAuthority> authorities) {
        if (authorities.stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "/admin";
        } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("ROLE_VENDOR"))) {
            return "/vendor";
        }
        return "/";
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        var session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute("SPRING_SECURITY_SAVED_REQUEST");
    }
}
