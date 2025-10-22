package com.shop.shop.service.client;

import java.util.List;

import com.shop.shop.domain.User;
import com.shop.shop.dto.MessageDTO;

public interface MessageService {

    List<User> getListUserMessage(User user);

    List<MessageDTO> getChatHistory(Long currentUserId, Long otherUserId);

    List<User> getListShopOwners(User currentUser);

    MessageDTO getLastMessage(Long user1Id, Long user2Id);

    void deleteChatHistory(Long currentUserId, Long otherUserId);
}
