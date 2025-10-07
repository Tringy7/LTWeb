<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title>Electro - Electronics Website Template</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <meta content="" name="keywords">
                <meta content="" name="description">

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="client/lib/animate/animate.min.css" rel="stylesheet">
                <link href="client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                <!-- Customized Bootstrap Stylesheet -->
                <link href="client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="client/css/style.css" rel="stylesheet">

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
                <!-- Spinner End -->


<%--                <jsp:include page="../common/navbar.jsp" />--%>

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
                                        <h1 class="display-3 text-capitalize mb-4 wow fadeInRight"
                                            data-wow-delay="0.3s">On Selected Fashion Items
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
                                        <h1 class="display-3 text-capitalize mb-4 wow fadeInRight"
                                            data-wow-delay="0.3s">Save Big On T-Shirts, Jackets & Sneakers</h1>
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
                                <img src="img/header-img.jpg" class="img-fluid w-100 h-100" style="object-fit: cover;"
                                    alt="Image">
                                <div class="carousel-banner-offer">
                                    <p class="bg-primary text-white rounded fs-5 py-2 px-4 mb-0 me-3">Save $48.00</p>
                                    <p class="text-primary fs-5 fw-bold mb-0">Special Offer</p>
                                </div>
                                <div class="carousel-banner">
                                    <div class="carousel-banner-content text-center p-4">
                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                        <a href="#" class="d-block text-white fs-3">Apple iPad Mini <br> G2356</a>
                                        <del class="me-2 text-white fs-5">$1,250.00</del>
                                        <span class="text-primary fs-5">$1,050.00</span>
                                    </div>
                                    <a href="#" class="btn btn-primary rounded-pill py-2 px-4"><i
                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                    <h1>Our Products</h1>
                                </div>
                                <div class="col-lg-8 text-end wow fadeInRight" data-wow-delay="0.1s">
                                </div>
                            </div>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-3.png" class="img-fluid w-100 rounded-top"
                                                            alt="">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.3s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-4.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-sale">sale</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.5s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-5.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.7s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-6.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-7.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-sale">Sale</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.3s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-8.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.5s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-9.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.7s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-10.png"
                                                            class="img-fluid w-100 rounded-top" alt="">
                                                        <div class="product-sale">Sale</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane fade show p-0">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-3.png" class="img-fluid rounded-top"
                                                            alt="">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.3s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-4.png" class="img-fluid w-100 rounded-top"
                                                            alt="">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.5s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-5.png" class="img-fluid w-100 rounded-top"
                                                            alt="">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.7s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-6.png" class="img-fluid w-100 rounded-top"
                                                            alt="Image">
                                                        <div class="product-new">New</div>
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-3" class="tab-pane fade show p-0">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-9.png" class="img-fluid w-100 rounded-top"
                                                            alt="">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.3s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-10.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.5s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-11.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.7s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-12.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-4" class="tab-pane fade show p-0">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-14.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.3s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-15.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.5s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-17.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="product-item rounded wow fadeInUp" data-wow-delay="0.7s">
                                                <div class="product-item-inner border rounded">
                                                    <div class="product-item-inner-item">
                                                        <img src="img/product-16.png"
                                                            class="img-fluid w-100 rounded-top" alt="Image">
                                                        <div class="product-details">
                                                            <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                        </div>
                                                    </div>
                                                    <div class="text-center rounded-bottom p-4">
                                                        <a href="#" class="d-block mb-2">SmartPhone</a>
                                                        <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                        <del class="me-2 fs-5">$1,250.00</del>
                                                        <span class="text-primary fs-5">$1,050.00</span>
                                                    </div>
                                                </div>
                                                <div
                                                    class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                                    <a href="#"
                                                        class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                            class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
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
                                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-random"></i></i></a>
                                                            <a href="#"
                                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                                    class="rounded-circle btn-sm-square border"><i
                                                                        class="fas fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Our Products End -->

                <!-- Product List Satrt -->
                <div class="container-fluid products productList overflow-hidden">
                    <div class="container products-mini py-5">
                        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
                            <h4 class="text-primary border-bottom border-primary border-2 d-inline-block p-2 title-border-radius wow fadeInUp"
                                data-wow-delay="0.1s">Products</h4>
                            <h1 class="mb-0 display-3 wow fadeInUp" data-wow-delay="0.3s">All Product Items</h1>
                        </div>
                        <div class="productList-carousel owl-carousel pt-4 wow fadeInUp" data-wow-delay="0.3s">
                            <div class="productImg-carousel owl-carousel productList-item">
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-4.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-4.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-6.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-7.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="productImg-carousel owl-carousel productList-item">
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-8.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-9.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-10.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-11.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="productImg-carousel owl-carousel productList-item">
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-12.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-13.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-14.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-15.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="productImg-carousel owl-carousel productList-item">
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-16.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-17.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="productImg-item products-mini-item border">
                                    <div class="row g-0">
                                        <div class="col-5">
                                            <div class="products-mini-img border-end h-100">
                                                <img src="img/product-3.png" class="img-fluid w-100 h-100" alt="Image">
                                                <div class="products-mini-icon rounded-circle bg-primary">
                                                    <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-7">
                                            <div class="products-mini-content p-3">
                                                <a href="#" class="d-block mb-2">SmartPhone</a>
                                                <a href="#" class="d-block h4">Apple iPad Mini <br> G2356</a>
                                                <del class="me-2 fs-5">$1,250.00</del>
                                                <span class="text-primary fs-5">$1,050.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="products-mini-add border p-3">
                                        <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex">
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-random"></i></i></a>
                                            <a href="#"
                                                class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                    class="rounded-circle btn-sm-square border"><i
                                                        class="fas fa-heart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Product List End -->

<%--                <jsp:include page="../common/footer.jsp" />--%>

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