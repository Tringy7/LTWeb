package com.shop.shop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.shop.shop.domain.Role;
import com.shop.shop.domain.User;
import com.shop.shop.dto.UserSearchDTO;
import com.shop.shop.service.admin.RoleService;
import com.shop.shop.service.admin.UserService;

@Controller
public class AdminUserController {

    private final UserService userService;

    private final RoleService roleService;

    public AdminUserController(UserService usService, RoleService roleService) {
        this.userService = usService;
        this.roleService = roleService;
    }

    @GetMapping("/admin/user")
    public String show(Model model) {
        // Get all users initially
        List<User> users = userService.getAllUsers();

        // Get all roles for dropdown
        List<Role> roles = roleService.getAllRoles();

        // Create empty search form
        UserSearchDTO searchDTO = new UserSearchDTO();

        model.addAttribute("users", users);
        model.addAttribute("roles", roles);
        model.addAttribute("searchForm", searchDTO);
        model.addAttribute("totalUsers", users.size());

        return "admin/user/show";
    }

    @PostMapping("/admin/user/search")
    public String searchUsers(@ModelAttribute("searchForm") UserSearchDTO searchDTO, Model model) {
        List<User> users;

        String keyword = searchDTO.getKeyword();
        Long roleId = searchDTO.getRoleId();

        // Check if both keyword and role are provided
        if ((keyword != null && !keyword.trim().isEmpty()) && roleId != null) {
            // Search by both keyword and role
            users = userService.searchUsersByKeywordAndRole(keyword, roleId);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            // Search by keyword only
            users = userService.searchUsers(keyword);
        } else if (roleId != null) {
            // Search by role only
            users = userService.getUsersByRole(roleId);
        } else {
            // No search criteria, show all users
            users = userService.getAllUsers();
        }

        // Get all roles for dropdown
        List<Role> roles = roleService.getAllRoles();

        model.addAttribute("users", users);
        model.addAttribute("roles", roles);
        model.addAttribute("searchForm", searchDTO);
        model.addAttribute("totalUsers", users.size());
        model.addAttribute("searchPerformed", true);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/clear")
    public String clearSearch() {
        return "redirect:/admin/user";
    }
}
