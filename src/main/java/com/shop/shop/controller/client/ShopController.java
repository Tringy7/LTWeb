package com.shop.shop.controller.client;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.domain.Review;
import com.shop.shop.domain.User;
import com.shop.shop.dto.ProductDTO;
import com.shop.shop.repository.MessageRepository;
import com.shop.shop.service.client.CartService;
import com.shop.shop.service.client.ProductService;
import com.shop.shop.service.client.ReviewService;
import com.shop.shop.util.UserAfterLogin;

@Controller
public class ShopController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private com.shop.shop.service.client.FavoriteService favoriteService;

    @Autowired
    private UserAfterLogin userAfterLogin;

    @Autowired
    private CartService cartService;

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("/shop")
    public String show(Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "default") String sort) {
        int pageSize = 9;
        Pageable pageable;
        Page<Product> productPage;

        // Xử lý sắp xếp
        if ("favorite".equals(sort)) {
            // Lấy user hiện tại
            User currentUser = userAfterLogin.getUser();
            if (currentUser == null) {
                // Nếu chưa đăng nhập, chuyển về sort default
                pageable = PageRequest.of(page, pageSize);
                productPage = productService.getProductPage(pageable);
            } else {
                // Lấy tất cả sản phẩm và sắp xếp theo favorite
                pageable = PageRequest.of(0, Integer.MAX_VALUE); // Lấy tất cả
                Page<Product> allProducts = productService.getProductPage(pageable);

                // Tạo map favorite và lọc chỉ những sản phẩm favorite
                java.util.Map<Long, Boolean> favoriteMapTemp = new java.util.HashMap<>();
                java.util.List<Product> favoriteProducts = new java.util.ArrayList<>();

                for (Product product : allProducts.getContent()) {
                    boolean isFav = favoriteService.isFavorite(currentUser, product);
                    if (isFav) {
                        favoriteProducts.add(product);
                        favoriteMapTemp.put(product.getId(), true);
                    }
                }

                // Sử dụng danh sách sản phẩm favorite
                java.util.List<Product> sortedProducts = favoriteProducts;

                // Phân trang thủ công
                int start = page * pageSize;
                int end = Math.min(start + pageSize, sortedProducts.size());
                java.util.List<Product> pagedProducts = start < sortedProducts.size()
                        ? sortedProducts.subList(start, end)
                        : new java.util.ArrayList<>();

                int totalPages = (int) Math.ceil((double) sortedProducts.size() / pageSize);

                // Kiểm tra trạng thái favorite
                java.util.Map<Long, Boolean> favoriteMap = new java.util.HashMap<>();
                for (Product product : pagedProducts) {
                    favoriteMap.put(product.getId(), favoriteMapTemp.getOrDefault(product.getId(), false));
                }

                model.addAttribute("productList", pagedProducts);
                model.addAttribute("currentPage", page);
                model.addAttribute("totalPages", totalPages);
                model.addAttribute("sort", sort);
                model.addAttribute("filterList", productService.getBraList());
                model.addAttribute("favoriteMap", favoriteMap);

                return "client/shop/show";
            }
        } else if ("asc".equals(sort)) {
            pageable = PageRequest.of(page, pageSize, Sort.by("price").ascending());
            productPage = productService.getProductPage(pageable);
        } else if ("desc".equals(sort)) {
            pageable = PageRequest.of(page, pageSize, Sort.by("price").descending());
            productPage = productService.getProductPage(pageable);
        } else {
            pageable = PageRequest.of(page, pageSize);
            productPage = productService.getProductPage(pageable);
        }

        // Kiểm tra trạng thái favorite cho từng sản phẩm
        User currentUser = userAfterLogin.getUser();
        java.util.Map<Long, Boolean> favoriteMap = new java.util.HashMap<>();
        if (currentUser != null) {
            for (Product product : productPage.getContent()) {
                favoriteMap.put(product.getId(), favoriteService.isFavorite(currentUser, product));
            }
        }

        model.addAttribute("productList", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("sort", sort);
        model.addAttribute("filterList", productService.getBraList());
        model.addAttribute("favoriteMap", favoriteMap);

        return "client/shop/show";
    }

    @GetMapping("/shop/product/{id}")
    public String showDetail(@PathVariable("id") Long id, Model model) {
        Product product = productService.getProductById(id);
        double averageRating = 0.0;
        if (product.getReviews() != null && !product.getReviews().isEmpty()) {
            averageRating = product.getReviews().stream()
                    .mapToInt(r -> r.getRating() != null ? r.getRating() : 0)
                    .average()
                    .orElse(0.0);
        }
        long roundedRating = Math.round(averageRating); // Làm tròn

        List<ProductDetail> productDetails = product.getProductDetails();
        int sum = 0;
        int quantity = 0;
        List<String> sizes = new ArrayList<>();
        for (ProductDetail pd : productDetails) {
            sum += pd.getSold();
            quantity += pd.getQuantity();
            sizes.add(pd.getSize());
        }
        User user = userAfterLogin.getUser();
        Review review = new Review();
        review.setProduct(product);
        review.setUser(user);
        review.setMessage("");

        model.addAttribute("review", review);
        model.addAttribute("shop", product.getShop());
        model.addAttribute("averageRating", roundedRating);
        model.addAttribute("product", product);
        model.addAttribute("sizes", sizes);
        model.addAttribute("quantity", quantity);
        model.addAttribute("sumSold", sum);
        model.addAttribute("productDetail", product.getProductDetails());
        model.addAttribute("reviews", product.getReviews());
        return "client/shop/detail";
    }

    @PostMapping("/shop/product/{id}")
    public String postMethodName(@PathVariable("id") Long id, @ModelAttribute ProductDTO productDTO,
            RedirectAttributes redirectAttributes) {
        try {
            User user = userAfterLogin.getUser();
            Cart cart = cartService.getCart(user);
            cartService.handleCart(productDTO, cart);
            redirectAttributes.addFlashAttribute("cartStatus", "success");
            redirectAttributes.addFlashAttribute("cartMessage", "Đã thêm sản phẩm vào giỏ hàng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("cartStatus", "failure");
            redirectAttributes.addFlashAttribute("cartMessage", "Thêm sản phẩm thất bại. Vui lòng thử lại.");
        }
        return "redirect:/shop/product/{id}";
    }

    @GetMapping("/shop/search")
    public String searchProductByName(@RequestParam(value = "name", required = false) String name, Model model) {
        List<Product> products;

        if (name != null && !name.trim().isEmpty()) {
            products = productService.searchProductsByName(name);
            model.addAttribute("searchName", name);
        } else {
            products = productService.getAllProduct();
            model.addAttribute("searchName", "");
        }

        // Kiểm tra trạng thái favorite
        User currentUser = userAfterLogin.getUser();
        java.util.Map<Long, Boolean> favoriteMap = new java.util.HashMap<>();
        if (currentUser != null) {
            for (Product product : products) {
                favoriteMap.put(product.getId(), favoriteService.isFavorite(currentUser, product));
            }
        }

        model.addAttribute("productList", products);
        model.addAttribute("filterList", productService.getBraList()); // Thêm dòng này
        model.addAttribute("favoriteMap", favoriteMap);
        return "client/shop/show";
    }

    @GetMapping("/shop/filter")
    public String filterProducts(
            @RequestParam(value = "maxPrice", required = false) Double maxPrice,
            @RequestParam(value = "brand", required = false) List<String> selectedBrands,
            @RequestParam(value = "size", required = false) List<String> selectedSizes,
            @RequestParam(value = "color", required = false) List<String> selectedColors,
            @RequestParam(value = "gender", required = false) List<String> selectedGenders,
            Model model) {

        List<Product> filteredProducts = productService.filterProducts(maxPrice, selectedBrands, selectedSizes, selectedColors, selectedGenders);

        // Kiểm tra trạng thái favorite
        User currentUser = userAfterLogin.getUser();
        java.util.Map<Long, Boolean> favoriteMap = new java.util.HashMap<>();
        if (currentUser != null) {
            for (Product product : filteredProducts) {
                favoriteMap.put(product.getId(), favoriteService.isFavorite(currentUser, product));
            }
        }

        model.addAttribute("productList", filteredProducts);
        model.addAttribute("filterList", productService.getBraList());
        model.addAttribute("selectedBrands", selectedBrands);
        model.addAttribute("selectedSizes", selectedSizes);
        model.addAttribute("selectedColors", selectedColors);
        model.addAttribute("selectedGenders", selectedGenders);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("favoriteMap", favoriteMap);

        return "client/shop/show";
    }

    @PostMapping("/shop/product/{id}/review")
    public String handleReviewProduct(@PathVariable("id") Long id,
            @ModelAttribute("review") Review review,
            @RequestParam(value = "media", required = false) MultipartFile media,
            RedirectAttributes redirectAttributes) {

        if (review.getMessage() != null && review.getMessage().length() > 50) {
            redirectAttributes.addFlashAttribute("reviewError", "Nội dung bình luận phải tối đa 50 kí tự.");
            return "redirect:/shop/product/{id}";
        }

        // Attach product and user explicitly to ensure correct associations
        Product product = productService.getProductById(id);
        User user = userAfterLogin.getUser();
        review.setProduct(product);
        review.setUser(user);
        review.setId(null);

        // Handle media upload if present
        if (media != null && !media.isEmpty()) {
            String contentType = media.getContentType() == null ? "" : media.getContentType();
            long size = media.getSize();

            // Validate type
            if (!(contentType.startsWith("image/") || contentType.startsWith("video/"))) {
                redirectAttributes.addFlashAttribute("reviewMediaError", "Chỉ chấp nhận ảnh hoặc video.");
                return "redirect:/shop/product/{id}";
            }

            // Validate size
            if (contentType.startsWith("image/") && size > 5L * 1024 * 1024) {
                redirectAttributes.addFlashAttribute("reviewMediaError", "Ảnh quá lớn. Tối đa 5MB.");
                return "redirect:/shop/product/{id}";
            }
            if (contentType.startsWith("video/") && size > 20L * 1024 * 1024) {
                redirectAttributes.addFlashAttribute("reviewMediaError", "Video quá lớn. Tối đa 20MB.");
                return "redirect:/shop/product/{id}";
            }

            // Save file to web resources so it can be served statically
            try {
                String original = media.getOriginalFilename() == null ? "file" : media.getOriginalFilename();
                String ext = "";
                int idx = original.lastIndexOf('.');
                if (idx >= 0) {
                    ext = original.substring(idx);
                }
                String filename = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + ext;

                Path uploadDir = Paths.get("src/main/webapp/resources/admin/images/reviews/");
                Files.createDirectories(uploadDir);
                Path target = uploadDir.resolve(filename);
                try (InputStream in = media.getInputStream()) {
                    Files.copy(in, target, StandardCopyOption.REPLACE_EXISTING);
                }
                review.setImage(filename);
            } catch (IOException e) {
                redirectAttributes.addFlashAttribute("reviewMediaError", "Lưu file thất bại. Vui lòng thử lại.");
                return "redirect:/shop/product/{id}";
            }
        }

        // Save review
        reviewService.saveReview(review);
        redirectAttributes.addFlashAttribute("reviewSuccess", "Cảm ơn đánh giá của bạn!");
        return "redirect:/shop/product/{id}";
    }

    @PostMapping("/shop/product/{id}/favorite")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.Map<String, Object> toggleFavorite(@PathVariable("id") Long productId) {
        java.util.Map<String, Object> response = new java.util.HashMap<>();

        try {
            User currentUser = userAfterLogin.getUser();
            if (currentUser == null) {
                response.put("success", false);
                response.put("message", "Vui lòng đăng nhập để thêm sản phẩm yêu thích");
                return response;
            }

            Product product = productService.getProductById(productId);
            if (product == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm");
                return response;
            }

            boolean isFavorite = favoriteService.toggleFavorite(currentUser, product);
            response.put("success", true);
            response.put("isFavorite", isFavorite);
            response.put("message", isFavorite ? "Đã thêm vào yêu thích" : "Đã xóa khỏi yêu thích");

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        return response;
    }
}
