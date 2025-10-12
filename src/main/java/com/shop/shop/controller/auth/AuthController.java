package com.shop.shop.controller.auth;

import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.dto.UserDTO;
import com.shop.shop.service.auth.AuthenticationService;
import com.shop.shop.util.SendMail;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class AuthController {

    private final AuthenticationService authenticationService;
    private final SendMail sendMail;

    public AuthController(AuthenticationService authenticationService, SendMail sendMail) {
        this.authenticationService = authenticationService;
        this.sendMail = sendMail;
    }

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

    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestParam String email, HttpSession session, RedirectAttributes redirectAttributes) {
        if (authenticationService.checkEmail(email)) {
            String code = sendMail.getRandom();
            boolean sent = sendMail.sendEmail(email, code);

            if (sent) {
                session.setAttribute("reset_email", email);
                session.setAttribute("reset_code", code);
                session.setAttribute("reset_code_timestamp", LocalDateTime.now());
                redirectAttributes.addFlashAttribute("message", "Mã xác thực đã được gửi đến email của bạn.");
                redirectAttributes.addFlashAttribute("showVerifyModal", true);
                return "redirect:/login";
            } else {
                redirectAttributes.addFlashAttribute("error", "Lỗi! Không thể gửi email. Vui lòng thử lại.");
                redirectAttributes.addFlashAttribute("showForgotPasswordModal", true);
                return "redirect:/login";
            }
        } else {
            redirectAttributes.addFlashAttribute("forgotPasswordError", "Email không tồn tại trong hệ thống.");
            redirectAttributes.addFlashAttribute("showForgotPasswordModal", true);
            return "redirect:/login";
        }
    }

    @GetMapping("/verify-code")
    public String showVerifyCodeForm(HttpSession session) {
        return "redirect:/login";
    }

    @PostMapping("/verify-code")
    public String verifyCode(@RequestParam String code, HttpSession session, RedirectAttributes redirectAttributes) {
        String sessionCode = (String) session.getAttribute("reset_code");
        LocalDateTime timestamp = (LocalDateTime) session.getAttribute("reset_code_timestamp");

        if (sessionCode == null || timestamp == null) {
            return "redirect:/login";
        }

        if (LocalDateTime.now().isAfter(timestamp.plusMinutes(5))) {
            redirectAttributes.addFlashAttribute("error", "Mã xác thực đã hết hạn. Vui lòng thử lại.");
            session.removeAttribute("reset_code");
            session.removeAttribute("reset_email");
            session.removeAttribute("reset_code_timestamp");
            return "redirect:/login";
        }

        if (sessionCode.equals(code)) {
            session.setAttribute("verified", true);
            redirectAttributes.addFlashAttribute("showResetPasswordModal", true);
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("verifyCodeError", "Mã xác thực không chính xác.");
            redirectAttributes.addFlashAttribute("showVerifyModal", true);
            return "redirect:/login";
        }
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(HttpSession session) {
        return "redirect:/login";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String password, @RequestParam String confirmPassword, HttpSession session, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("reset_email");
        Boolean verified = (Boolean) session.getAttribute("verified");

        if (email == null || verified == null || !verified) {
            redirectAttributes.addFlashAttribute("error", "Phiên đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            return "redirect:/login";
        }

        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("resetPasswordError", "Mật khẩu xác nhận không khớp.");
            redirectAttributes.addFlashAttribute("showResetPasswordModal", true);
            return "redirect:/login";
        }

        authenticationService.updatePassword(email, password);
        // Clean up session attributes
        session.removeAttribute("reset_email");
        session.removeAttribute("reset_code");
        session.removeAttribute("reset_code_timestamp");
        session.removeAttribute("verified");

        redirectAttributes.addFlashAttribute("message", "Mật khẩu của bạn đã được đặt lại thành công. Vui lòng đăng nhập.");
        return "redirect:/login";
    }

}
