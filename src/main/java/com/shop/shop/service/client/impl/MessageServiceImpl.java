package com.shop.shop.service.client.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.User;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.service.client.MessageService;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageRepository messageRepository;

    @Override
    public List<User> getListUserMessage(User user) {
        // Lấy danh sách tất cả những người dùng đã nhận tin nhắn từ người dùng hiện tại
        return messageRepository.findDistinctReceiversBySender(user) != null ? messageRepository.findDistinctReceiversBySender(user) : new ArrayList<>();
    }

}
