package com.shop.shop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// DTO for returning user data to the client 

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserResponseDTO {

    private Long id;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String image;
    private String roleName;
    private Long roleId;

    @Override
    public String toString() {
        return "UserResponseDTO{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", image='" + image + '\'' +
                ", roleName='" + roleName + '\'' +
                ", roleId=" + roleId +
                '}';
    }
}
