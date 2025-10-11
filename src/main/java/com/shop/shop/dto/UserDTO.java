package com.shop.shop.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {

    @Email(message = "Email không hợp lệ")
    @NotNull(message = "Email không được để trống")
    private String email;

    private String fullName;

    @NotNull(message = "Mật khẩu không được để trống")
    private String password;
    private boolean rememberMe;
}
