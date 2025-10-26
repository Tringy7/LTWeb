package com.shop.shop.service.admin.impl;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.service.admin.FileUploadService;

@Service
public class FileUploadServiceImpl implements FileUploadService {

    // Configure upload directory - you can change this in application.properties
    @Value("${file.upload.dir:src/main/webapp/resources/admin/images/user}")
    private String uploadDir;

    // Allowed image file extensions
    private final List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp", "webp");

    // Maximum file size (5MB)
    private final long maxFileSize = 5 * 1024 * 1024;

    @Override
    public String uploadProfilePicture(MultipartFile file, Long userId) throws Exception {
        // Validate file
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File không được để trống");
        }

        if (!isValidImageFile(file)) {
            throw new IllegalArgumentException(
                    "File phải là ảnh có định dạng: " + String.join(", ", allowedExtensions));
        }

        if (file.getSize() > maxFileSize) {
            throw new IllegalArgumentException("Kích thước file không được vượt quá 5MB");
        }

        try {
            // Create upload directory if it doesn't exist
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Generate unique filename
            String originalFilename = file.getOriginalFilename();
            String fileExtension = getFileExtension(originalFilename);
            String uniqueFilename = "profile_" + userId + "_" + UUID.randomUUID().toString() + "." + fileExtension;

            // Save file
            Path filePath = uploadPath.resolve(uniqueFilename);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Return relative path for storing in database
            return "/admin/images/user/" + uniqueFilename;

        } catch (IOException e) {
            throw new Exception("Không thể upload file: " + e.getMessage());
        }
    }

    @Override
    public boolean deleteProfilePicture(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return true; // Nothing to delete
        }

        try {
            // Convert relative path to absolute path
            // Handle both old path format (/images/profiles/) and new format
            // (/admin/images/user/)
            String filename;
            if (filePath.startsWith("/admin/images/user/")) {
                filename = filePath.substring("/admin/images/user/".length());
            } else if (filePath.startsWith("/admin/images/users/")) {
                filename = filePath.substring("/admin/images/users/".length());
            } else if (filePath.startsWith("/images/profiles/")) {
                filename = filePath.substring("/images/profiles/".length());
            } else {
                filename = filePath.substring(filePath.lastIndexOf("/") + 1);
            }

            Path fileToDelete = Paths.get(uploadDir, filename);

            if (Files.exists(fileToDelete)) {
                Files.delete(fileToDelete);
                return true;
            }
        } catch (IOException e) {
            // Log error but don't fail the operation
            System.err.println("Could not delete file: " + filePath + " - " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean isValidImageFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return false;
        }

        // Check file extension
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null) {
            return false;
        }

        String extension = getFileExtension(originalFilename).toLowerCase();
        if (!allowedExtensions.contains(extension)) {
            return false;
        }

        // Check content type
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }

    private String getFileExtension(String filename) {
        if (filename == null || filename.lastIndexOf(".") == -1) {
            return "";
        }
        return filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
    }
}
