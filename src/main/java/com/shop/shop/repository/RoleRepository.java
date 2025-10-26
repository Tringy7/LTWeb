package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {

    // Find role by name
    java.util.Optional<Role> findByName(String name);
}
