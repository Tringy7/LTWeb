<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
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
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Setting</a>
                                    <div class="dropdown-menu m-0">
                                        <a href="/account" class="dropdown-item">My Account</a>
                                        <a href="/voucher" class="dropdown-item">My voucher</a>
                                        <a href="/order" class="dropdown-item">History</a>
                                        <a href="/login" class="dropdown-item">Log in</a>
                                        <a href="/logout" class="dropdown-item">Log out</a>
                                    </div>
                                </div>
                                <a href="/about" class="nav-item nav-link me-2">About</a>
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