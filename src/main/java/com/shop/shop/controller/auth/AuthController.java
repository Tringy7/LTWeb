package com.shop.shop.controller.auth;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.shop.shop.domain.User;
import com.shop.shop.dto.UserDTO;
import com.shop.shop.service.auth.AuthenticationService;
import com.shop.shop.service.auth.JwtService;

import jakarta.validation.Valid;

@Controller
public class AuthController {

    private final JwtService jwtService;

    private final AuthenticationService authenticationService;

    public AuthController(JwtService jwtService, AuthenticationService authenticationService) {
        this.jwtService = jwtService;
        this.authenticationService = authenticationService;
    }

    @GetMapping("/login")
    public String getMethodName(Model model) {
        model.addAttribute("userDTO", new UserDTO());
        return "auth/login";
    }

    @PostMapping("/signup")
    @Transactional
    public ResponseEntity<User> register(@RequestBody UserDTO registerUser) {
        User registeredUser = authenticationService.signup(registerUser);
        return ResponseEntity.ok(registeredUser);
    }
}
