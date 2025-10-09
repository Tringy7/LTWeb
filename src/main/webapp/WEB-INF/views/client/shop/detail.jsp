<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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
                                                        <span class="text-muted">Chưa được đánh giá</span>
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
                                                <small>Product SKU: N/A</small>
                                                <small>Available: <strong class="text-primary">20 items in
                                                        stock</strong></small>
                                            </div>
                                            <p class="mb-4">The generated Lorem Ipsum is therefore always free from
                                                repetition
                                                injected
                                                humour, or non-characteristic words etc.</p>
                                            <p class="mb-4">Susp endisse ultricies nisi vel quam suscipit. Sabertooth
                                                peacock
                                                flounder;
                                                chain pickerel hatchetfish, pencilfish snailfish</p>
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
                                                    <button class="nav-link active border-white border-bottom-0"
                                                        type="button" role="tab" id="nav-about-tab" data-bs-toggle="tab"
                                                        data-bs-target="#nav-about" aria-controls="nav-about"
                                                        aria-selected="true">Description</button>
                                                    <button class="nav-link border-white border-bottom-0" type="button"
                                                        role="tab" id="nav-mission-tab" data-bs-toggle="tab"
                                                        data-bs-target="#nav-mission" aria-controls="nav-mission"
                                                        aria-selected="false">Reviews</button>
                                                </div>
                                            </nav>
                                            <div class="tab-content mb-5">
                                                <div class="tab-pane active" id="nav-about" role="tabpanel"
                                                    aria-labelledby="nav-about-tab">
                                                    <p>Our new <b class="fw-bold">HPB12 / A12 battery</b> is rated at
                                                        2000mAh
                                                        and
                                                        designed to power up Black and Decker / FireStorm line of 12V
                                                        tools
                                                        allowing
                                                        users to run multiple devices off the same battery pack. The
                                                        HPB12
                                                        is
                                                        compatible
                                                        with the following Black and Decker power tool models:
                                                    </p>
                                                    <b class="fw-bold">Black &amp; Decker Drills and Drivers:</b>
                                                    <p class="small">BD12PSK, BDG1200K, BDGL12K, BDID1202, CD1200SK,
                                                        CD12SFK,
                                                        CDC1200K,
                                                        CDC120AK, CDC120ASB, CP122K, CP122KB, CP12K, CP12KB, EPC12,
                                                        EPC126,
                                                        EPC126BK,
                                                        EPC12CA, EPC12CABK, HP122K, HP122KD, HP126F2B, HP126F2K,
                                                        HP126F3B,
                                                        HP126F3K,
                                                        HP126FBH, HP126FSC, HP126FSH, HP126K, HP128F3B, HP12K, HP12KD,
                                                        HPD1200,
                                                        HPD1202,
                                                        HPD1202KF, HPD12K-2, PS122K, PS122KB, PS12HAK, SS12, SX3000,
                                                        SX3500,
                                                        XD1200,
                                                        XD1200K, XTC121
                                                    </p>
                                                    <b class="fw-bold">lack &amp; Decker Impact Wrenches:</b>
                                                    <p class="small">SX5000, XTC12IK, XTC12IKH</p>
                                                    <b class="fw-bold">Black &amp; Decker Multi-Tools:</b>
                                                    <p class="small">KC2000FK</p>
                                                    <b class="fw-bold">Black &amp; Decker Nailers:</b>
                                                    <p class="small">BDBN1202</p>
                                                    <b class="fw-bold">Black &amp; Decker Screwdrivers:</b>
                                                    <p class="small">HP9019K</p>
                                                    <b class="fw-bold mb-0">Best replacement for the following Black and
                                                        Decker
                                                        OEM
                                                        battery part numbers:</b>
                                                    <p class="small">HPB12, A12, A12EX, A12-XJ, A1712, B-8315, BD1204L,
                                                        BD-1204L,
                                                        BPT1047, FS120B, FS120BX, FSB12.</p>
                                                </div>
                                                <div class="tab-pane" id="nav-mission" role="tabpanel"
                                                    aria-labelledby="nav-mission-tab">
                                                    <div class="d-flex">
                                                        <img src="img/avatar.jpg" class="img-fluid rounded-circle p-3"
                                                            style="width: 100px; height: 100px;" alt="">
                                                        <div class="">
                                                            <p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
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
                                                            <p>The generated Lorem Ipsum is therefore always free from
                                                                repetition
                                                                injected humour, or non-characteristic
                                                                words etc. Susp endisse ultricies nisi vel quam suscipit
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex">
                                                        <img src="img/avatar.jpg" class="img-fluid rounded-circle p-3"
                                                            style="width: 100px; height: 100px;" alt="">
                                                        <div class="">
                                                            <p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
                                                            <div class="d-flex justify-content-between">
                                                                <h5>Sam Peters</h5>
                                                                <div class="d-flex mb-3">
                                                                    <i class="fa fa-star text-secondary"></i>
                                                                    <i class="fa fa-star text-secondary"></i>
                                                                    <i class="fa fa-star text-secondary"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                </div>
                                                            </div>
                                                            <p class="text-dark">The generated Lorem Ipsum is therefore
                                                                always
                                                                free from
                                                                repetition injected humour, or non-characteristic
                                                                words etc. Susp endisse ultricies nisi vel quam suscipit
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane" id="nav-vision" role="tabpanel">
                                                    <p class="text-dark">Tempor erat elitr rebum at clita. Diam dolor
                                                        diam
                                                        ipsum
                                                        et
                                                        tempor sit. Aliqu diam
                                                        amet diam et eos labore. 3</p>
                                                    <p class="mb-0">Diam dolor diam ipsum et tempor sit. Aliqu diam amet
                                                        diam et
                                                        eos
                                                        labore.
                                                        Clita erat ipsum et lorem et sit</p>
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