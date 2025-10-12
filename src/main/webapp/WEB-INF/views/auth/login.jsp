<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <title>Đăng nhập</title>
                <!-- base:css -->
                <link rel="stylesheet" href="<c:url value='/admin/vendors/typicons.font/font/typicons.css'/>">
                <link rel="stylesheet" href="<c:url value='/admin/vendors/css/vendor.bundle.base.css'/>">
                <!-- endinject -->
                <!-- inject:css -->
                <link rel="stylesheet" href="<c:url value='/admin/css/vertical-layout-light/style.css'/>">
                <!-- endinject -->
                <link rel="shortcut icon" href="<c:url value='/admin/images/favicon.png'/>" />
                <style>
                    .error-message {
                        color: red;
                        font-size: 0.875em;
                        margin-top: 0.25rem;
                    }
                </style>
            </head>

            <body>
                <div class="container-scroller">
                    <div class="container-fluid page-body-wrapper full-page-wrapper">
                        <div class="content-wrapper d-flex align-items-center auth px-0">
                            <div class="row w-100 mx-0">
                                <div class="col-lg-4 mx-auto">
                                    <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                                        <div class="brand-logo">
                                            <img src="<c:url value='/admin/images/logo.svg'/>" alt="logo">
                                        </div>
                                        <h4>Chào mừng bạn!</h4>
                                        <h6 class="font-weight-light">Đăng nhập để tiếp tục.</h6>
                                        <c:if test="${param.error != null}">
                                            <div class="my-2" style="color: red;">Tên đăng nhập hoặc mật khẩu không
                                                đúng!
                                            </div>
                                        </c:if>
                                        <c:if test="${param.logout != null}">
                                            <div class="my-2" style="color: green;">Đăng xuất thành công!
                                            </div>
                                        </c:if>
                                        <form class="pt-3" action="/login" method="post">
                                            <div class="form-group">
                                                <input type="email" class="form-control form-control-lg" name="email"
                                                    id="email" placeholder="Email" />
                                            </div>
                                            <div class="form-group">
                                                <input type="password" class="form-control form-control-lg"
                                                    name="password" placeholder="Mật khẩu" />
                                            </div>
                                            <div class="mt-3">
                                                <button type="submit"
                                                    class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">
                                                    ĐĂNG NHẬP
                                                </button>
                                            </div>
                                            <div class="my-2 d-flex justify-content-between align-items-center">
                                                <div class="form-check">
                                                    <label class="form-check-label text-muted">
                                                        <input type="checkbox" name="remember-me"
                                                            class="form-check-input" />
                                                        Ghi nhớ đăng nhập
                                                    </label>
                                                </div>
                                                <a href="#" class="auth-link text-black">Quên mật khẩu?</a>
                                            </div>
                                            <div class="text-center mt-4 font-weight-light">
                                                Chưa có tài khoản? <a href="/register" class="text-primary">Tạo tài
                                                    khoản</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- base:js -->
                <script src="<c:url value='/admin/vendors/js/vendor.bundle.base.js'/>"></script>
                <!-- endinject -->
                <!-- inject:js -->
                <script src="<c:url value='/admin/js/off-canvas.js'/>"></script>
                <script src="<c:url value='/admin/js/hoverable-collapse.js'/>"></script>
                <script src="<c:url value='/admin/js/template.js'/>"></script>
                <script src="<c:url value='/admin/js/settings.js'/>"></script>
                <script src="<c:url value='/admin/js/todolist.js'/>"></script>
                <!-- endinject -->
            </body>

            </html>