package com.shop.shop.service.admin;

import org.springframework.web.multipart.MultipartFile;

/**
 * Service interface for handling file upload operations
 */
public interface FileUploadService {

    /**
     * Upload a profile picture and return the file path
     * 
     * @param file   The uploaded file
     * @param userId The user ID (for naming the file)
     * @return The relative path to the uploaded file
     * @throws Exception if upload fails
     */
    String uploadProfilePicture(MultipartFile file, Long userId) throws Exception;

    /**
     * Delete a profile picture file
     * 
     * @param filePath The path to the file to delete
     * @return true if deletion was successful
     */
    boolean deleteProfilePicture(String filePath);

    /**
     * Check if the uploaded file is a valid image
     * 
     * @param file The file to validate
     * @return true if the file is a valid image
     */
    boolean isValidImageFile(MultipartFile file);
}
