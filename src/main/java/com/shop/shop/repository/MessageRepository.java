package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.shop.shop.domain.Message;
import com.shop.shop.domain.User;

public interface MessageRepository extends JpaRepository<Message, Long> {

    @Query("""
    SELECT m FROM Message m
    WHERE (m.sender.email = :user1 AND m.receiver.email = :user2)
       OR (m.sender.email = :user2 AND m.receiver.email = :user1)
    ORDER BY m.timestamp ASC
    """)
    List<Message> findConversationByEmails(@Param("user1") String user1, @Param("user2") String user2);

    @Query("""
    SELECT m FROM Message m
    WHERE (m.sender.id = :user1Id AND m.receiver.id = :user2Id)
       OR (m.sender.id = :user2Id AND m.receiver.id = :user1Id)
    ORDER BY m.timestamp ASC
    """)
    List<Message> findConversationByIds(@Param("user1Id") Long user1Id, @Param("user2Id") Long user2Id);

    // Lấy danh sách tất cả những người dùng đã nhận tin nhắn từ người dùng hiện tại
    @Query("""
    SELECT DISTINCT m.receiver FROM Message m
    WHERE m.sender = :currentUser
    ORDER BY m.receiver.fullName ASC
    """)
    List<User> findDistinctReceiversBySender(@Param("currentUser") User currentUser);

    // Lấy danh sách tất cả những người dùng đã tương tác (gửi hoặc nhận) với người dùng hiện tại
    @Query("""
    SELECT DISTINCT CASE 
        WHEN m.sender = :currentUser THEN m.receiver
        ELSE m.sender
    END
    FROM Message m
    WHERE m.sender = :currentUser OR m.receiver = :currentUser
    ORDER BY CASE 
        WHEN m.sender = :currentUser THEN m.receiver.fullName
        ELSE m.sender.fullName
    END ASC
    """)
    List<User> findDistinctConversationPartners(@Param("currentUser") User currentUser);
}
