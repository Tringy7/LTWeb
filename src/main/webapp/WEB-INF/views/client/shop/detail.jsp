<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

                    <!-- Single Page Header start -->
                    <div class="container-fluid page-header py-5">
                        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s"
                            style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">Single Product
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
                                            <p class="mb-3">${product.category}</p>
                                            <h5 class="fw-bold mb-3">${product.price}</h5>
                                            <div class="d-flex mb-4">
                                                <c:choose>
                                                    <c:when test="${averageRating == null || averageRating == 0}">
                                                        <span class="text-muted"><strong class="text-primary">Chưa được
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
                                                <small>Available: <strong class="text-primary">${sumSold} items in
                                                        stock</strong></small>
                                                <small>Description: <strong
                                                        class="text-primary">${product.detailDesc}</strong></small>
                                                <small>Color: <strong
                                                        class="text-primary">${product.color}</strong></small>
                                            </div>
                                            <div class="mb-4">
                                                <span class="d-block fw-bold mb-2">SIZE</span>
                                                <div class="d-flex gap-2" id="size-options">
                                                    <button type="button" class="btn btn-size">S</button>
                                                    <button type="button" class="btn btn-size">M</button>
                                                    <button type="button" class="btn btn-size">L</button>
                                                    <button type="button" class="btn btn-size">XL</button>
                                                </div>
                                            </div>
                                            <div class="input-group quantity mb-5" style="width: 100px;">
                                                <div class="input-group-btn">
                                                    <button class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                                <input type="text"
                                                    class="form-control form-control-sm text-center border-0" value="1">
                                                <div class="input-group-btn">
                                                    <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                        <i class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <a href="#"
                                                class="btn btn-primary border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i
                                                    class="fa fa-shopping-bag me-2 text-white"></i> Add to cart</a>
                                        </div>
                                        <div class="col-lg-12">
                                            <nav>
                                                <div class="nav nav-tabs mb-3">

                                                    <button class="nav-link border-white border-bottom-0" type="button"
                                                        role="tab" id="nav-mission-tab" data-bs-toggle="tab"
                                                        data-bs-target="#nav-mission" aria-controls="nav-mission"
                                                        aria-selected="false">Reviews</button>
                                                </div>
                                            </nav>
                                            <div class="tab-content mb-5">
                                                <div class="tab-pane active" id="nav-mission" role="tabpanel"
                                                    aria-labelledby="nav-mission-tab">
                                                    <!-- Nếu không có review -->
                                                    <c:if test="${empty reviews}">
                                                        <div class="d-flex">
                                                            <p class="text-muted">Chưa có đánh giá nào cho sản phẩm này.
                                                            </p>
                                                        </div>
                                                    </c:if>
                                                    <c:forEach var="review" items="${reviews}">
                                                        <div class="d-flex">
                                                            <img src="img/avatar.jpg"
                                                                class="img-fluid rounded-circle p-3"
                                                                style="width: 100px; height: 100px;" alt="">
                                                            <div class="">
                                                                <p class="mb-2" style="font-size: 14px;">
                                                                    ${review.createdAt}
                                                                </p>
                                                                <div class="d-flex justify-content-between">
                                                                    <h5>Jason Smith</h5>
                                                                    <div class="d-flex mb-3">
                                                                        <i class="fa fa-star text-secondary"></i>
                                                                        <i class="fa fa-star text-secondary"></i>
                                                                        <i class="fa fa-star text-secondary"></i>
                                                                        <i class="fa fa-star text-secondary"></i>
                                                                        <i class="fa fa-star"></i>
                                                                    </div>
                                                                </div>
                                                                <p>${review.message}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                        <form action="#">
                                            <h4 class="mb-5 fw-bold">Leave a Reply</h4>
                                            <div class="row g-4">
                                                <div class="col-lg-6">
                                                    <div class="border-bottom rounded">
                                                        <input type="text" class="form-control border-0 me-4"
                                                            placeholder="Yur Name *">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="border-bottom rounded">
                                                        <input type="email" class="form-control border-0"
                                                            placeholder="Your Email *">
                                                    </div>
                                                </div>
                                                <div class="col-lg-12">
                                                    <div class="border-bottom rounded my-4">
                                                        <textarea name="" id="" class="form-control border-0" cols="30"
                                                            rows="8" placeholder="Your Review *"
                                                            spellcheck="false"></textarea>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12">
                                                    <div class="d-flex justify-content-between py-3 mb-5">
                                                        <div class="d-flex align-items-center">
                                                            <p class="mb-0 me-3">Please rate:</p>
                                                            <div class="d-flex align-items-center"
                                                                style="font-size: 12px;">
                                                                <i class="fa fa-star text-muted"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                                <i class="fa fa-star"></i>
                                                            </div>
                                                        </div>
                                                        <a href="#"
                                                            class="btn btn-primary border border-secondary text-primary rounded-pill px-4 py-3">
                                                            Post Comment</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Single Products End -->


                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary btn-lg-square back-to-top" style="display: none;"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="lib/wow/wow.min.js"></script>
                    <script src="lib/easing/easing.min.js"></script>
                    <script src="lib/waypoints/waypoints.min.js"></script>
                    <script src="lib/counterup/counterup.min.js"></script>
                    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
                    <script src="lib/lightbox/js/lightbox.min.js"></script>


                    <!-- Template Javascript -->
                    <script src="js/main.js"></script>
                    <script>
                        const sizeButtons = document.querySelectorAll(".btn-size");

                        sizeButtons.forEach((btn) => {
                            btn.addEventListener("click", () => {
                                // Bỏ active ở tất cả
                                sizeButtons.forEach((b) => b.classList.remove("active"));
                                // Thêm active cho nút được chọn
                                btn.classList.add("active");
                            });
                        });
                    </script>
                    <!-- Code injected by live-server -->
                    <script>
                        // <![CDATA[  <-- For SVG support
                        if ('WebSocket' in window) {
                            (function () {
                                function refreshCSS() {
                                    var sheets = [].slice.call(document.getElementsByTagName("link"));
                                    var head = document.getElementsByTagName("head")[0];
                                    for (var i = 0; i < sheets.length; ++i) {
                                        var elem = sheets[i];
                                        var parent = elem.parentElement || head;
                                        parent.removeChild(elem);
                                        var rel = elem.rel;
                                        if (elem.href && typeof rel != "string" || rel.length == 0 || rel.toLowerCase() == "stylesheet") {
                                            var url = elem.href.replace(/(&|\?)_cacheOverride=\d+/, '');
                                            elem.href = url + (url.indexOf('?') >= 0 ? '&' : '?') + '_cacheOverride=' + (new Date().valueOf());
                                        }
                                        parent.appendChild(elem);
                                    }
                                }
                                var protocol = window.location.protocol === 'http:' ? 'ws://' : 'wss://';
                                var address = protocol + window.location.host + window.location.pathname + '/ws';
                                var socket = new WebSocket(address);
                                socket.onmessage = function (msg) {
                                    if (msg.data == 'reload') window.location.reload();
                                    else if (msg.data == 'refreshcss') refreshCSS();
                                };
                                if (sessionStorage && !sessionStorage.getItem('IsThisFirstTime_Log_From_LiveServer')) {
                                    console.log('Live reload enabled.');
                                    sessionStorage.setItem('IsThisFirstTime_Log_From_LiveServer', true);
                                }
                            })();
                        }
                        else {
                            console.error('Upgrade your browser. This Browser is NOT supported WebSocket for Live-Reloading.');
                        }
                        // ]]>
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
                                <div class="lb-details"><span class="lb-caption"></span><span class="lb-number"></span>
                                </div>
                                <div class="lb-closeContainer"><a class="lb-close" role="button" tabindex="0"></a></div>
                            </div>
                        </div>
                    </div>
                </body>