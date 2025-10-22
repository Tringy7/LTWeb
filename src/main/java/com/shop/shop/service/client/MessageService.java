package com.shop.shop.service.client;

import java.util.List;

import com.shop.shop.domain.User;

public interface MessageService {
    List<User> getListUserMessage(User user); 
}
