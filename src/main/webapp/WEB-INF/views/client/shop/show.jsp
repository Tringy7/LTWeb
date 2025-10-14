<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
                <!-- Spinner End -->

                <!-- Searvices Start -->
                <div class="container-fluid px-0">
                    <div class="row g-0">
                        <div class="col-6 col-md-4 col-lg-2 border-start border-end wow fadeInUp" data-wow-delay="0.1s">
                            <div class="p-4">
                                <div class="d-inline-flex align-items-center">
                                    <i class="fa fa-sync-alt fa-2x text-primary"></i>
                                    <div class="ms-4">
                                        <h6 class="text-uppercase mb-2">Free Return</h6>
                                        <p class="mb-0">30 days money back guarantee!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.2s">
                            <div class="p-4">
                                <div class="d-flex align-items-center">
                                    <i class="fab fa-telegram-plane fa-2x text-primary"></i>
                                    <div class="ms-4">
                                        <h6 class="text-uppercase mb-2">Free Shipping</h6>
                                        <p class="mb-0">Free shipping on all order</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.3s">
                            <div class="p-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-life-ring fa-2x text-primary"></i>
                                    <div class="ms-4">
                                        <h6 class="text-uppercase mb-2">Support 24/7</h6>
                                        <p class="mb-0">We support online 24 hrs a day</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.4s">
                            <div class="p-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-credit-card fa-2x text-primary"></i>
                                    <div class="ms-4">
                                        <h6 class="text-uppercase mb-2">Receive Gift Card</h6>
                                        <p class="mb-0">Recieve gift all over oder $50</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.5s">
                            <div class="p-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-lock fa-2x text-primary"></i>
                                    <div class="ms-4">
                                        <h6 class="text-uppercase mb-2">Secure Payment</h6>
                                        <p class="mb-0">We Value Your Security</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.6s">
                            <div class="p-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-blog fa-2x text-primary"></i>
                                    <div class="ms-4">
                                        <h6 class="text-uppercase mb-2">Online Service</h6>
                                        <p class="mb-0">Free return products in 30 days</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Searvices End -->

                <!-- Shop Page Start -->
                <div class="container-fluid shop py-5">
                    <div class="container py-5">
                        <div class="row g-4">
                            <div class="col-lg-3 wow fadeInUp" data-wow-delay="0.1s">
                                <h3 style="color: #F28B00;">Filter</h3>
                                <hr>
                                <form action="/shop/filter" method="get">
                                    <!-- Price Filter -->
                                    <div class="price mb-4">
                                        <h4 class="mb-2">Price (VND)
                                        </h4>
                                        <input type="range" class="form-range w-100" id="rangeInput" name="maxPrice"
                                            min="0" max="10000000" value="${maxPrice != null ? maxPrice : 10000000}"
                                            oninput="amount.value = Number(rangeInput.value).toLocaleString('vi-VN')">
                                        <output id="amount" name="amount" for="rangeInput">${maxPrice != null ? maxPrice
                                            :
                                            10000000}</output>
                                        <p class="text-muted fst-italic mt-2">Get product &lt; price</p>
                                    </div>

                                    <!-- Brand Filter -->
                                    <div class="additional-product mb-4">
                                        <h4>Brand Products</h4>
                                        <c:forEach var="brand" items="${filterList.brandList}">
                                            <div class="form-check">
                                                <input type="checkbox" class="form-check-input" id="brand-${brand}"
                                                    name="brand" value="${brand}" <c:if
                                                    test="${not empty selectedBrands and selectedBrands.contains(brand)}">checked
                                                </c:if>>
                                                <label class="form-check-label" for="brand-${brand}">${brand}</label>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- Size Filter -->
                                    <div class="additional-product mb-4">
                                        <h4>Size Products</h4>
                                        <div class="d-flex flex-wrap">
                                            <c:forEach var="size" items="${filterList.sizeList}">
                                                <div class="form-check d-flex align-items-center me-3 mb-2">
                                                    <input type="checkbox" class="form-check-input me-2"
                                                        id="size-${size}" name="size" value="${size}" <c:if
                                                        test="${not empty selectedSizes and selectedSizes.contains(size)}">checked
                                                    </c:if>>
                                                    <label class="form-check-label" for="size-${size}">${size}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Color Filter -->
                                    <div class="additional-product mb-4">
                                        <h4>Color Products</h4>
                                        <div class="d-flex flex-wrap">
                                            <c:forEach var="color" items="${filterList.colorList}">
                                                <div class="form-check d-flex align-items-center me-3 mb-2">
                                                    <input type="checkbox" class="form-check-input me-2"
                                                        id="color-${color}" name="color" value="${color}" <c:if
                                                        test="${not empty selectedColors and selectedColors.contains(color)}">checked
                                                    </c:if>>
                                                    <label class="form-check-label"
                                                        for="color-${color}">${color}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Gender Filter -->
                                    <div class="additional-product mb-4">
                                        <h4>Gender</h4>
                                        <c:forEach var="gender" items="${filterList.genderList}">
                                            <div class="form-check">
                                                <input type="checkbox" class="form-check-input" id="gender-${gender}"
                                                    name="gender" value="${gender}" <c:if
                                                    test="${not empty selectedGenders and selectedGenders.contains(gender)}">checked
                                                </c:if>>
                                                <label class="form-check-label" for="gender-${gender}">${gender}</label>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <button type="submit" style="width: 274px;"
                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                        <i class="bi bi-funnel-fill"></i> Filter
                                    </button>
                                </form>
                            </div>
                            <div class="col-lg-9 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="rounded mb-4 position-relative">
                                    <img src="/client/img/product-banner-3.jpg" class="img-fluid rounded w-100"
                                        style="height: 250px;" alt="Image">
                                    <div class="position-absolute rounded d-flex flex-column align-items-center justify-content-center text-center"
                                        style="width: 100%; height: 250px; top: 0; left: 0; background: rgba(242, 139, 0, 0.3);">
                                        <h4 class="display-5 text-primary">SALE</h4>
                                        <h3 class="display-4 text-white mb-4">Get UP To 50% Off</h3>
                                        <a href="#" class="btn btn-primary rounded-pill">Shop Now</a>
                                    </div>
                                </div>
                                <div class="row g-4">
                                    <div class="col-xl-7">
                                        <div class="input-group w-100 mx-auto d-flex">
                                            <form action="/shop/search" method="get" class="d-flex w-100">
                                                <input type="search" name="name" class="form-control p-3"
                                                    placeholder="Enter product name" aria-describedby="search-icon-1"
                                                    value="${searchName != null ? searchName : ''}">
                                                <button type="submit" id="search-icon-1" class="input-group-text p-3">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 text-end">
                                        <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between">
                                            <label for="sort">Sort By:</label>
                                            <select id="sort" name="sort" class="border-0 form-select-sm bg-light me-3"
                                                onchange="updateSort()">
                                                <option value="default" ${sort=='default' ? 'selected' : '' }>Default
                                                </option>
                                                <option value="asc" ${sort=='asc' ? 'selected' : '' }>Low to high
                                                </option>
                                                <option value="desc" ${sort=='desc' ? 'selected' : '' }>High to low
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-xl-2">
                                        <ul
                                            class="nav nav-pills d-inline-flex text-center py-2 px-2 rounded bg-light mb-4">
                                            <li class="nav-item me-4">
                                                <a class="bg-light" data-bs-toggle="pill" href="#tab-5"
                                                    onclick="setActiveTab('#tab-5')">
                                                    <i class="fas fa-th fa-3x text-primary"></i>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="bg-light" data-bs-toggle="pill" href="#tab-6"
                                                    onclick="setActiveTab('#tab-6')">
                                                    <i class="fas fa-bars fa-3x text-primary"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="tab-content">
                                    <div id="tab-5" class="tab-pane fade show p-0 active">
                                        <div class="row g-4 product">
                                            <c:forEach var="product" items="${productList}">
                                                <div class="col-lg-4">
                                                    <div class="product-item rounded wow fadeInUp"
                                                        data-wow-delay="0.1s">
                                                        <div class="product-item-inner border rounded">
                                                            <div class="product-item-inner-item">
                                                                <img src="/admin/images/product/${product.image}"
                                                                    class="img-fluid w-100 rounded-top" alt=""
                                                                    style="width: 100%; height: 220px; object-fit: cover; border-radius: 8px;">
                                                                <div class="product-details">
                                                                    <a href="/shop/product/${product.id}"><i
                                                                            class="fa fa-eye fa-1x"></i></a>
                                                                </div>
                                                            </div>
                                                            <div class="text-center rounded-bottom p-4">
                                                                <a href="#" class="d-block mb-2">${product.category}</a>
                                                                <a href="#" class="d-block h4">${product.name}</a>
                                                                <span class="text-primary fs-5">
                                                                    <fmt:formatNumber value="${product.price}"
                                                                        type="currency" currencySymbol=""
                                                                        minFractionDigits="0" maxFractionDigits="0" />
                                                                    VND
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                                            <div>
                                                                <input type="hidden" name="productId"
                                                                    value="${product.id}" />
                                                                <a href="/shop/product/${product.id}" type="submit"
                                                                    class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                                                    <i class="fas fa-shopping-cart me-2"></i> Add To
                                                                    Cart
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <div class="col-12 wow fadeInUp" data-wow-delay="0.1s">
                                                <!-- Phân trang -->
                                                <c:if test="${totalPages == 0}">
                                                    <div class="pagination d-flex justify-content-center mt-4">
                                                        <p>Không có sản phẩm nào</p>
                                                    </div>
                                                </c:if>
                                                <c:if test="${totalPages > 0}">
                                                    <div class="pagination d-flex justify-content-center mt-4">
                                                        <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                                            <a href="/shop?page=${i}&sort=${sort}"
                                                                class="rounded ${i == currentPage ? 'active' : ''}">
                                                                ${i + 1}
                                                            </a>
                                                        </c:forEach>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-6" class="products tab-pane fade show p-0">
                                        <div class="row g-4 products-mini">
                                            <c:forEach var="product" items="${productList}">
                                                <div class="col-lg-6">
                                                    <div class="products-mini-item border"
                                                        style="width: 400px; height: 194.611px; margin: auto;">
                                                        <div class="row g-0">
                                                            <div class="col-5">
                                                                <div class="products-mini-img border-end h-100">
                                                                    <img src="/admin/images/product/${product.image}"
                                                                        class="img-fluid w-100 h-100"
                                                                        alt="${product.name}"
                                                                        style="width: 194.611px; height: 194.611px; object-fit: cover;">
                                                                    <div
                                                                        class="products-mini-icon rounded-circle bg-primary">
                                                                        <a href="/shop/product/${product.id}"><i
                                                                                class="fa fa-eye fa-1x text-white"></i></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-7">
                                                                <div class="products-mini-content p-3">
                                                                    <a href="#"
                                                                        class="d-block mb-2">${product.category}</a>
                                                                    <a href="#" class="d-block h4">${product.name}</a>
                                                                    <!-- <del class="me-2 fs-5">${product.price * 1.2} $</del> -->
                                                                    <span class="text-primary fs-5">
                                                                        <fmt:formatNumber value="${product.price}"
                                                                            type="currency" currencySymbol=""
                                                                            minFractionDigits="0"
                                                                            maxFractionDigits="0" /> VND
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="products-mini-add border p-3">
                                                            <div>
                                                                <input type="hidden" name="productId"
                                                                    value="${product.id}" />
                                                                <a href="/shop/product/${product.id}" type="submit"
                                                                    class="btn btn-primary border-secondary rounded-pill py-2 px-4">
                                                                    <i class="fas fa-shopping-cart me-2"></i> Add To
                                                                    Cart
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <div class="col-12 wow fadeInUp" data-wow-delay="0.1s">
                                                <!-- Phân trang -->
                                                <c:if test="${totalPages == 0}">
                                                    <div class="pagination d-flex justify-content-center mt-4">
                                                        <p>Không có sản phẩm nào</p>
                                                    </div>
                                                </c:if>
                                                <c:if test="${totalPages > 0}">
                                                    <div class="pagination d-flex justify-content-center mt-4">
                                                        <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                                            <a href="/shop?page=${i}&sort=${sort}"
                                                                class="rounded ${i == currentPage ? 'active' : ''}">
                                                                ${i + 1}
                                                            </a>
                                                        </c:forEach>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Shop Page End -->

                <!-- Product Banner Start -->
                <div class="container-fluid py-5">
                    <div class="container pb-5">
                        <div class="row g-4">
                            <div class="col-lg-6 wow fadeInLeft" data-wow-delay="0.1s">
                                <a href="#">
                                    <div class="bg-primary rounded position-relative">
                                        <img src="/client/img/product-banner.jpg" class="img-fluid w-100 rounded"
                                            alt="">
                                        <div class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column justify-content-center rounded p-4"
                                            style="background: rgba(255, 255, 255, 0.5);">
                                            <h3 class="display-5 text-primary">EOS Rebel <br> <span>T7i Kit</span></h3>
                                            <p class="fs-4 text-muted">$899.99</p>
                                            <a href="#"
                                                class="btn btn-primary rounded-pill align-self-start py-2 px-4">Shop
                                                Now</a>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-lg-6 wow fadeInRight" data-wow-delay="0.2s">
                                <a href="#">
                                    <div class="text-center bg-primary rounded position-relative">
                                        <img src="/client/img/product-banner-2.jpg" class="img-fluid w-100" alt="">
                                        <div class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column justify-content-center rounded p-4"
                                            style="background: rgba(242, 139, 0, 0.5);">
                                            <h2 class="display-2 text-secondary">SALE</h2>
                                            <h4 class="display-5 text-white mb-4">Get UP To 50% Off</h4>
                                            <a href="#"
                                                class="btn btn-secondary rounded-pill align-self-center py-2 px-4">Shop
                                                Now</a>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Product Banner End -->
                <script>
                    function updateSort() {
                        const sort = document.getElementById("sort").value; // Lấy giá trị được chọn
                        const url = new URL(window.location.href); // Lấy URL hiện tại
                        url.searchParams.set("sort", sort); // Cập nhật giá trị của tham số "sort"
                        url.searchParams.set("page", 0); // Reset về trang đầu tiên khi thay đổi
                        window.location.href = url.toString(); // Điều hướng đến URL mới
                    }
                </script>

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/wow/wow.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>


                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>
            </body>