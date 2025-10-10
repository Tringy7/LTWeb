package com.shop.shop.controller.client;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.service.client.ProductService;

@Controller
public class ShopController {

    @Autowired
    private ProductService productService;

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
            pageable = PageRequest.of(page, pageSize); // Mặc định không sắp xếp
        }

        Page<Product> productPage = productService.getProductPage(pageable);

        model.addAttribute("productList", productPage.getContent()); // Danh sách sản phẩm trên trang hiện tại
        model.addAttribute("currentPage", page); // Trang hiện tại
        model.addAttribute("totalPages", productPage.getTotalPages()); // Tổng số trang
        model.addAttribute("sort", sort); // Giá trị sắp xếp hiện tại

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
        model.addAttribute("averageRating", roundedRating);
        model.addAttribute("product", product);

        List<ProductDetail> productDetails = product.getProductDetails();
        int sum = 0;
        for (ProductDetail pd : productDetails) {
            sum += pd.getSold();
        }
        model.addAttribute("sumSold", sum);
        model.addAttribute("productDetail", product.getProductDetails());
        model.addAttribute("reviews", product.getReviews());
        return "client/shop/detail";
    }

    @GetMapping("/shop/search")
    public String searchProductByName(@RequestParam(value = "name", required = false) String name, Model model) {
        List<Product> products;

        if (name != null && !name.trim().isEmpty()) {
            products = productService.searchProductsByName(name);
            model.addAttribute("searchName", name);
        } else {
            products = productService.getAllProduct(); // Nếu không có name, trả về tất cả sản phẩm
            model.addAttribute("searchName", ""); // Để trống giá trị searchName
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
        model.addAttribute("filterList", productService.getBraList()); // Truyền lại danh sách bộ lọc
        model.addAttribute("selectedBrands", selectedBrands);
        model.addAttribute("selectedSizes", selectedSizes);
        model.addAttribute("selectedColors", selectedColors);
        model.addAttribute("selectedGenders", selectedGenders);
        model.addAttribute("maxPrice", maxPrice);

        return "client/shop/show";
    }
}
