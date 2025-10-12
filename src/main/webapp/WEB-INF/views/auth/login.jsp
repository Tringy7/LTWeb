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
                                                đúng!</div>
                                        </c:if>
                                        <c:if test="${param.logout != null}">
                                            <div class="my-2" style="color: green;">Đăng xuất thành công!</div>
                                        </c:if>
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger">${error}</div>
                                        </c:if>
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-success">${message}</div>
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
                                                <a href="#" class="auth-link text-black" data-toggle="modal"
                                                    data-target="#forgotPasswordModal">Quên mật khẩu?</a>
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
                        <!-- Forgot Password Modal -->
                        <div class="modal fade" id="forgotPasswordModal" tabindex="-1" role="dialog"
                            aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="forgotPasswordModalLabel">Đặt lại mật khẩu</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form action="<c:url value='/forgot-password' />" method="post">
                                        <div class="modal-body">
                                            <c:if test="${not empty forgotPasswordError}">
                                                <div class="alert alert-danger">${forgotPasswordError}</div>
                                            </c:if>
                                            <p>Vui lòng nhập địa chỉ email của bạn. Chúng tôi sẽ gửi cho bạn một mã để
                                                đặt lại mật khẩu.</p>
                                            <div class="form-group">
                                                <label for="forgot-email">Email</label>
                                                <input type="email" class="form-control" id="forgot-email" name="email"
                                                    placeholder="Nhập email của bạn" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Gửi mã</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Verify Code Modal -->
                        <div class="modal fade" id="verifyCodeModal" tabindex="-1" role="dialog"
                            aria-labelledby="verifyCodeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="verifyCodeModalLabel">Nhập mã xác thực</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form action="<c:url value='/verify-code' />" method="post">
                                        <div class="modal-body">
                                            <c:if test="${not empty verifyCodeError}">
                                                <div class="alert alert-danger">${verifyCodeError}</div>
                                            </c:if>
                                            <p>Mã xác thực đã được gửi đến email của bạn. Vui lòng nhập mã vào ô bên
                                                dưới.</p>
                                            <div class="form-group">
                                                <label for="verification-code">Mã xác thực</label>
                                                <input type="text" class="form-control" id="verification-code"
                                                    name="code" placeholder="Nhập mã xác thực" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Reset Password Modal -->
                        <div class="modal fade" id="resetPasswordModal" tabindex="-1" role="dialog"
                            aria-labelledby="resetPasswordModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="resetPasswordModalLabel">Đặt lại mật khẩu mới</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form action="<c:url value='/reset-password' />" method="post">
                                        <div class="modal-body">
                                            <c:if test="${not empty resetPasswordError}">
                                                <div class="alert alert-danger">${resetPasswordError}</div>
                                            </c:if>
                                            <p>Nhập mật khẩu mới và xác nhận mật khẩu để hoàn tất việc đặt lại.</p>
                                            <div class="form-group">
                                                <label for="password">Mật khẩu mới</label>
                                                <input type="password" class="form-control" id="password"
                                                    name="password" placeholder="Nhập mật khẩu mới" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="confirmPassword">Xác nhận mật khẩu</label>
                                                <input type="password" class="form-control" id="confirmPassword"
                                                    name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Đặt lại mật khẩu</button>
                                        </div>
                                    </form>
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
                <script>
                    $(document).ready(function () {
                        <c:if test="${not empty showVerifyModal and showVerifyModal}">
                            $('#verifyCodeModal').modal('show');
                        </c:if>
                    });
                </script>
                <script>
                    $(document).ready(function () {
                        <c:if test="${not empty showForgotPasswordModal and showForgotPasswordModal}">
                            $('#forgotPasswordModal').modal('show');
                        </c:if>
                    });
                </script>
                <script>
                    $(document).ready(function () {
                        <c:if test="${not empty showResetPasswordModal and showResetPasswordModal}">
                            $('#resetPasswordModal').modal('show');
                        </c:if>
                    });
                </script>
            </body>

            </html>