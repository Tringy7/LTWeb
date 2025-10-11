package com.shop.shop.service.admin;

import java.util.List;
import java.util.Optional;

import com.shop.shop.domain.Role;

public interface RoleService {

    // Return list
    List<Role> getAllRoles();

    // Search role by id
    Optional<Role> getRoleById(Long id);
}
