package com.shop.shop.dto;

import com.shop.shop.service.auth.validator.RegisterChecked;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@RegisterChecked
public class UserDTO {

    private Long id;

    @NotEmpty(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng")
    private String email;

    // @PasswordValidator
    private String password;
    private String confirmPassword;

    @NotEmpty(message = "Họ tên không được để trống")
    private String fullName;
}
