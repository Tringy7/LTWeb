package com.shop.shop.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.repository.MessageRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.admin.ProductService;
import com.shop.shop.service.client.MessageService;
import com.shop.shop.util.UserAfterLogin;

@Controller
public class ChatController {

    @Autowired
    private UserAfterLogin userAfterLogin;

    @Autowired
    private MessageService messageService;

    @Autowired
    private ProductService productService;

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/chat")
    public String showChat(Model model) {
        model.addAttribute("users", messageService.getListUserMessage(userAfterLogin.getUser()));
        return "client/chat/show";
    }

    // @GetMapping("/shop/product/{id}/{user1}")
    // @ResponseBody
    // public ResponseEntity<?> getConversation(@PathVariable Long id, @PathVariable String user1) {
    //     try {
    //         // Validate user1 exists
    //         Optional<User> user1Opt = userRepository.findByEmail(user1);
    //         if (user1Opt.isEmpty()) {
    //             return ResponseEntity.status(HttpStatus.BAD_REQUEST)
    //                     .body(createErrorResponse("User không tồn tại"));
    //         }
    //         // Validate product exists
    //         Optional<Product> productOpt = productService.getProductById(id);
    //         if (productOpt.isEmpty()) {
    //             return ResponseEntity.status(HttpStatus.NOT_FOUND)
    //                     .body(createErrorResponse("Sản phẩm không tồn tại"));
    //         }
    //         Product product = productOpt.get();
    //         // Validate product has shop and shop has user
    //         if (product.getShop() == null || product.getShop().getUser() == null) {
    //             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
    //                     .body(createErrorResponse("Sản phẩm không có thông tin shop"));
    //         }
    //         String user2 = product.getShop().getUser().getEmail();
    //         // Get conversation
    //         List<Message> messages = messageRepository.findConversation(user1, user2);
    //         // Convert to DTO to avoid circular reference
    //         List<MessageDTO> messageDTOs = messages.stream()
    //                 .map(this::convertToDTO)
    //                 .collect(Collectors.toList());
    //         return ResponseEntity.ok(messageDTOs);
    //     } catch (Exception e) {
    //         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
    //                 .body(createErrorResponse("Lỗi khi tải tin nhắn: " + e.getMessage()));
    //     }
    // }
    // /**
    //  * Get conversation between two users directly This endpoint is used by the
    //  * chat interface
    //  *
    //  * @param user1 First user email
    //  * @param user2 Second user email
    //  * @return ResponseEntity with list of messages or error
    //  */
    // @GetMapping("/api/messages/{user1}/{user2}")
    // @ResponseBody
    // public ResponseEntity<?> getDirectConversation(@PathVariable String user1, @PathVariable String user2) {
    //     try {
    //         // Validate both users exist
    //         Optional<User> user1Opt = userRepository.findByEmail(user1);
    //         Optional<User> user2Opt = userRepository.findByEmail(user2);
    //         if (user1Opt.isEmpty() || user2Opt.isEmpty()) {
    //             return ResponseEntity.status(HttpStatus.BAD_REQUEST)
    //                     .body(createErrorResponse("Một hoặc cả hai user không tồn tại"));
    //         }
    //         // Get conversation
    //         List<Message> messages = messageRepository.findConversation(user1, user2);
    //         // Convert to DTO to avoid circular reference
    //         List<MessageDTO> messageDTOs = messages.stream()
    //                 .map(this::convertToDTO)
    //                 .collect(Collectors.toList());
    //         return ResponseEntity.ok(messageDTOs);
    //     } catch (Exception e) {
    //         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
    //                 .body(createErrorResponse("Lỗi khi tải tin nhắn: " + e.getMessage()));
    //     }
    // }
    // /**
    //  * Convert Message entity to DTO
    //  */
    // private MessageDTO convertToDTO(Message message) {
    //     MessageDTO dto = new MessageDTO();
    //     dto.setId(message.getId());
    //     dto.setContent(message.getContent());
    //     dto.setTimestamp(message.getTimestamp());
    //     // Convert sender
    //     if (message.getSender() != null) {
    //         UserSimpleDTO senderDTO = new UserSimpleDTO(
    //                 message.getSender().getId(),
    //                 message.getSender().getEmail(),
    //                 message.getSender().getFullName(),
    //                 message.getSender().getImage());
    //         dto.setSender(senderDTO);
    //     }
    //     // Convert receiver
    //     if (message.getReceiver() != null) {
    //         UserSimpleDTO receiverDTO = new UserSimpleDTO(
    //                 message.getReceiver().getId(),
    //                 message.getReceiver().getEmail(),
    //                 message.getReceiver().getFullName(),
    //                 message.getReceiver().getImage());
    //         dto.setReceiver(receiverDTO);
    //     }
    //     return dto;
    // }
    // /**
    //  * Create error response
    //  */
    // private Map<String, String> createErrorResponse(String message) {
    //     Map<String, String> error = new HashMap<>();
    //     error.put("error", message);
    //     return error;
    // }
}
