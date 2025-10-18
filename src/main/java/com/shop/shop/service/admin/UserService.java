package com.shop.shop.service.admin;

import java.util.List;
import java.util.Optional;

import com.shop.shop.domain.User;

public interface UserService {

    // Get all users
    List<User> getAllUsers();

    // Get user by ID
    Optional<User> getUserById(Long id);

    // Get user by email
    Optional<User> getUserByEmail(String email);

    // Search users by keyword
    List<User> searchUsers(String keyword);

    // Search users by keyword and role
    List<User> searchUsersByKeywordAndRole(String keyword, Long roleId);

    // Get users by role
    List<User> getUsersByRole(Long roleId);

    // Save user
    User saveUser(User user);

    // Delete user by ID
    void deleteUser(Long id);

    // Check if email exists
    boolean existsByEmail(String email);

    // Count users by role name
    long countUsersByRole(String roleName);
}
