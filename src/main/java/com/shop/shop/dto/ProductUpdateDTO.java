package com.shop.shop.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// DTO for updating existing products with validation annotations

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductUpdateDTO {

    private Long id;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(min = 2, max = 255, message = "Tên sản phẩm phải từ 2 đến 255 ký tự")
    private String name;

    @Size(max = 255, message = "Thương hiệu không được quá 255 ký tự")
    private String brand;

    @Size(max = 255, message = "Màu sắc không được quá 255 ký tự")
    private String color;

    @Size(max = 1000, message = "Mô tả không được quá 1000 ký tự")
    private String detailDesc;

    @Size(max = 255, message = "Đường dẫn hình ảnh không được quá 255 ký tự")
    private String image;

    @NotNull(message = "Giá sản phẩm không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá sản phẩm phải lớn hơn 0")
    private Double price;

    @Size(max = 255, message = "Danh mục không được quá 255 ký tự")
    private String category;

    @Size(max = 50, message = "Giới tính không được quá 50 ký tự")
    private String gender;

    @NotNull(message = "Vui lòng chọn cửa hàng")
    private Long shopId;

    @Override
    public String toString() {
        return "ProductUpdateDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", brand='" + brand + '\'' +
                ", price=" + price +
                ", shopId=" + shopId +
                '}';
    }
}
