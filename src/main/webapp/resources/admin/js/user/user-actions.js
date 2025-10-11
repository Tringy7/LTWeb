/**
 * Minimal JavaScript for Pure Spring Boot MVC
 * Only essential confirmations - all logic handled by backend
 */

// Simple delete confirmation - no DOM manipulation, just browser confirmation
function confirmDelete(userName) {
    return confirm('Bạn có chắc chắn muốn xóa người dùng "' + userName + '"? Hành động này không thể hoàn tác.');
}
