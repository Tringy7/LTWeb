package com.shop.shop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.Shop;
import com.shop.shop.dto.ProductResponseDTO;
import com.shop.shop.dto.ShopResponseDTO;
import com.shop.shop.mapper.ProductMapper;
import com.shop.shop.mapper.ShopMapper;
import com.shop.shop.service.admin.ProductService;
import com.shop.shop.service.admin.ShopService;

//Admin Product Controller for managing products by shop
@Controller
public class AdminProductController {

    private final ProductService productService;
    private final ShopService shopService;
    private final ProductMapper productMapper;
    private final ShopMapper shopMapper;

    public AdminProductController(ProductService productService, ShopService shopService,
            ProductMapper productMapper, ShopMapper shopMapper) {
        this.productService = productService;
        this.shopService = shopService;
        this.productMapper = productMapper;
        this.shopMapper = shopMapper;
    }

    // Display list of all shops for product management
    @GetMapping("/admin/product")
    public String showShops(@RequestParam(defaultValue = "") String keyword, Model model) {
        List<Shop> shops = shopService.searchShops(keyword);
        List<ShopResponseDTO> shopDTOs = shops.stream()
                .map(shopMapper::toShopResponseDTO)
                .toList();

        // Add product counts to DTOs
        for (ShopResponseDTO shopDTO : shopDTOs) {
            long productCount = shopService.countProductsByShopId(shopDTO.getId());
            shopDTO.setTotalProducts(productCount);
        }

        model.addAttribute("shops", shopDTOs);
        model.addAttribute("keyword", keyword);
        return "admin/product/show";
    }

    // Display products for a specific shop
    @GetMapping("/admin/product/shop/{shopId}")
    public String showProductsByShop(@PathVariable Long shopId,
            @RequestParam(defaultValue = "") String keyword,
            Model model) {
        Optional<Shop> shopOpt = shopService.getShopById(shopId);
        if (shopOpt.isEmpty()) {
            return "redirect:/admin/product?error=shop-not-found";
        }

        Shop shop = shopOpt.get();
        List<Product> products = productService.searchProductsByKeywordAndShop(keyword, shopId);
        List<ProductResponseDTO> productDTOs = products.stream()
                .map(productMapper::toProductResponseDTO)
                .peek(productService::enrichProductResponseDTO) // Enrich with calculated fields
                .toList();

        model.addAttribute("shop", shopMapper.toShopResponseDTO(shop));
        model.addAttribute("products", productDTOs);
        model.addAttribute("keyword", keyword);
        return "admin/product/list";
    }

    // Display product details
    @GetMapping("/admin/product/{id}")
    public String showProductDetail(@PathVariable Long id, Model model) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isEmpty()) {
            return "redirect:/admin/product?error=product-not-found";
        }

        Product product = productOpt.get();
        ProductResponseDTO productDTO = productMapper.toProductResponseDTO(product);
        productService.enrichProductResponseDTO(productDTO); // Enrich with calculated fields

        model.addAttribute("product", productDTO);
        return "admin/product/detail";
    }

    // Admin product moderation actions
    @PostMapping("/admin/product/{id}/hide")
    public String hideProduct(@PathVariable Long id,
            @RequestParam String violationType,
            @RequestParam String adminNotes,
            RedirectAttributes redirectAttributes) {
        try {
            productService.hideProductForViolation(id, violationType, adminNotes);
            redirectAttributes.addFlashAttribute("success",
                    "Sản phẩm đã được ẩn do vi phạm: " + violationType);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Có lỗi xảy ra khi ẩn sản phẩm: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }

    @PostMapping("/admin/product/{id}/lock")
    public String lockProduct(@PathVariable Long id,
            @RequestParam String violationType,
            @RequestParam String adminNotes,
            RedirectAttributes redirectAttributes) {
        try {
            productService.lockProductForViolation(id, violationType, adminNotes);
            redirectAttributes.addFlashAttribute("success",
                    "Sản phẩm đã bị khóa do vi phạm: " + violationType);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Có lỗi xảy ra khi khóa sản phẩm: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }

    @PostMapping("/admin/product/{id}/activate")
    public String activateProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            productService.activateProduct(id);
            redirectAttributes.addFlashAttribute("success",
                    "Sản phẩm đã được kích hoạt lại");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Có lỗi xảy ra khi kích hoạt sản phẩm: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }

    // Shop status management
    @PostMapping("/admin/shop/{shopId}/status")
    public String changeShopStatus(@PathVariable Long shopId,
            @RequestParam String status,
            RedirectAttributes redirectAttributes) {
        try {
            shopService.changeShopStatus(shopId, status);
            redirectAttributes.addFlashAttribute("success",
                    "Trạng thái cửa hàng đã được cập nhật thành: " + status);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Có lỗi xảy ra khi cập nhật trạng thái cửa hàng: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }
}
