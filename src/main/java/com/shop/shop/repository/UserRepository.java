package com.shop.shop.repository.client;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);
}
