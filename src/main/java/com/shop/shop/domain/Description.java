package com.shop.shop.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users_desc")
@Getter
@Setter
@NoArgsConstructor
public class Description {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "MEDIUMTEXT")
    private String description;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;
}
