package com.shop.shop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.User;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.admin.UserService;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    @Override
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public List<User> searchUsers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllUsers();
        }
        String searchKeyword = keyword.trim();
        // Use Spring Data JPA method for multi-field search
        return userRepository.findByFullNameContainingIgnoreCaseOrEmailContainingIgnoreCaseOrPhoneContaining(
                searchKeyword, searchKeyword, searchKeyword);
    }

    @Override
    public List<User> searchUsersByKeywordAndRole(String keyword, Long roleId) {
        if (keyword == null || keyword.trim().isEmpty()) {
            if (roleId != null) {
                return userRepository.findByRoleId(roleId);
            }
            return getAllUsers();
        }

        String searchKeyword = keyword.trim();

        if (roleId == null) {
            // If no role specified, search by keyword only
            return searchUsers(searchKeyword);
        }

        // Search by keyword in multiple fields AND specific role
        List<User> usersByNameAndRole = userRepository.findByFullNameContainingIgnoreCaseAndRoleId(searchKeyword,
                roleId);
        List<User> usersByEmailAndRole = userRepository.findByEmailContainingIgnoreCaseAndRoleId(searchKeyword, roleId);
        List<User> usersByPhoneAndRole = userRepository.findByPhoneContainingAndRoleId(searchKeyword, roleId);

        // Combine results and remove duplicates
        List<User> combinedResults = new java.util.ArrayList<>();
        combinedResults.addAll(usersByNameAndRole);

        for (User user : usersByEmailAndRole) {
            if (!combinedResults.contains(user)) {
                combinedResults.add(user);
            }
        }

        for (User user : usersByPhoneAndRole) {
            if (!combinedResults.contains(user)) {
                combinedResults.add(user);
            }
        }

        return combinedResults;
    }

    @Override
    public List<User> getUsersByRole(Long roleId) {
        return userRepository.findByRoleId(roleId);
    }

    @Override
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public long countUsersByRole(String roleName) {
        return userRepository.countByRoleName(roleName);
    }
}
