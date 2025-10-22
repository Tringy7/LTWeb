package com.shop.shop.controller.websocket;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.shop.shop.domain.Message;
import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.dto.MessageDTO;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.repository.UserRepository;

@Controller
public class WebSocketChatController {

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    /**
     * USER gửi tin nhắn đến SHOP OWNER Đường dẫn: /app/chat/send/{shopId}
     */
    @MessageMapping("/chat/send/{shopId}")
    public void sendMessageToShop(
            @DestinationVariable Long shopId,
            @Payload MessageDTO messageDTO) {

        try {
            // Tìm sender (user hiện tại)
            User sender = userRepository.findById(messageDTO.getSender().getId())
                    .orElseThrow(() -> new RuntimeException("Sender not found"));

            // Tìm shop và lấy owner (receiver)
            Shop shop = shopRepository.findById(shopId)
                    .orElseThrow(() -> new RuntimeException("Shop not found with id: " + shopId));

            User receiver = shop.getUser(); // Owner của shop

            // Tạo message mới
            Message message = new Message();
            message.setSender(sender);
            message.setReceiver(receiver);
            message.setContent(messageDTO.getContent());
            message.setTimestamp(LocalDateTime.now());

            // Lưu vào database
            Message savedMessage = messageRepository.save(message);

            // Chuyển đổi sang DTO để gửi
            MessageDTO responseDTO = convertToDTO(savedMessage);

            // Gửi cho USER (người gửi)
            messagingTemplate.convertAndSend(
                    "/queue/messages/" + sender.getId(),
                    responseDTO);

            // Gửi cho SHOP OWNER (người nhận)
            messagingTemplate.convertAndSend(
                    "/queue/messages/" + receiver.getId(),
                    responseDTO);

        } catch (Exception e) {
            e.printStackTrace();
            // Có thể gửi message lỗi về client
            messagingTemplate.convertAndSend(
                    "/queue/errors/" + messageDTO.getSender().getId(),
                    "Error sending message: " + e.getMessage());
        }
    }

    /**
     * SHOP OWNER gửi tin nhắn đến USER Đường dẫn:
     * /app/vendor/chat/send/{userId}
     */
    @MessageMapping("/vendor/chat/send/{userId}")
    public void sendMessageToUser(
            @DestinationVariable Long userId,
            @Payload MessageDTO messageDTO) {

        try {
            // Tìm sender (shop owner)
            User sender = userRepository.findById(messageDTO.getSender().getId())
                    .orElseThrow(() -> new RuntimeException("Sender not found"));

            // Tìm receiver (user)
            User receiver = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("Receiver not found with id: " + userId));

            // Tạo message mới
            Message message = new Message();
            message.setSender(sender);
            message.setReceiver(receiver);
            message.setContent(messageDTO.getContent());
            message.setTimestamp(LocalDateTime.now());

            // Lưu vào database
            Message savedMessage = messageRepository.save(message);

            // Chuyển đổi sang DTO để gửi
            MessageDTO responseDTO = convertToDTO(savedMessage);

            // Gửi cho SHOP OWNER (người gửi)
            messagingTemplate.convertAndSend(
                    "/queue/messages/" + sender.getId(),
                    responseDTO);

            // Gửi cho USER (người nhận)
            messagingTemplate.convertAndSend(
                    "/queue/messages/" + receiver.getId(),
                    responseDTO);

        } catch (Exception e) {
            e.printStackTrace();
            messagingTemplate.convertAndSend(
                    "/queue/errors/" + messageDTO.getSender().getId(),
                    "Error sending message: " + e.getMessage());
        }
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
}
