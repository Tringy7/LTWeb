package com.shop.shop.controller.vendor;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

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
import com.shop.shop.service.vendor.ProductDetailService;
import com.shop.shop.service.vendor.ProductService;

@Controller
public class VendorProductController {

    private final ProductService productService;
    private final ProductDetailService productDetailService;

    // Giả định vendor thuộc shopId = 1
    private static final Long SHOP_ID = 1L;

    public VendorProductController(ProductService productService, ProductDetailService productDetailService) {
        this.productService = productService;
        this.productDetailService = productDetailService;
    }

    @GetMapping("/vendor/product")
    public String showProducts(
            Model model,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "category", required = false) String category) {

        List<Product> products;

        if ((keyword != null && !keyword.isEmpty()) && (category != null && !category.isEmpty())) {
            products = productService.searchProductsByNameAndCategory(SHOP_ID, keyword, category);
        } else if (keyword != null && !keyword.isEmpty()) {
            products = productService.searchProductsByName(SHOP_ID, keyword);
        } else if (category != null && !category.isEmpty()) {
            products = productService.getProductsByShopIdAndCategory(SHOP_ID, category);
        } else {
            products = productService.getProductsByShopId(SHOP_ID);
        }

        products.forEach(p -> p.getProductDetails().size());
        model.addAttribute("products", products);
        model.addAttribute("product", new Product());

        // Lấy danh sách category hiện có
        List<String> categories = productService.getCategoriesByShopId(SHOP_ID);
        model.addAttribute("categories", categories);

        return "vendor/product/show";
    }

    @GetMapping("/vendor/product/detail")
    public String showProductDetail(@RequestParam("id") Long id, Model model) {
        Optional<Product> optProduct = productService.getProductByIdAndShopId(id, SHOP_ID);
        if (optProduct.isEmpty()) {
            return "redirect:/vendor/product";
        }

        Product product = optProduct.get();
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
        Optional<Product> optProduct = productService.getProductByIdAndShopId(id, SHOP_ID);
        if (optProduct.isEmpty()) {
            return "redirect:/vendor/product";
        }

        Product product = optProduct.get();
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

        Optional<Product> optProduct = productService.getProductByIdAndShopId(product.getId(), SHOP_ID);
        if (optProduct.isEmpty()) {
            return "redirect:/vendor/product";
        }

        Product existing = optProduct.get();
        product.setShop(existing.getShop());

        // === Cập nhật hình ảnh ===
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

        // === Cập nhật thông tin sản phẩm ===
        productService.save(product);

        // === Cập nhật chi tiết size & số lượng ===
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
                    // Thêm mới
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
            Optional<Product> optProduct = productService.getProductByIdAndShopId(product.getId(), SHOP_ID);
            if (optProduct.isPresent()) {
                productService.deleteProductById(product.getId());
            }
        }
        return "redirect:/vendor/product";
    }
}
