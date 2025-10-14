<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                    <style>
                        .btn-size {
                            border: 2px solid transparent;
                            background-color: white;
                            color: #777;
                            font-weight: 600;
                            padding: 8px 18px;
                            border-radius: 10px;
                            cursor: pointer;
                            transition: all 0.2s ease;
                        }

                        /* Khi hover */
                        .btn-size:hover {
                            border-color: #fcd9b6;
                            /* màu viền khi hover */
                        }

                        /* Khi được chọn */
                        .btn-size.active {
                            border-color: #fcd9b6;
                            /* giống trong hình */
                            color: #000;
                        }
                    </style>

                    <body>

                        <!-- Spinner Start -->
                        <div id="spinner"
                            class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                        <!-- Spinner End -->

                        <!-- Toast Notification -->
                        <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
                            <div id="cartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                                <div class="toast-header">
                                    <i id="toastIcon" class="fas fa-check-circle text-success me-2"></i>
                                    <strong class="me-auto">Thông báo</strong>
                                    <small>Vừa xong</small>
                                    <button type="button" class="btn-close" data-bs-dismiss="toast"
                                        aria-label="Close"></button>
                                </div>
                                <div class="toast-body" id="toastMessage">
                                    ${cartMessage}
                                </div>
                            </div>
                        </div>


                        <!-- Single Page Header start -->
                        <div class="container-fluid page-header py-5">
                            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s"
                                style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">Single
                                Product
                            </h1>
                            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s"
                                style="visibility: visible; animation-delay: 0.3s; animation-name: fadeInUp;">
                                <li class="breadcrumb-item"><a href="/">Home</a></li>
                                <li class="breadcrumb-item"><a href="/shop">Shop</a></li>
                                <li class="breadcrumb-item active text-white">Single Product</li>
                            </ol>
                        </div>
                        <!-- Single Page Header End -->


                        <!-- Single Products Start -->
                        <div class="container-fluid shop py-5">
                            <div class="container py-5">
                                <div class="row justify-content-center">
                                    <div class="col-lg-10 col-xl-9 wow fadeInUp" data-wow-delay="0.1s"
                                        style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                                        <div class="row g-4 single-product">
                                            <div class="col-xl-6">
                                                <div class="single-carousel owl-carousel owl-loaded owl-drag">
                                                    <div class="owl-stage-outer">
                                                        <div class="owl-stage">
                                                            <div class="owl-item">
                                                                <div class="single-item"
                                                                    data-dot="&lt;img class='img-fluid' src='${ctx}/admin/images/product/${product.image}' alt=''&gt;">
                                                                    <div class="single-inner bg-light rounded">
                                                                        <img src="${ctx}/admin/images/product/${product.image}"
                                                                            class="img-fluid rounded" alt="Image">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6">
                                                <h4 class="fw-bold mb-3">${product.name}</h4>
                                                <h5 class="fw-bold mb-3">
                                                    <fmt:formatNumber value="${product.price}" type="currency"
                                                        currencySymbol="" minFractionDigits="0" maxFractionDigits="0" />
                                                    VND
                                                </h5>
                                                <div class="d-flex mb-4">
                                                    <c:choose>
                                                        <c:when test="${averageRating == null || averageRating == 0}">
                                                            <span class="text-muted"><strong class="text-primary">Chưa
                                                                    được
                                                                    đánh giá</strong></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="i" begin="1" end="5">
                                                                <c:if test="${i <= averageRating}">
                                                                    <i class="fa fa-star text-warning"></i>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div class="d-flex flex-column mb-3">
                                                    <small>Product Brand: <strong
                                                            class="text-primary">${product.brand}</strong></small>
                                                    <small>Gender: <strong
                                                            class="text-primary">${product.gender}</strong></small>
                                                    <small>Sold: <strong class="text-primary">${sumSold} sản
                                                            phẩm</strong></small>
                                                    <small>Description: <strong
                                                            class="text-primary">${product.detailDesc}</strong></small>
                                                    <small>Color: <strong
                                                            class="text-primary">${product.color}</strong></small>
                                                    <small>Available: <strong class="text-primary">${quantity} sản phẩm
                                                            trong kho</strong></small>
                                                </div>
                                                <form id="addToCartForm" action="/shop/product/${product.id}"
                                                    method="post">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <input type="hidden" name="price" value="${product.price}">
                                                    <input type="hidden" name="size" id="selected-size" value="">

                                                    <div class="mb-4">
                                                        <span class="d-block fw-bold mb-2">SIZE</span>
                                                        <div class="d-flex gap-2" id="size-options">
                                                            <c:forEach var="size" items="${sizes}">
                                                                <button type="button" class="btn btn-size"
                                                                    data-size="${size}">${size}</button>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <div class="input-group quantity mb-5" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <button type="button"
                                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="1" name="quantity">
                                                        <div class="input-group-btn">
                                                            <button type="button"
                                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <button type="submit"
                                                        class="btn btn-primary border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i
                                                            class="fa fa-shopping-bag me-2 text-white"></i> Add to
                                                        cart</button>
                                                </form>
                                            </div>


                                            <div class="col-lg-12">
                                                <nav>
                                                    <div class="nav nav-tabs mb-3">
                                                        <button class="nav-link active border-white border-bottom-0"
                                                            type="button" role="tab" id="nav-about-tab"
                                                            data-bs-toggle="tab" data-bs-target="#nav-about"
                                                            aria-controls="nav-about"
                                                            aria-selected="true">Description</button>
                                                        <button class="nav-link border-white border-bottom-0"
                                                            type="button" role="tab" id="nav-mission-tab"
                                                            data-bs-toggle="tab" data-bs-target="#nav-mission"
                                                            aria-controls="nav-mission"
                                                            aria-selected="false">Reviews</button>
                                                    </div>
                                                </nav>
                                                <div class="tab-content mb-5">
                                                    <div class="tab-pane active" id="nav-about" role="tabpanel"
                                                        aria-labelledby="nav-about-tab">
                                                        <p><strong class="text-primary">${shop.shopName}: </strong>
                                                            ${shop.description}
                                                        </p>
                                                        <strong class="text-primary">Bảng size tham khảo</strong>
                                                        <table class="table table-bordered mt-2 small">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col">Size</th>
                                                                    <th scope="col">Chiều cao (cm)</th>
                                                                    <th scope="col">Cân nặng (kg)</th>
                                                                    <th scope="col">Vòng ngực (cm)</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>S</td>
                                                                    <td>150 - 160</td>
                                                                    <td>40 - 50</td>
                                                                    <td>78 - 82</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>M</td>
                                                                    <td>160 - 165</td>
                                                                    <td>50 - 55</td>
                                                                    <td>83 - 87</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>L</td>
                                                                    <td>165 - 170</td>
                                                                    <td>55 - 60</td>
                                                                    <td>88 - 92</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>XL</td>
                                                                    <td>170 - 175</td>
                                                                    <td>60 - 65</td>
                                                                    <td>93 - 97</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="tab-pane" id="nav-mission" role="tabpanel"
                                                        aria-labelledby="nav-mission-tab">
                                                        <c:if test="${empty reviews}">
                                                            <div class="d-flex">
                                                                <p class="text-muted">Chưa có đánh giá nào cho sản phẩm
                                                                    này.
                                                                </p>
                                                            </div>
                                                        </c:if>
                                                        <c:forEach var="review" items="${reviews}">
                                                            <div class="d-flex">
                                                                <img src="/admin/images/user/${review.user.image}"
                                                                    class="img-fluid rounded-circle p-3"
                                                                    style="width: 100px; height: 100px;" alt="">
                                                                <div class="w-100">
                                                                    <div class="d-flex justify-content-between w-100">
                                                                        <h5>${review.user.fullName}</h5>
                                                                        <p class="mb-2" style="font-size: 14px;">
                                                                            ${review.createdAt}
                                                                        </p>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between">
                                                                        <p>${review.message}</p>
                                                                        <div class="d-flex mb-3">
                                                                            <c:forEach var="i" begin="1" end="5">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${review.rating != null && i <= review.rating}">
                                                                                        <i
                                                                                            class="fa fa-star text-warning"></i>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <i
                                                                                            class="fa fa-star text-muted"></i>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                            <form:form method="POST" action="/shop/product/${product.id}/review"
                                                modelAttribute="review">
                                                <h4 class="mb-5 fw-bold">Leave a Reply</h4>
                                                <div class="row g-4">
                                                    <div class="col-lg-6">
                                                        <div class="border-bottom rounded">
                                                            <form:input type="text" path="user.fullName"
                                                                class="form-control border-0 me-4"
                                                                placeholder="Your Name *" readonly="true" />
                                                        </div>
                                                    </div>
                                                    <form:input type="hidden" path="user" class="form-control border-0"
                                                        placeholder="Your Email *" readonly="true" />
                                                    <form:input type="hidden" path="product"
                                                        class="form-control border-0" placeholder="Your Email *"
                                                        readonly="true" />
                                                    <div class="col-lg-6">
                                                        <div class="border-bottom rounded">
                                                            <form:input type="email" path="user.email"
                                                                class="form-control border-0" placeholder="Your Email *"
                                                                readonly="true" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="border-bottom rounded my-4">
                                                            <form:textarea path="message" class="form-control border-0"
                                                                cols="30" rows="8" placeholder="Your Review *"
                                                                spellcheck="false" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="d-flex justify-content-between py-3 mb-5">
                                                            <div class="d-flex align-items-center">
                                                                <p class="mb-0 me-3">Please rate:</p>
                                                            </div>
                                                            <div class="d-flex align-items-center">
                                                                <div id="rating-stars"
                                                                    class="d-flex align-items-center me-4"
                                                                    style="font-size: 20px; cursor: pointer;">
                                                                    <i class="fa fa-star text-muted"
                                                                        data-rating="1"></i>
                                                                    <i class="fa fa-star text-muted"
                                                                        data-rating="2"></i>
                                                                    <i class="fa fa-star text-muted"
                                                                        data-rating="3"></i>
                                                                    <i class="fa fa-star text-muted"
                                                                        data-rating="4"></i>
                                                                    <i class="fa fa-star text-muted"
                                                                        data-rating="5"></i>
                                                                </div>
                                                                <form:input type="hidden" path="rating"
                                                                    id="rating-value" />
                                                                <button type="submit"
                                                                    class="btn btn-primary border border-secondary text-primary rounded-pill px-4 py-3">
                                                                    Post Comment
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Size Error Modal -->
                            <div class="modal fade" id="sizeErrorModal" tabindex="-1"
                                aria-labelledby="sizeErrorModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-sm modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header border-0">
                                            <h5 class="modal-title" id="sizeErrorModalLabel">Thông báo</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body text-center">
                                            Vui lòng chọn size sản phẩm!
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- Single Products End -->

                        <!-- JavaScript Libraries -->
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                        <script src="lib/wow/wow.min.js"></script>
                        <script src="lib/easing/easing.min.js"></script>
                        <script src="lib/waypoints/waypoints.min.js"></script>
                        <script src="lib/counterup/counterup.min.js"></script>
                        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
                        <script src="lib/lightbox/js/lightbox.min.js"></script>


                        <!-- Template Javascript -->
                        <script src="js/main.js"></script>
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                // Size selection
                                const sizeButtons = document.querySelectorAll(".btn-size");
                                const selectedSizeInput = document.getElementById("selected-size");

                                sizeButtons.forEach((btn) => {
                                    btn.addEventListener("click", () => {
                                        sizeButtons.forEach((b) => b.classList.remove("active"));
                                        btn.classList.add("active");
                                        selectedSizeInput.value = btn.dataset.size;
                                    });
                                });

                                // Quantity control
                                const btnMinus = document.querySelector('.btn-minus');
                                const btnPlus = document.querySelector('.btn-plus');
                                const quantityInput = document.querySelector('.quantity input');

                                btnMinus.addEventListener('click', function () {
                                    let currentValue = parseInt(quantityInput.value);
                                    if (currentValue > 1) {
                                        quantityInput.value = currentValue - 1;
                                    }
                                });

                                btnPlus.addEventListener('click', function () {
                                    let currentValue = parseInt(quantityInput.value);
                                    // You might want to add a check against available stock here
                                    quantityInput.value = currentValue + 1;
                                });

                                // Form submission validation
                                const addToCartForm = document.getElementById('addToCartForm');
                                const sizeErrorModal = new bootstrap.Modal(document.getElementById('sizeErrorModal'));

                                addToCartForm.addEventListener('submit', function (event) {
                                    if (selectedSizeInput.value === "") {
                                        // Prevent form submission
                                        event.preventDefault();
                                        // Show error modal
                                        sizeErrorModal.show();
                                    }
                                });

                                // Rating stars logic
                                const starsContainer = document.getElementById('rating-stars');
                                if (!starsContainer) return;

                                const stars = Array.from(starsContainer.querySelectorAll('.fa-star'));
                                const ratingInput = document.getElementById('rating-value');
                                let currentRating = 0;

                                const updateStars = (rating) => {
                                    stars.forEach(star => {
                                        const starRating = parseInt(star.dataset.rating);
                                        if (starRating <= rating) {
                                            star.classList.remove('text-muted');
                                            star.classList.add('text-warning');
                                        } else {
                                            star.classList.remove('text-warning');
                                            star.classList.add('text-muted');
                                        }
                                    });
                                };

                                starsContainer.addEventListener('mouseout', () => {
                                    updateStars(currentRating);
                                });

                                stars.forEach(star => {
                                    star.addEventListener('mouseover', () => updateStars(parseInt(star.dataset.rating)));
                                    star.addEventListener('click', () => {
                                        currentRating = parseInt(star.dataset.rating);
                                        ratingInput.value = currentRating;
                                    });
                                });
                            });

                            // Toast logic
                            const cartStatus = "${cartStatus}";
                            if (cartStatus) {
                                const cartToast = new bootstrap.Toast(document.getElementById('cartToast'));
                                const toastIcon = document.getElementById('toastIcon');
                                const toastMessage = document.getElementById('toastMessage');

                                if (cartStatus === 'success') {
                                    toastIcon.className = 'fas fa-check-circle text-success me-2';
                                    toastMessage.textContent = "${cartMessage}";
                                } else if (cartStatus === 'failure') {
                                    toastIcon.className = 'fas fa-times-circle text-danger me-2';
                                    toastMessage.textContent = "${cartMessage}";
                                }

                                cartToast.show();
                            }

                        </script>


                        <div id="lightboxOverlay" tabindex="-1" class="lightboxOverlay" style="display: none;"></div>
                        <div id="lightbox" tabindex="-1" class="lightbox" style="display: none;">
                            <div class="lb-outerContainer">
                                <div class="lb-container"><img class="lb-image"
                                        src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
                                        alt="">
                                    <div class="lb-nav"><a class="lb-prev" role="button" tabindex="0"
                                            aria-label="Previous image" href=""></a><a class="lb-next" role="button"
                                            tabindex="0" aria-label="Next image" href=""></a>
                                    </div>
                                    <div class="lb-loader"><a class="lb-cancel" role="button" tabindex="0"></a></div>
                                </div>
                            </div>
                            <div class="lb-dataContainer">
                                <div class="lb-data">
                                    <div class="lb-details"><span class="lb-caption"></span><span
                                            class="lb-number"></span>
                                    </div>
                                    <div class="lb-closeContainer"><a class="lb-close" role="button" tabindex="0"></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </body>