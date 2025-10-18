package com.shop.shop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserSearchDTO {

    private String keyword;
    private Long roleId;

    // public UserSearchDTO(String keyword) {
    // this.keyword = keyword;
    // }
}
