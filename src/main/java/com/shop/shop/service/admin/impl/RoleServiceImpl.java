package com.shop.shop.service.admin.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.Role;
import com.shop.shop.repository.RoleRepository;
import com.shop.shop.service.admin.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;

    public RoleServiceImpl(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    @Override
    public Optional<Role> getRoleById(Long id) {
        return roleRepository.findById(id);
    }
}
