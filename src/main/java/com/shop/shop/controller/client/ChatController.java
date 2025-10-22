package com.shop.shop.controller.client;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Message;
import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.dto.MessageDTO;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.service.client.MessageService;
import com.shop.shop.util.UserAfterLogin;

@Controller
public class ChatController {

    @Autowired
    private UserAfterLogin userAfterLogin;

    @Autowired
    private MessageService messageService;

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("/chat")
    public String showChat(Model model) {
        User currentUser = userAfterLogin.getUser();

        // Lấy danh sách shop owners mà user đã chat
        List<User> shopOwners = messageService.getListShopOwners(currentUser);

        model.addAttribute("users", shopOwners);
        model.addAttribute("currentUser", currentUser);

        return "client/chat/show";
    }

    /**
     * Khởi tạo chat với shop (tạo message đầu tiên nếu chưa có)
     */
    @GetMapping("/chat/start/{shopId}")
    public String startChatWithShop(
            @PathVariable Long shopId,
            RedirectAttributes redirectAttributes) {
        try {
            User currentUser = userAfterLogin.getUser();

            // Tìm shop
            Shop shop = shopRepository.findById(shopId)
                    .orElseThrow(() -> new RuntimeException("Shop not found"));

            User shopOwner = shop.getUser();

            // Kiểm tra đã có tin nhắn giữa 2 người chưa
            List<Message> existingMessages = messageRepository.findChatHistory(currentUser, shopOwner);

            // Nếu chưa có tin nhắn nào, tạo tin nhắn mặc định
            if (existingMessages.isEmpty()) {
                Message initialMessage = new Message();
                initialMessage.setSender(currentUser);
                initialMessage.setReceiver(shopOwner);
                initialMessage.setContent("Xin chào! Tôi quan tâm đến sản phẩm của shop.");
                initialMessage.setTimestamp(LocalDateTime.now());

                messageRepository.save(initialMessage);
            }

            // Redirect đến trang chat với shopId trong URL parameter
            redirectAttributes.addAttribute("shopId", shopId);
            return "redirect:/chat";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Không thể khởi tạo chat");
            return "redirect:/shop";
        }
    }

    /**
     * API để lấy lịch sử chat giữa current user và shop owner
     */
    @GetMapping("/api/chat/history/{shopId}")
    @ResponseBody
    public ResponseEntity<List<MessageDTO>> getChatHistory(@PathVariable Long shopId) {
        try {
            User currentUser = userAfterLogin.getUser();

            // Tìm shop và lấy owner
            var shop = shopRepository.findById(shopId)
                    .orElseThrow(() -> new RuntimeException("Shop not found"));

            User shopOwner = shop.getUser();

            // Lấy lịch sử chat
            List<MessageDTO> messages = messageService.getChatHistory(
                    currentUser.getId(),
                    shopOwner.getId()
            );

            return ResponseEntity.ok(messages);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * API để lấy lịch sử chat giữa current user và user khác (theo userId)
     */
    @GetMapping("/api/chat/history/user/{userId}")
    @ResponseBody
    public ResponseEntity<List<MessageDTO>> getChatHistoryByUserId(@PathVariable Long userId) {
        try {
            User currentUser = userAfterLogin.getUser();

            List<MessageDTO> messages = messageService.getChatHistory(
                    currentUser.getId(),
                    userId
            );

            return ResponseEntity.ok(messages);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * API để xóa lịch sử chat với một shop owner
     */
    @DeleteMapping("/api/chat/delete/shop/{shopId}")
    @ResponseBody
    public ResponseEntity<String> deleteChatWithShop(@PathVariable Long shopId) {
        try {
            User currentUser = userAfterLogin.getUser();

            // Tìm shop và lấy owner
            var shop = shopRepository.findById(shopId)
                    .orElseThrow(() -> new RuntimeException("Shop not found"));

            User shopOwner = shop.getUser();

            // Xóa lịch sử chat
            messageService.deleteChatHistory(currentUser.getId(), shopOwner.getId());

            return ResponseEntity.ok("Đã xóa lịch sử chat");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }

    /**
     * API để xóa lịch sử chat với một user (theo userId)
     */
    @DeleteMapping("/api/chat/delete/user/{userId}")
    @ResponseBody
    public ResponseEntity<String> deleteChatWithUser(@PathVariable Long userId) {
        try {
            User currentUser = userAfterLogin.getUser();

            // Xóa lịch sử chat
            messageService.deleteChatHistory(currentUser.getId(), userId);

            return ResponseEntity.ok("Đã xóa lịch sử chat");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }

}
