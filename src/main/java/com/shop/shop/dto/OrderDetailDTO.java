package com.shop.shop.dto;

//Update to dto
//dto -> tmp
//tmp -> dto
public class OrderDetailDTO {
    private Long id;
    private Long productId;
    private String productName;
    private String shopName;
    private Long quantity;
    private double price;
    private String image;
    private String status;

    public OrderDetailDTO(Long id, Long productId, String productName, String shopName, Long quantity, double price,
            String image, String status) {
        this.id = id;
        this.productId = productId;
        this.productName = productName;
        this.shopName = shopName;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
        this.status = status;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

}
