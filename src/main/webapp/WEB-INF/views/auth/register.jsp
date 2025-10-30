<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Đăng ký</title>
        <!-- base:css -->
        <link rel="stylesheet" href="<c:url value='/admin/vendors/typicons.font/font/typicons.css'/>">
        <link rel="stylesheet" href="<c:url value='/admin/vendors/css/vendor.bundle.base.css'/>">
        <!-- endinject -->
        <!-- inject:css -->
        <link rel="stylesheet" href="<c:url value='/admin/css/vertical-layout-light/style.css'/>">
        <!-- endinject -->
        <link rel="shortcut icon" href="<c:url value='/admin/images/favicon.png'/>" />
      </head>

      <body>
        <div class="container-scroller">
          <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="content-wrapper d-flex align-items-center auth px-0">
              <div class="row w-100 mx-0">
                <div class="col-lg-4 mx-auto">
                  <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                    <div class="brand-logo">
                      <!-- <img src="<c:url value='/admin/images/logo.svg'/>" alt="logo"> -->
                    </div>
                    <h4>Bạn là người mới?</h4>
                    <h6 class="font-weight-light">Đăng ký rất dễ dàng. Chỉ mất vài bước.</h6>
                    <form:form action="/register" method="POST" modelAttribute="newUser" class="pt-3">
                      <c:set var="confirmPasswordError">
                        <form:errors path="confirmPassword" />
                      </c:set>
                      <c:set var="fullNameError">
                        <form:errors path="fullName" />
                      </c:set>
                      <c:set var="passwordError">
                        <form:errors path="password" />
                      </c:set>
                      <c:set var="emailError">
                        <form:errors path="email" />
                      </c:set>
                      <div class="form-group">
                        <form:input path="fullName" type="text"
                          class="form-control form-control-lg ${not empty fullNameError ? 'is-invalid' : ''}"
                          id="exampleInputUsername1" placeholder="Họ và tên" />
                        <form:errors path="fullName" cssClass="invalid-feedback" />
                      </div>
                      <div class="form-group">
                        <form:input path="email" type="email"
                          class="form-control form-control-lg ${not empty emailError ? 'is-invalid' : ''}"
                          id="exampleInputEmail1" placeholder="Email" />
                        <form:errors path="email" cssClass="invalid-feedback" />
                      </div>
                      <div class="form-group">
                        <form:input path="password" type="password"
                          class="form-control form-control-lg ${not empty passwordError ? 'is-invalid' : ''}"
                          id="exampleInputPassword1" placeholder="Mật khẩu" />
                        <form:errors path="password" cssClass="invalid-feedback" />
                      </div>
                      <div class="form-group">
                        <form:input path="confirmPassword" type="password"
                          class="form-control form-control-lg ${not empty confirmPasswordError ? 'is-invalid' : ''}"
                          id="confirmexampleInputPassword1" placeholder="Xác nhận mật khẩu" />
                        <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                      </div>
                      <div class="mt-3">
                        <button class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
                          type="submit">ĐĂNG KÝ</button>
                      </div>
                      <div class="text-center mt-4 font-weight-light">
                        Đã có tài khoản? <a href="/login" class="text-primary">Đăng nhập</a>
                      </div>
                    </form:form>
                  </div>
                </div>
              </div>
            </div>
            <!-- content-wrapper ends -->
          </div>
          <!-- page-body-wrapper ends -->
        </div>
        <!-- container-scroller -->
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