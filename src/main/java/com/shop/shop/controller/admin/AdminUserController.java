package com.shop.shop.controller.admin;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Role;
import com.shop.shop.domain.User;
import com.shop.shop.dto.UserResponseDTO;
import com.shop.shop.dto.UserSearchDTO;
import com.shop.shop.dto.UserUpdateDTO;
import com.shop.shop.mapper.UserMapper;
import com.shop.shop.service.admin.RoleService;
import com.shop.shop.service.admin.UserService;
import com.shop.shop.service.admin.FileUploadService;

import jakarta.validation.Valid;

@Controller
public class AdminUserController {

    private final UserService userService;
    private final RoleService roleService;
    private final UserMapper userMapper;
    private final FileUploadService fileUploadService;

    public AdminUserController(UserService userService, RoleService roleService, UserMapper userMapper,
            FileUploadService fileUploadService) {
        this.userService = userService;
        this.roleService = roleService;
        this.userMapper = userMapper;
        this.fileUploadService = fileUploadService;
    }

    /**
     * Get current admin user ID
     * TODO: Replace this with proper authentication/session management
     * For now, this assumes admin user ID = 1
     */
    private Long getCurrentAdminId() {
        // TODO: Replace with proper authentication logic
        // This could be from HttpSession, Spring Security, or your custom auth
        // mechanism
        return 1L; // CHANGE THIS: Replace with actual logic to get current admin ID
    }

