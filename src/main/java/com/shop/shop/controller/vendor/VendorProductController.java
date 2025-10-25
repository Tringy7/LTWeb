package com.shop.shop.controller.vendor;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.service.vendor.ProductDetailService;
import com.shop.shop.service.vendor.ProductService;
import com.shop.shop.service.vendor.ShopService;

@Controller
public class VendorProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private ShopService shopService;

    private Long getCurrentShopId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user) {
            return shopService.getShopByUserId(user.getId())
                    .map(Shop::getId)
                    .orElseThrow(() -> new RuntimeException("Shop not found for vendor user"));
        }
        throw new RuntimeException("User not authenticated");
    }

    @GetMapping("/vendor/product")
    public String showProducts(
            Model model,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "brand", required = false) String brand,
            @RequestParam(value = "gender", required = false) String gender,
            @RequestParam(value = "color", required = false) String color,
            @RequestParam(value = "priceRange", required = false) String priceRange) {

        Long SHOP_ID = getCurrentShopId();

        Double minPrice = null;
        Double maxPrice = null;

        // Chuyển priceRange thành minPrice / maxPrice
        if (priceRange != null) {
            switch (priceRange) {
                case "Dưới 500.000₫" -> {
                    minPrice = 0.0;
                    maxPrice = 500000.0;
                }
                case "500.000₫ - 1.000.000₫" -> {
                    minPrice = 500000.0;
                    maxPrice = 1000000.0;
                }
                case "1.000.000₫ - 3.000.000₫" -> {
                    minPrice = 1000000.0;
                    maxPrice = 3000000.0;
                }
                case "Trên 3.000.000₫" -> {
                    minPrice = 3000000.0;
                    maxPrice = null;
                }
            }
        }

        if (category != null && category.isEmpty())
            category = null;
        if (brand != null && brand.isEmpty())
            brand = null;
        if (gender != null && gender.isEmpty())
            gender = null;
        if (color != null && color.isEmpty())
            color = null;
        if (keyword != null && keyword.isEmpty())
            keyword = null;

        List<Product> products = productService.filterProducts(SHOP_ID, keyword, category, brand, gender, color,
                minPrice, maxPrice);

        products = products.stream()
                .filter(p -> "Active".equalsIgnoreCase(p.getStatus()))
                .toList();

        products.forEach(p -> p.getProductDetails().size());
        model.addAttribute("products", products);
        model.addAttribute("product", new Product());

        List<String> categories = productService.getCategoriesByShopId(SHOP_ID);
        model.addAttribute("categories", categories);
        model.addAttribute("brands", productService.getBrandsByShopId(SHOP_ID));
        model.addAttribute("genders", productService.getGendersByShopId(SHOP_ID));
        model.addAttribute("colors", productService.getColorsByShopId(SHOP_ID));
        model.addAttribute("priceRanges",
                List.of("Dưới 500.000₫", "500.000₫ - 1.000.000₫", "1.000.000₫ - 3.000.000₫", "Trên 3.000.000₫"));

        return "vendor/product/show";
    }

    @GetMapping("/vendor/product/detail")
    public String showProductDetail(@RequestParam("id") Long id, Model model) {
        Long SHOP_ID = getCurrentShopId();
        Optional<Product> optProduct = productService.getProductByIdAndShopId(id, SHOP_ID);
        if (optProduct.isEmpty()) {
            return "redirect:/vendor/product";
        }

        Product product = optProduct.get();
        if (!"Active".equalsIgnoreCase(product.getStatus())) {
            return "redirect:/vendor/product?error=status";
        }
        List<ProductDetail> details = productDetailService.getByProductId(id);
        model.addAttribute("product", product);
        model.addAttribute("details", details);
        return "vendor/product/detail";
    }

    @GetMapping("/vendor/product/add")
    public String showAddProductPage(Model model) {
        model.addAttribute("product", new Product());
        return "vendor/product/add-product";
    }

    @PostMapping("/vendor/product/add")
    public String addProduct(@ModelAttribute Product product,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) throws IOException {

        Shop shop = new Shop();
        Long SHOP_ID = getCurrentShopId();
        shop.setId(SHOP_ID);
        product.setShop(shop);

        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            Path uploadPath = Paths.get("src/main/webapp/resources/admin/images/product");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            imageFile.transferTo(uploadPath.resolve(fileName));
            product.setImage(fileName);
        }

        productService.save(product);
        return "redirect:/vendor/product";
    }

    @GetMapping("/vendor/product/edit/{id}")
    public String showEditProductPage(@PathVariable Long id, Model model) {
        Long SHOP_ID = getCurrentShopId();
        Optional<Product> optProduct = productService.getProductByIdAndShopId(id, SHOP_ID);
        if (optProduct.isEmpty()) {
            return "redirect:/vendor/product";
        }

        Product product = optProduct.get();
        if (!"Active".equalsIgnoreCase(product.getStatus())) {
            return "redirect:/vendor/product?error=status";
        }
        List<ProductDetail> details = productDetailService.getDetailsByProductId(product.getId());

        model.addAttribute("product", product);
        model.addAttribute("productDetails", details);
        return "vendor/product/edit-product";
    }

    @PostMapping("/vendor/product/update")
    public String updateProduct(@ModelAttribute Product product,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "detailId[]", required = false) List<Long> detailIds,
            @RequestParam(value = "size[]", required = false) List<String> sizes,
            @RequestParam(value = "quantity[]", required = false) List<Long> quantities)
            throws IOException {
        Long SHOP_ID = getCurrentShopId();
        Optional<Product> optProduct = productService.getProductByIdAndShopId(product.getId(), SHOP_ID);
        if (optProduct.isEmpty()) {
            return "redirect:/vendor/product";
        }

        Product existing = optProduct.get();
        if (!"Active".equalsIgnoreCase(product.getStatus())) {
            return "redirect:/vendor/product?error=status";
        }
        product.setShop(existing.getShop());

        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            Path uploadPath = Paths.get("src/main/webapp/resources/admin/images/product");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            imageFile.transferTo(uploadPath.resolve(fileName));
            product.setImage(fileName);
        } else {
            product.setImage(existing.getImage());
        }

        productService.save(product);

        if (sizes != null && quantities != null && detailIds != null) {
            List<ProductDetail> currentDetails = productDetailService.getDetailsByProductId(product.getId());
            Set<Long> updatedIds = new HashSet<>();

            for (int i = 0; i < sizes.size(); i++) {
                Long id = detailIds.get(i);
                String size = sizes.get(i);
                Long quantity = quantities.get(i);

                if (id != null && id != 0) {
                    ProductDetail detail = productDetailService.getById(id);
                    if (detail != null) {
                        detail.setQuantity(quantity);
                        productDetailService.save(detail);
                        updatedIds.add(id);
                    }
                } else {
                    ProductDetail newDetail = new ProductDetail();
                    newDetail.setProduct(product);
                    newDetail.setSize(size);
                    newDetail.setQuantity(quantity);
                    productDetailService.save(newDetail);
                }
            }

            for (ProductDetail oldDetail : currentDetails) {
                if (!updatedIds.contains(oldDetail.getId())) {
                    productDetailService.deleteByProductId(oldDetail.getId());
                }
            }
        }

        return "redirect:/vendor/product";
    }

    @PostMapping("/vendor/product/delete")
    public String deleteProduct(@ModelAttribute("product") Product product) {
        if (product.getId() != null) {
            Long SHOP_ID = getCurrentShopId();
            Optional<Product> optProduct = productService.getProductByIdAndShopId(product.getId(), SHOP_ID);
            if (optProduct.isPresent()) {
                Product existing = optProduct.get();

                if (!"Active".equalsIgnoreCase(existing.getStatus())) {
                    return "redirect:/vendor/product?error=status";
                }

                productService.deleteProductById(product.getId());
            }
        }
        return "redirect:/vendor/product";
    }
}
