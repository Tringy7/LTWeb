package com.shop.shop.service.admin;

import org.springframework.web.multipart.MultipartFile;

// Service interface for handling file upload operations

public interface FileUploadService {

    // Upload a profile picture and return the file path
    String uploadProfilePicture(MultipartFile file, Long userId) throws Exception;

    // Delete a profile picture file

    boolean deleteProfilePicture(String filePath);

    // Check if the uploaded file is a valid image
    boolean isValidImageFile(MultipartFile file);
}
