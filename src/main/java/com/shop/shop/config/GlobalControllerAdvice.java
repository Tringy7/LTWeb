package com.shop.shop.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.shop.shop.domain.User;

@ControllerAdvice
public class GlobalControllerAdvice {

    /**
     * This method adds the currently authenticated user to the model for all
     * controllers. This allows JSP views to access user information via the
     * 'acc' attribute, mimicking session-based behavior in a stateless (JWT)
     * context.
     *
     * @return The authenticated User object, or null if no user is
     * authenticated.
     */
    @ModelAttribute("acc")
    public User globalUserObject() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof User) {
            return (User) authentication.getPrincipal();
        }
        return null;
    }
}
