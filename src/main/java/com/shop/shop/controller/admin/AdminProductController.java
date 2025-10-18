package com.shop.shop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.Shop;
import com.shop.shop.dto.ProductResponseDTO;
import com.shop.shop.dto.ProductUpdateDTO;
import com.shop.shop.dto.ShopResponseDTO;
import com.shop.shop.mapper.ProductMapper;
import com.shop.shop.mapper.ShopMapper;
import com.shop.shop.service.admin.ProductService;
import com.shop.shop.service.admin.ShopService;

import jakarta.validation.Valid;

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

    /**
     * Show edit form for existing product
     */
    @GetMapping("/admin/product/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isEmpty()) {
            return "redirect:/admin/product?error=product-not-found";
        }

        Product product = productOpt.get();

        // Create update DTO from existing product
        ProductUpdateDTO updateDTO = new ProductUpdateDTO();
        updateDTO.setId(product.getId());
        updateDTO.setName(product.getName());
        updateDTO.setBrand(product.getBrand());
        updateDTO.setColor(product.getColor());
        updateDTO.setDetailDesc(product.getDetailDesc());
        updateDTO.setImage(product.getImage());
        updateDTO.setPrice(product.getPrice());
        updateDTO.setCategory(product.getCategory());
        updateDTO.setGender(product.getGender());
        updateDTO.setShopId(product.getShop().getId());

        model.addAttribute("productUpdateDTO", updateDTO);
        model.addAttribute("shop", shopMapper.toShopResponseDTO(product.getShop()));
        return "admin/product/edit";
    }

    // Process product update

    @PostMapping("/admin/product/update")
    public String updateProduct(@Valid @ModelAttribute ProductUpdateDTO productUpdateDTO,
            BindingResult result,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "admin/product/edit";
        }

        try {
            Optional<Product> productOpt = productService.getProductById(productUpdateDTO.getId());
            if (productOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm");
                return "redirect:/admin/product";
            }

            Product product = productOpt.get();
            Long shopId = product.getShop().getId();

            // Update product using mapper
            productMapper.updateProductFromDTO(product, productUpdateDTO);
            productService.saveProduct(product);

            redirectAttributes.addFlashAttribute("success", "Cập nhật sản phẩm thành công!");
            return "redirect:/admin/product/shop/" + shopId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
            return "redirect:/admin/product/shop/" + productUpdateDTO.getShopId();
        }
    }

    // Delete product

    @PostMapping("/admin/product/{id}/delete")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Optional<Product> productOpt = productService.getProductById(id);
            if (productOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm");
                return "redirect:/admin/product";
            }

            Long shopId = productOpt.get().getShop().getId();
            productService.deleteProduct(id);

            redirectAttributes.addFlashAttribute("success", "Xóa sản phẩm thành công!");
            return "redirect:/admin/product/shop/" + shopId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi xóa sản phẩm: " + e.getMessage());
            return "redirect:/admin/product";
        }
    }
}
