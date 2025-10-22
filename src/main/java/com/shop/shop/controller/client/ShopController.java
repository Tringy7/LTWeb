package com.shop.shop.controller.client;

import java.util.ArrayList;
import java.util.List;

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
    private UserAfterLogin userAfterLogin;

    @Autowired
    private CartService cartService;

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("/shop")
    public String show(Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "default") String sort) {
        int pageSize = 8;
        Pageable pageable;

        // Xử lý sắp xếp
        if ("asc".equals(sort)) {
            pageable = PageRequest.of(page, pageSize, Sort.by("price").ascending());
        } else if ("desc".equals(sort)) {
            pageable = PageRequest.of(page, pageSize, Sort.by("price").descending());
        } else {
            pageable = PageRequest.of(page, pageSize);
        }

        Page<Product> productPage = productService.getProductPage(pageable);

        model.addAttribute("productList", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("sort", sort);
        model.addAttribute("filterList", productService.getBraList());

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

        model.addAttribute("productList", products);
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

        model.addAttribute("productList", filteredProducts);
        model.addAttribute("filterList", productService.getBraList());
        model.addAttribute("selectedBrands", selectedBrands);
        model.addAttribute("selectedSizes", selectedSizes);
        model.addAttribute("selectedColors", selectedColors);
        model.addAttribute("selectedGenders", selectedGenders);
        model.addAttribute("maxPrice", maxPrice);

        return "client/shop/show";
    }

    @PostMapping("/shop/product/{id}/review")
    public String handleReviewProduct(@PathVariable("id") Long id, @ModelAttribute("review") Review review) {
        review.setId(null);
        reviewService.saveReview(review);
        return "redirect:/shop/product/{id}";
    }
}
