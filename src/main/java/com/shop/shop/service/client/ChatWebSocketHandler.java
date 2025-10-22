package com.shop.shop.service.client;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.shop.domain.Message;
import com.shop.shop.domain.User;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.repository.UserRepository;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private ObjectMapper objectMapper; // Sử dụng ObjectMapper để chuyển đổi JSON an toàn hơn

    // Map lưu danh sách user đang online
    private static final ConcurrentHashMap<String, WebSocketSession> onlineUsers = new ConcurrentHashMap<>();

    public ChatWebSocketHandler(UserRepository userRepository, MessageRepository messageRepository) {
        this.userRepository = userRepository;
        this.messageRepository = messageRepository;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        try {
            String query = session.getUri().getQuery();
            String username = URLDecoder.decode(query.split("=")[1], StandardCharsets.UTF_8);
            onlineUsers.put(username, session);
            System.out.println("New connection: " + session.getUri());
            System.out.println(username + " connected. Total online: " + onlineUsers.size());
        } catch (Exception e) {
            System.err.println("Failed to establish connection: " + e.getMessage());
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {
        JSONObject json = new JSONObject(textMessage.getPayload());
        String senderName = json.getString("sender");
        String receiverName = json.getString("receiver");
        String content = json.getString("content");

        User sender = userRepository.findByEmail(senderName)
                .orElseThrow(() -> new RuntimeException("Sender not found"));
        User receiver = userRepository.findByEmail(receiverName)
                .orElseThrow(() -> new RuntimeException("Receiver not found"));

        // Lưu tin nhắn vào DB
        Message message = new Message(sender, receiver, content, LocalDateTime.now());
        Message savedMessage = messageRepository.save(message);

        // Chuyển đổi Message object thành JSON string bằng ObjectMapper
        String messageJson = objectMapper.writeValueAsString(savedMessage);

        // Gửi cho người nhận nếu online
        WebSocketSession receiverSession = onlineUsers.get(receiverName);
        if (receiverSession != null && receiverSession.isOpen() && !session.getId().equals(receiverSession.getId())) {
            receiverSession.sendMessage(new TextMessage(messageJson));
        }

        // Echo lại cho người gửi
        session.sendMessage(new TextMessage(messageJson));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        // Tìm key (username) dựa trên value (session) và xóa nó khỏi map
        onlineUsers.entrySet().stream()
                .filter(entry -> entry.getValue().equals(session))
                .map(java.util.Map.Entry::getKey)
                .findFirst()
                .ifPresent(username -> {
                    onlineUsers.remove(username);
                    System.out.println(username + " disconnected. Total online: " + onlineUsers.size());
                });
    }
}
