<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

        <style>
            .dropdown-item.highlight-login {
                background-color: #e8f5e9 !important;
                color: #2e7d32 !important;
                font-weight: 600;
                border-left: 3px solid #4caf50;
            }

            .dropdown-item.highlight-login:hover {
                background-color: #c8e6c9 !important;
                color: #1b5e20 !important;
            }

            .dropdown-item.highlight-logout {
                background-color: #ffebee !important;
                color: #c62828 !important;
                font-weight: 600;
                border-left: 3px solid #f44336;
            }

            .dropdown-item.highlight-logout:hover {
                background-color: #ffcdd2 !important;
                color: #b71c1c !important;
            }
        </style>

        <div class="container-fluid px-5 py-4 d-none d-lg-block">
            <div class="d-flex justify-content-between align-items-center">
                <!-- Logo bên trái -->
                <div>
                    <a href="/" class="navbar-brand p-0">
                        <h1 class="display-5 text-primary m-0">
                            <i class="fas fa-shopping-bag text-secondary me-2"></i>Fashion
                        </h1>
                    </a>
                </div>

                <!-- Giỏ hàng bên phải -->
                <c:if test="${not empty acc}">
                    <div>
                        <a href="/cart" class="text-muted d-flex align-items-center justify-content-center">
                            <span class="rounded-circle btn-md-square border">
                                <i class="fas fa-shopping-cart"></i>
                            </span>
                            <!-- <span class="text-dark ms-2">
                                <strong class="text-primary">
                                    <fmt:formatNumber value="${acc.cart.totalPrice}" type="currency" currencySymbol=""
                                        minFractionDigits="0" maxFractionDigits="0" /> VND
                                </strong>
                            </span> -->
                        </a>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Topbar End -->

        <!-- Navbar & Hero Start -->
        <div class="container-fluid nav-bar p-0">
            <div class="row gx-0 bg-primary px-5 align-items-center">
                <div class="col-lg-3 d-none d-lg-block">
                </div>
                <div class="col-12 col-lg-9">
                    <nav class="navbar navbar-expand-lg navbar-light bg-primary ">
                        <a href="" class="navbar-brand d-block d-lg-none">
                            <h1 class="display-5 text-secondary m-0"><i
                                    class="fas fa-shopping-bag text-white me-2"></i>Fashion
                            </h1>
                            <!-- <img src="img/logo.png" alt="Logo"> -->
                        </a>
                        <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars fa-1x"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarCollapse">
                            <div class="navbar-nav ms-auto py-0">
                                <a href="/" class="nav-item nav-link">Home</a>
                                <a href="/shop" class="nav-item nav-link">Shop</a>
                                <a href="/about" class="nav-item nav-link me-2">About</a>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Account</a>
                                    <div class="dropdown-menu m-0">
                                        <c:choose>
                                            <c:when test="${not empty acc}">
                                                <!-- Hiển thị khi đã đăng nhập -->
                                                <a href="/account" class="dropdown-item">My Profile</a>
                                                <a href="/order" class="dropdown-item">My Orders</a>
                                                <a href="/voucher" class="dropdown-item">My Vouchers</a>
                                                <a href="/chat" class="dropdown-item">Chat</a>
                                                <a href="/registraion-sales" class="dropdown-item">Register as
                                                    Seller</a>
                                                <a href="/logout" class="dropdown-item highlight-logout">
                                                    <i class="fas fa-sign-out-alt me-2"></i>Log out
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Hiển thị khi chưa đăng nhập -->
                                                <a href="/login" class="dropdown-item highlight-login">
                                                    <i class="fas fa-sign-in-alt me-2"></i>Log in
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var path = window.location.pathname;
                var navLinks = document.querySelectorAll('.navbar-nav .nav-link');
                navLinks.forEach(function (link) {
                    // So sánh chính xác hoặc bắt đầu bằng path (cho các trang con)
                    if (link.getAttribute('href') === path || (path !== "/" && link.getAttribute('href') !== "/" && path.startsWith(link.getAttribute('href')))) {
                        navLinks.forEach(l => l.classList.remove('active'));
                        link.classList.add('active');
                    }
                });
            });
        </script>
        <!-- Navbar & Hero End -->