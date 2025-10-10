package com.shop.shop.controller.client;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

    // @GetMapping("/shop")
    // public String show(Model model, @RequestParam(defaultValue = "0") int page) {
    //     int pageSize = 8;
    //     Pageable pageable = PageRequest.of(page, pageSize);
    //     Page<Product> productPage = productService.getProductPage(pageable);
    //     List<Product> prodList = productPage.getContent().size() > 0 ? productPage.getContent() : new ArrayList<>();
    //     model.addAttribute("productPage", prodList);
    //     return "client/shop/show";
    // }
    @GetMapping("/shop")
    public String show(Model model, @RequestParam(defaultValue = "0") int page) {
        model.addAttribute("productList", productService.getAllProduct());
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

}
