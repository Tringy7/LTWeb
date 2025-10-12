package com.shop.shop.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {

    private Long id;

    @NotEmpty(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng")
    private String email;

    @NotEmpty(message = "Mật khẩu không được để trống")
    private String password;

    private String fullName;

    private String address;

    private String phone;

    private String avatar;

    private boolean rememberMe;

    // Constructors, Getters, and Setters
    public boolean isRememberMe() {
        return rememberMe;
    }
}
