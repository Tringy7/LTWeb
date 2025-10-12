package com.shop.shop.mapper;

import com.shop.shop.domain.Role;
import com.shop.shop.domain.User;
import com.shop.shop.dto.UserResponseDTO;
import com.shop.shop.dto.UserUpdateDTO;
import org.springframework.stereotype.Component;

// Handles conversion between User entity and User-related DTOs.

@Component
public class UserMapper {

    // Converts UserUpdateDTO into a new User entity for saving to the database.

    public User toEntity(UserUpdateDTO dto, Role role) {
        if (dto == null) {
            return null;
        }

        User user = new User();
        user.setId(dto.getId());
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPhone(dto.getPhone());
        user.setAddress(dto.getAddress());
        user.setRole(role);

        return user;
    }

    // Updates an existing User entity with new data from UserUpdateDTO
    // (not modify password)

    public void updateEntityFromDTO(User user, UserUpdateDTO dto, Role role) {
        if (user == null || dto == null) {
            return;
        }

        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPhone(dto.getPhone());
        user.setAddress(dto.getAddress());
        user.setRole(role);
    }

    // Converts a User entity to UserResponseDTO
    // used for returning user info to client
    public UserResponseDTO toResponseDTO(User user) {
        if (user == null) {
            return null;
        }

        return new UserResponseDTO(
                user.getId(),
                user.getFullName(),
                user.getEmail(),
                user.getPhone(),
                user.getAddress(),
                user.getImage(),
                user.getRole() != null ? user.getRole().getName() : null,
                user.getRole() != null ? user.getRole().getId() : null);
    }

    // Converts a User entity to UserUpdateDTO (used for pre-filling edit forms).

    public UserUpdateDTO toUpdateDTO(User user) {
        if (user == null) {
            return null;
        }

        return new UserUpdateDTO(
                user.getId(),
                user.getFullName(),
                user.getEmail(),
                user.getPhone(),
                user.getAddress(),
                user.getRole() != null ? user.getRole().getId() : null,
                user.getImage());
    }
}
