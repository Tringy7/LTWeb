<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <body>

            <!-- Spinner Start -->
            <div id="spinner"
                class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->

            <!-- Carousel Start -->
            <div class="container-fluid carousel bg-light px-0">
                <div class="row g-0 justify-content-end">
                    <div class="col-12 col-lg-7 col-xl-9">
                        <div class="header-carousel owl-carousel bg-light py-5">
                            <div class="row g-0 header-carousel-item align-items-center">
                                <div class="col-xl-6 carousel-img wow fadeInLeft" data-wow-delay="0.1s">
                                    <img src="/client/img/banner1.jpg" class="img-fluid w-100" alt="Image">
                                </div>
                                <div class="col-xl-6 carousel-content p-4">
                                    <h4 class="text-uppercase fw-bold mb-4 wow fadeInRight" data-wow-delay="0.1s"
                                        style="letter-spacing: 3px;">Save Up To 50%</h4>
                                    <h1 class="display-3 text-capitalize mb-4 wow fadeInRight" data-wow-delay="0.3s">On
                                        Selected Fashion Items
                                        Tops, Jeans & Dresses</h1>
                                    <p class="text-dark wow fadeInRight" data-wow-delay="0.5s">Terms and Condition
                                        Apply</p>
                                    <a class="btn btn-primary rounded-pill py-3 px-5 wow fadeInRight"
                                        data-wow-delay="0.7s" href="#">Shop Now</a>
                                </div>
                            </div>
                            <div class="row g-0 header-carousel-item align-items-center">
                                <div class="col-xl-6 carousel-img wow fadeInLeft" data-wow-delay="0.1s">
                                    <img src="/client/img/banner2.jpg" class="img-fluid w-100" alt="Image">
                                </div>
                                <div class="col-xl-6 carousel-content p-4">
                                    <h4 class="text-uppercase fw-bold mb-4 wow fadeInRight" data-wow-delay="0.1s"
                                        style="letter-spacing: 3px;">FLASH SALE</h4>
                                    <h1 class="display-3 text-capitalize mb-4 wow fadeInRight" data-wow-delay="0.3s">
                                        Save Big On T-Shirts, Jackets & Sneakers</h1>
                                    <p class="text-dark wow fadeInRight" data-wow-delay="0.5s">Terms and Condition
                                        Apply</p>
                                    <a class="btn btn-primary rounded-pill py-3 px-5 wow fadeInRight"
                                        data-wow-delay="0.7s" href="#">Shop Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-5 col-xl-3 wow fadeInRight" data-wow-delay="0.1s">
                        <div class="carousel-header-banner h-100">
                            <img src="/admin/images/product/${productTop.image}" class="img-fluid w-100 h-100"
                                style="object-fit: cover;" alt="${productTop.name}">
                            <div class="carousel-banner-offer">
                                <p class="bg-primary text-white rounded fs-5 py-2 px-4 mb-0 me-3">
                                    Top Sold
                                </p>
                                <p class="text-primary fs-5 fw-bold mb-0">Best Seller</p>
                            </div>
                            <div class="carousel-banner">
                                <div class="carousel-banner-content text-center p-4">
                                    <a href="#" class="d-block mb-2">${productTop.category}</a>
                                    <a href="#" class="d-block text-white fs-3">${productTop.name}</a>
                                    <span class="text-primary fs-5">${productTop.price} vnd</span>
                                </div>
                                <form action="/cart/add" method="post">
                                    <input type="hidden" name="productId" value="${productTop.id}" />
                                    <button type="submit" class="btn btn-primary rounded-pill py-2 px-4 w-100 mt-2">
                                        <i class="fas fa-shopping-cart me-2"></i> Add To Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Carousel End -->

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

            <!-- Our Products Start -->
            <div class="container-fluid product py-5">
                <div class="container py-5">
                    <div class="tab-class">
                        <div class="row g-4">
                            <div class="col-lg-4 text-start wow fadeInLeft" data-wow-delay="0.1s">
                                <h1>Top Products</h1>
                            </div>
                            <div class="col-lg-8 text-end wow fadeInRight" data-wow-delay="0.1s">
                            </div>
                        </div>
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane fade show p-0 active">
                                <div class="row g-4">
                                    <c:forEach var="product" items="${productSoldOver10}">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="/admin/images/product/${product.image}"
                                                            class="img-fluid w-100 rounded-top" alt=""
                                                            style="max-width:220px; max-height:220px; object-fit:cover; margin:auto; display:block;">
                                                        <div class="product-details">
                                                            <a href="/shop/product/${product.id}"><i
                                                                    class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">${product.category}</a>
                                                        <a href="#" class="d-block h4">${product.name}</a>
                                                        <span class="text-primary fs-5">${product.price} vnd</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                                    <form action="/cart/add" method="post">
                                                        <input type="hidden" name="productId" value="${product.id}" />
                                                        <button type="submit"
                                                            class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4">
                                                            <i class="fas fa-shopping-cart me-2"></i> Add To Cart
                                                        </button>
                                                    </form>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="d-flex">
                                                            <i class="fas fa-star text-primary"></i>
                                                            <i class="fas fa-star text-primary"></i>
                                                            <i class="fas fa-star text-primary"></i>
                                                            <i class="fas fa-star text-primary"></i>
                                                            <i class="fas fa-star"></i>
                                                        </div>
                                                        <div class="d-flex">
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-3">
                                                                <span class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></span>
                                                            </a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0">
                                                                <span class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Our Products End -->

            <!-- Product List Start -->
            <div class="container-fluid products productList overflow-hidden" style="margin-bottom: 80px;">
                <div class="container products-mini py-5">
                    <div class="mx-auto text-center mb-5" style="max-width: 900px;">
                        <h4 class="text-primary border-bottom border-primary border-2 d-inline-block p-2 title-border-radius wow fadeInUp"
                            data-wow-delay="0.1s">Products</h4>
                        <h1 class="mb-0 display-3 wow fadeInUp" data-wow-delay="0.3s">All Product Items</h1>
                    </div>
                    <div class="productList-carousel owl-carousel pt-4 wow fadeInUp" data-wow-delay="0.3s">
                        <c:forEach var="product" items="${productList}">
                            <div class="productImg-item products-mini-item border"
                                style="min-height: 340px; display: flex; flex-direction: column; justify-content: space-between;">
                                <div class="row g-0" style="height: 100%;">
                                    <div class="col-5">
                                        <div class="products-mini-img border-end h-100"
                                            style="height: 220px; display: flex; align-items: center;">
                                            <img src="/admin/images/product/${product.image}"
                                                class="img-fluid w-100 rounded-top" alt="${product.name}"
                                                style="width:304.222px; height:220px; object-fit:cover; margin:auto; display:block;">
                                            <div class="products-mini-icon rounded-circle bg-primary">
                                                <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-7">
                                        <div class="products-mini-content p-3">
                                            <a href="#" class="d-block mb-2">${product.category}</a>
                                            <a href="#" class="d-block h4">${product.name}</a>
                                            <span class="text-primary fs-5">${product.price} vnd</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="products-mini-add border p-3" style="background: #fff;">
                                    <form action="/cart/add" method="post" style="margin-bottom: 0;">
                                        <input type="hidden" name="productId" value="${product.id}" />
                                        <button type="submit"
                                            class="btn btn-primary border-secondary rounded-pill py-2 px-4 w-100 mb-2">
                                            <i class="fas fa-shopping-cart me-2"></i> Add To Cart
                                        </button>
                                    </form>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <a href="#"
                                            class="text-primary d-flex align-items-center justify-content-center me-3">
                                            <span class="rounded-circle btn-sm-square border"><i
                                                    class="fas fa-random"></i></span>
                                        </a>
                                        <a href="#"
                                            class="text-primary d-flex align-items-center justify-content-center me-0">
                                            <span class="rounded-circle btn-sm-square border"><i
                                                    class="fas fa-heart"></i></span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Product List End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>


            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="client/lib/wow/wow.min.js"></script>
            <script src="client/lib/owlcarousel/owl.carousel.min.js"></script>


            <!-- Template Javascript -->
            <script src="client/js/main.js"></script>
        </body>

        </html>