package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Message;
import com.shop.shop.domain.User;

public interface MessageRepository extends JpaRepository<Message, Long> {

    // Lấy danh sách tất cả những người dùng đã nhận tin nhắn từ người dùng hiện tại
    @Query("""
    SELECT DISTINCT m.receiver FROM Message m
    WHERE m.sender = :currentUser
    ORDER BY m.receiver.fullName ASC
    """)
    List<User> findDistinctReceiversBySender(@Param("currentUser") User currentUser);

    // Lấy lịch sử chat giữa 2 user (cả tin nhắn gửi và nhận)
    @Query("""
    SELECT m FROM Message m
    WHERE (m.sender = :user1 AND m.receiver = :user2)
       OR (m.sender = :user2 AND m.receiver = :user1)
    ORDER BY m.timestamp ASC
    """)
    List<Message> findChatHistory(@Param("user1") User user1, @Param("user2") User user2);

    // Lấy danh sách shops mà user đã chat (thông qua shop owner)
    @Query("""
    SELECT DISTINCT s.user FROM Message m
    JOIN Shop s ON (m.receiver = s.user OR m.sender = s.user)
    WHERE (m.sender = :currentUser OR m.receiver = :currentUser)
      AND s.user != :currentUser
    ORDER BY s.user.fullName ASC
    """)
    List<User> findDistinctShopOwnersByUser(@Param("currentUser") User currentUser);

    // Lấy tin nhắn cuối cùng giữa 2 user
    @Query(value = """
    SELECT * FROM messages m
    WHERE (m.sender_id = :#{#user1.id} AND m.receiver_id = :#{#user2.id})
       OR (m.sender_id = :#{#user2.id} AND m.receiver_id = :#{#user1.id})
    ORDER BY m.timestamp DESC
    LIMIT 1
    """, nativeQuery = true)
    Message findLastMessageBetweenUsers(@Param("user1") User user1, @Param("user2") User user2);

    // Xóa tất cả tin nhắn giữa 2 user
    @Modifying
    @Transactional
    @Query("""
    DELETE FROM Message m
    WHERE (m.sender = :user1 AND m.receiver = :user2)
       OR (m.sender = :user2 AND m.receiver = :user1)
    """)
    void deleteChatHistory(@Param("user1") User user1, @Param("user2") User user2);
}
