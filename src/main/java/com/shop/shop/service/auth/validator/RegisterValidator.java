package com.shop.shop.service.auth.validator;

import org.springframework.beans.factory.annotation.Autowired;

import com.shop.shop.dto.UserDTO;
import com.shop.shop.service.auth.AuthenticationService;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class RegisterValidator implements ConstraintValidator<RegisterChecked, UserDTO> {

    @Autowired
    private AuthenticationService authenticationService;

    @Override
    public boolean isValid(UserDTO user, ConstraintValidatorContext context) {
        boolean check = true;
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Mật khẩu không khớp")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            check = false;
        }

        if (authenticationService.checkEmail(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            check = false;
        }
        return check;

    }
}
