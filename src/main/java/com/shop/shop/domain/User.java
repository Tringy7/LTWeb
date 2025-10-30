package com.shop.shop.domain;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String fullName;

    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(nullable = false, length = 255)
    private String password;

    @Column(length = 50)
    private String phone;

    @Column(length = 50)
    private String address;

    @Column(length = 255)
    private String image;

    @ManyToOne
    @JoinColumn(name = "roleId", nullable = false)
    private Role role;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Cart cart;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserAddress> addresses;

    // transient receiver used for DTOs / form binding. Getter will return this if set,
    // otherwise it returns the last address from the persisted addresses list.
    @Transient
    private UserAddress receiver;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Order> orders;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserVoucher> userVouchers;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Shop shop;

    // Convenience getter: return transient receiver if present (e.g. from form binding),
    // otherwise return the last persisted address (most recently added by id order).
    public UserAddress getReceiver() {
        if (this.receiver != null) {
            return this.receiver;
        }
        if (this.addresses == null || this.addresses.isEmpty()) {
            return null;
        }
        return this.addresses.get(this.addresses.size() - 1);
    }

    // allow setting transient receiver (e.g. incoming DTO)
    public void setReceiver(UserAddress receiver) {
        this.receiver = receiver;
    }

    // helper methods to manage bidirectional relation
    public void addAddress(UserAddress addr) {
        if (addr == null) return;
        if (this.addresses == null) this.addresses = new java.util.ArrayList<>();
        addr.setUser(this);
        this.addresses.add(addr);
    }

    public void removeAddress(UserAddress addr) {
        if (addr == null || this.addresses == null) return;
        addr.setUser(null);
        this.addresses.remove(addr);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.getName()));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
