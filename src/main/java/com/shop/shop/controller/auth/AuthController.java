package com.shop.shop.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.shop.shop.dto.UserDTO;
import com.shop.shop.service.auth.AuthenticationService;

import jakarta.validation.Valid;

@Controller
public class AuthController {

    @Autowired
    private AuthenticationService authenticationService;

    @GetMapping("/login")
    public String showLogin() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String showRegister(Model model) {
        model.addAttribute("newUser", new UserDTO());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") UserDTO registerUser, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }
        authenticationService.signup(registerUser);
        return "redirect:/login";
    }
}
