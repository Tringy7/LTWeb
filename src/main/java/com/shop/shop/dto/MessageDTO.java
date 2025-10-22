package com.shop.shop.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * DTO for Message to avoid circular reference in JSON serialization
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MessageDTO {

    private Long id;
    private UserSimpleDTO sender;
    private UserSimpleDTO receiver;
    private String content;
    private LocalDateTime timestamp;

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserSimpleDTO {

        private Long id;
        private String email;
        private String fullName;
        private String avatar;
    }
}
