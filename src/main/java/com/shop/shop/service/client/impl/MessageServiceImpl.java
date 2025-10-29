package com.shop.shop.service.client.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Message;
import com.shop.shop.domain.User;
import com.shop.shop.dto.MessageDTO;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.client.MessageService;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> getListUserMessage(User user) {
        // Lấy danh sách tất cả những người dùng đã nhận tin nhắn từ người dùng hiện tại
        return messageRepository.findDistinctReceiversBySender(user) != null
                ? messageRepository.findDistinctReceiversBySender(user)
                : new ArrayList<>();
    }

    @Override
    public List<MessageDTO> getChatHistory(Long currentUserId, Long otherUserId) {
        User currentUser = userRepository.findById(currentUserId)
                .orElseThrow(() -> new RuntimeException("Current user not found"));
        User otherUser = userRepository.findById(otherUserId)
                .orElseThrow(() -> new RuntimeException("Other user not found"));

        List<Message> messages = messageRepository.findChatHistory(currentUser, otherUser);

        return messages.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<User> getListShopOwners(User currentUser) {
        return messageRepository.findDistinctShopOwnersByUser(currentUser) != null
                ? messageRepository.findDistinctShopOwnersByUser(currentUser)
                : new ArrayList<>();
    }

    @Override
    public List<User> getListUsersWhoMessaged(User currentUser) {
        return messageRepository.findDistinctSendersByReceiver(currentUser) != null
                ? messageRepository.findDistinctSendersByReceiver(currentUser)
                : new ArrayList<>();
    }

    @Override
    public MessageDTO getLastMessage(Long user1Id, Long user2Id) {
        User user1 = userRepository.findById(user1Id)
                .orElseThrow(() -> new RuntimeException("User 1 not found"));
        User user2 = userRepository.findById(user2Id)
                .orElseThrow(() -> new RuntimeException("User 2 not found"));

        Message message = messageRepository.findLastMessageBetweenUsers(user1, user2);

        return message != null ? convertToDTO(message) : null;
    }

    /**
     * Chuyển đổi Message entity sang MessageDTO
     */
    private MessageDTO convertToDTO(Message message) {
        MessageDTO dto = new MessageDTO();
        dto.setId(message.getId());
        dto.setContent(message.getContent());
        dto.setTimestamp(message.getTimestamp());

        // Sender info
        MessageDTO.UserSimpleDTO senderDTO = new MessageDTO.UserSimpleDTO();
        senderDTO.setId(message.getSender().getId());
        senderDTO.setEmail(message.getSender().getEmail());
        senderDTO.setFullName(message.getSender().getFullName());
        senderDTO.setAvatar(message.getSender().getImage());
        dto.setSender(senderDTO);

        // Receiver info
        MessageDTO.UserSimpleDTO receiverDTO = new MessageDTO.UserSimpleDTO();
        receiverDTO.setId(message.getReceiver().getId());
        receiverDTO.setEmail(message.getReceiver().getEmail());
        receiverDTO.setFullName(message.getReceiver().getFullName());
        receiverDTO.setAvatar(message.getReceiver().getImage());
        dto.setReceiver(receiverDTO);

        return dto;
    }

    @Override
    @Transactional
    public void deleteChatHistory(Long currentUserId, Long otherUserId) {
        User currentUser = userRepository.findById(currentUserId)
                .orElseThrow(() -> new RuntimeException("Current user not found"));
        User otherUser = userRepository.findById(otherUserId)
                .orElseThrow(() -> new RuntimeException("Other user not found"));

        messageRepository.deleteChatHistory(currentUser, otherUser);
    }

}
