package com.shop.shop.util;

import java.text.Normalizer;
import java.util.Locale;

/**
 * Small helper utilities for normalizing province names (remove diacritics,
 * lower-case, collapse spaces). Useful for mapping user input to canonical
 * province keys like "binh dinh".
 */
public final class ProvinceUtils {

    private ProvinceUtils() {
    }

    /**
     * Normalize a province string: trim, lower-case, remove diacritics, replace
     * non-alphanum with spaces and collapse multiple spaces. Example: "Bình
     * Định" -> "binh dinh"
     */
    public static String normalizeProvince(String input) {
        try {
            if (input == null || input.isBlank()) {
                return "";
            }

            // Bước 1: Chuẩn hóa chữ thường, cắt khoảng trắng
            String s = input.trim().toLowerCase(Locale.ROOT);

            // Bước 2: Thay thế các ký tự đặc biệt tiếng Việt đặc biệt (đ, Đ)
            s = s.replace('đ', 'd').replace('Đ', 'd');

            // Bước 3: Chuẩn hóa Unicode (tách dấu ra khỏi ký tự)
            s = Normalizer.normalize(s, Normalizer.Form.NFD);

            // Bước 4: Xóa các dấu thanh và ký tự kết hợp
            s = s.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");

            // Bước 5: Xóa ký tự không phải chữ, số hoặc khoảng trắng
            s = s.replaceAll("[^a-z0-9\\s]", " ");

            // Bước 6: Gom nhiều khoảng trắng về 1 và cắt đầu/cuối
            s = s.replaceAll("\\s+", " ").trim();

            return s;
        } catch (Exception e) {
            // Bắt mọi ngoại lệ không mong muốn để không crash chương trình
            System.err.println("Lỗi khi normalize: " + e.getMessage());
            return "";
        }
    }

}
