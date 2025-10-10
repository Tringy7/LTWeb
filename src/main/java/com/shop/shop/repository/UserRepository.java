package com.shop.shop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Find user by email
    Optional<User> findByEmail(String email);

    // Find users by full name containing (case insensitive)
    List<User> findByFullNameContainingIgnoreCase(String fullName);

    // Find users by email containing (case insensitive)
    List<User> findByEmailContainingIgnoreCase(String email);

    // Find users by phone containing
    List<User> findByPhoneContaining(String phone);

    // Find users by role ID using Spring Data JPA method naming
    List<User> findByRoleId(Long roleId);

    // Search users by multiple criteria using Spring Data JPA OR condition
    List<User> findByFullNameContainingIgnoreCaseOrEmailContainingIgnoreCaseOrPhoneContaining(
            String fullName, String email, String phone);

    // Search users by name and role (both conditions must match)
    List<User> findByFullNameContainingIgnoreCaseAndRoleId(String fullName, Long roleId);

    // Search users by email and role (both conditions must match)
    List<User> findByEmailContainingIgnoreCaseAndRoleId(String email, Long roleId);

    // Search users by phone and role (both conditions must match)
    List<User> findByPhoneContainingAndRoleId(String phone, Long roleId);

    // Additional useful methods using Spring Data JPA
    boolean existsByEmail(String email);

    long countByRoleId(Long roleId);
}
