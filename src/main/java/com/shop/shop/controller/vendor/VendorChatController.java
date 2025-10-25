package com.shop.shop.controller.vendor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.domain.User;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.service.client.MessageService;
import com.shop.shop.util.UserAfterLogin;

@Controller
public class VendorChatController {

    @Autowired
    private UserAfterLogin userAfterLogin;

    @Autowired
    private MessageService messageService;

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("/vendor/chat")
    public String showChat(Model model) {
        User currentUser = userAfterLogin.getUser();

        List<User> shopOwners = messageService.getListShopOwners(currentUser);

        model.addAttribute("users", shopOwners);
        model.addAttribute("currentUser", currentUser);

        return "vendor/chat/show";
    }

}