    /**
     * Display users list with search functionality
     * Converts domain entities to DTOs for view layer
     */
    @GetMapping("/admin/user")
    public String show(@RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "roleId", required = false) Long roleId,
            Model model) {

        Long currentAdminId = getCurrentAdminId();

        // Get users from service layer (domain entities)
        List<User> users;
        if ((keyword != null && !keyword.trim().isEmpty()) && roleId != null) {
            users = userService.searchUsersByKeywordAndRole(keyword, roleId);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            users = userService.searchUsers(keyword);
        } else if (roleId != null) {
            users = userService.getUsersByRole(roleId);
        } else {
            users = userService.getAllUsers();
        }

        // Convert domain entities to DTOs for view layer (no sensitive data)
        List<UserResponseDTO> userDTOs = users.stream()
                .map(userMapper::toResponseDTO)
                .collect(Collectors.toList());

        // Get all roles for dropdown
        List<Role> roles = roleService.getAllRoles();

        // Create search form with current values
        UserSearchDTO searchDTO = new UserSearchDTO();
        searchDTO.setKeyword(keyword);
        searchDTO.setRoleId(roleId);

        // Add attributes to model for view layer
        model.addAttribute("users", userDTOs); // Using DTOs instead of entities
        model.addAttribute("roles", roles);
        model.addAttribute("searchForm", searchDTO);
        model.addAttribute("totalUsers", userDTOs.size());
        model.addAttribute("searchPerformed", keyword != null || roleId != null);
        model.addAttribute("currentAdminId", currentAdminId); // Add current admin ID for UI logic

        return "admin/user/show";
    }

    @GetMapping("/admin/user/clear")
    public String clearSearch() {
        return "redirect:/admin/user";
    }

    // View user details
    @GetMapping("/admin/user/detail/{id}")
    public String viewUser(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOptional = userService.getUserById(id);

        if (userOptional.isPresent()) {
            Long currentAdminId = getCurrentAdminId();

            model.addAttribute("user", userOptional.get());
            model.addAttribute("currentAdminId", currentAdminId); // Add for UI logic
            return "admin/user/detail";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + id);
            return "redirect:/admin/user";
        }
    }

    // Show edit user form - using DTO
    @GetMapping("/admin/user/edit/{id}")
    public String editUserForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOptional = userService.getUserById(id);

        if (userOptional.isPresent()) {
            User targetUser = userOptional.get();
            Long currentAdminId = getCurrentAdminId();

            // Check if admin is trying to edit their own account or if they're editing
            // other users
            if (!targetUser.getId().equals(currentAdminId)) {
                // Admin can only edit their own account, not other users
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Bạn chỉ có thể chỉnh sửa tài khoản của chính mình. Đối với người dùng khác, bạn chỉ có quyền xem và xóa.");
                return "redirect:/admin/user/detail/" + id;
            }

            List<Role> roles = roleService.getAllRoles();
            UserUpdateDTO userUpdateDTO = userMapper.toUpdateDTO(targetUser);
            model.addAttribute("userUpdateDTO", userUpdateDTO);
            model.addAttribute("roles", roles);
            return "admin/user/edit";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + id);
            return "redirect:/admin/user";
        }
    }

    // Update user - with backend validation using DTO
    @PostMapping("/admin/user/edit/{id}")
    public String updateUser(@PathVariable Long id,
            @Valid @ModelAttribute("userUpdateDTO") UserUpdateDTO userUpdateDTO,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        userUpdateDTO.setId(id); // Ensure the ID is set

        Long currentAdminId = getCurrentAdminId();

        // Check if admin is trying to edit their own account
        if (!id.equals(currentAdminId)) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Bạn chỉ có thể chỉnh sửa tài khoản của chính mình. Đối với người dùng khác, bạn chỉ có quyền xem và xóa.");
            return "redirect:/admin/user/detail/" + id;
        }

        // Backend validation - check if email exists for other users
        Optional<User> existingUserByEmail = userService.getUserByEmail(userUpdateDTO.getEmail());
        if (existingUserByEmail.isPresent() && !existingUserByEmail.get().getId().equals(id)) {
            bindingResult.rejectValue("email", "error.user", "Email đã được sử dụng bởi người dùng khác!");
        }

        // Validate role exists
        Optional<Role> roleOptional = roleService.getRoleById(userUpdateDTO.getRoleId());
        if (roleOptional.isEmpty()) {
            bindingResult.rejectValue("roleId", "error.user", "Vai trò không hợp lệ!");
        }

        // If validation errors, return to form with errors
        if (bindingResult.hasErrors()) {
            List<Role> roles = roleService.getAllRoles();
            model.addAttribute("roles", roles);
            model.addAttribute("userUpdateDTO", userUpdateDTO);
            return "admin/user/edit";
        }

        try {
            // Get existing user
            Optional<User> existingUserOptional = userService.getUserById(id);
            if (existingUserOptional.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Không tìm thấy người dùng cần cập nhật!");
                return "redirect:/admin/user";
            }

            User existingUser = existingUserOptional.get();

            // Handle profile picture upload
            if (userUpdateDTO.getImageFile() != null && !userUpdateDTO.getImageFile().isEmpty()) {
                try {
                    // Delete old profile picture if exists
                    if (existingUser.getImage() != null && !existingUser.getImage().isEmpty()) {
                        fileUploadService.deleteProfilePicture(existingUser.getImage());
                    }

                    // Upload new profile picture
                    String newImagePath = fileUploadService.uploadProfilePicture(userUpdateDTO.getImageFile(), id);
                    userUpdateDTO.setImage(newImagePath);
                } catch (Exception e) {
                    bindingResult.rejectValue("imageFile", "error.user", "Lỗi upload ảnh: " + e.getMessage());
                    List<Role> roles = roleService.getAllRoles();
                    model.addAttribute("roles", roles);
                    model.addAttribute("userUpdateDTO", userUpdateDTO);
                    return "admin/user/edit";
                }
            } else {
                // Keep existing image if no new file uploaded
                userUpdateDTO.setImage(existingUser.getImage());
            }

            // Update entity with DTO data
            userMapper.updateEntityFromDTO(existingUser, userUpdateDTO, roleOptional.get());
            userService.saveUser(existingUser);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Cập nhật người dùng '" + userUpdateDTO.getFullName() + "' thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi xảy ra khi cập nhật người dùng: " + e.getMessage());
            return "redirect:/admin/user/edit/" + id;
        }
        return "redirect:/admin/user";
    }

    // Delete user
    @PostMapping("/admin/user/delete/{id}")
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Optional<User> userOptional = userService.getUserById(id);
            if (userOptional.isPresent()) {
                User user = userOptional.get();

                // Check if this is the last admin user
                if (user.getRole() != null && "ROLE_ADMIN".equals(user.getRole().getName())) {
                    long adminCount = userService.countUsersByRole("ROLE_ADMIN");
                    if (adminCount <= 1) {
                        redirectAttributes.addFlashAttribute("errorMessage",
                                "Không thể xóa admin cuối cùng trong hệ thống!");
                        return "redirect:/admin/user";
                    }
                }

                userService.deleteUser(id);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Xóa người dùng '" + user.getFullName() + "' thành công!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + id);
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa người dùng: " + e.getMessage());
        }
        return "redirect:/admin/user";
    }

}
