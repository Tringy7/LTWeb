<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


                    <body>

                        <!-- Spinner Start -->
                        <div id="spinner"
                            class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                        <!-- Spinner End -->


                        <!-- Single Page Header start -->
                        <div class="container-fluid page-header py-5">
                            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Cheackout
                                Page
                            </h1>
                            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                                <li class="breadcrumb-item"><a href="/">Home</a></li>
                                <li class="breadcrumb-item"><a href="/cart">Cart</a></li>
                                <li class="breadcrumb-item active text-white">Cheackout</li>
                            </ol>
                        </div>
                        <!-- Single Page Header End -->

                        <!-- Searvices Start -->
                        <div class="container-fluid px-0">
                            <div class="row g-0">
                                <div class="col-6 col-md-4 col-lg-2 border-start border-end wow fadeInUp"
                                    data-wow-delay="0.1s">
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


                        <!-- Checkout Page Start -->
                        <div class="container-fluid bg-light overflow-hidden py-5">
                            <div class="container py-5">
                                <h1 class="mb-4 wow fadeInUp" data-wow-delay="0.1s">Billing details</h1>
                                <form:form action="/checkout" method="post" modelAttribute="user">

                                    <form:hidden path="cart" />
                                    <div class="row g-5">

                                        <div class="col-md-12 col-lg-6 col-xl-6 wow fadeInUp" data-wow-delay="0.1s">

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-item w-100">
                                                        <label class="form-label my-3">Tên người nhận
                                                            <sup>*</sup></label>
                                                        <form:input path="address.receiverName" type="text"
                                                            class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-item">
                                                <label class="form-label my-3">Địa chỉ người nhận <sup>*</sup></label>
                                                <form:input path="address.receiverAddress" type="text"
                                                    class="form-control" />
                                            </div>
                                            <div class="form-item">
                                                <label class="form-label my-3">Số điện thoại người nhận
                                                    <sup>*</sup></label>
                                                <form:input path="address.receiverPhone" type="tel"
                                                    class="form-control" />
                                            </div>
                                            <div class="form-item">
                                                <label class="form-label my-3">Ghi chú cho người bán</label>
                                                <form:textarea path="address.note" name="text" class="form-control"
                                                    spellcheck="false" cols="30" rows="11" placeholder="Ghi chú" />
                                            </div>

                                        </div>
                                        <div class="col-md-12 col-lg-6 col-xl-6 wow fadeInUp" data-wow-delay="0.3s">
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr class="text-center">
                                                            <th scope="col">Image</th>
                                                            <th scope="col">Name</th>
                                                            <th scope="col">Size</th>
                                                            <th scope="col">Shop</th>
                                                            <th scope="col">Price</th>
                                                            <th scope="col">Quantity</th>
                                                            <th scope="col">Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="7">
                                                                <div style="max-height: 260px; overflow-y: auto;">
                                                                    <c:forEach var="item" items="${cart.cartDetails}">
                                                                        <div class="row text-center mx-0">
                                                                            <div
                                                                                class="col-2 d-flex align-items-center">
                                                                                <img src="/admin/images/product/${item.product.image}"
                                                                                    class="img-fluid rounded"
                                                                                    style="width: 80px; height: 80px;"
                                                                                    alt="">
                                                                            </div>
                                                                            <div class="col-2 py-5">${item.product.name}
                                                                            </div>
                                                                            <div class="col-1 py-5">${item.size}</div>
                                                                            <div class="col-2 py-5">
                                                                                ${item.product.shop.shopName}</div>
                                                                            <div class="col-2 py-5">
                                                                                <fmt:formatNumber
                                                                                    value="${item.product.price}"
                                                                                    type="currency" currencySymbol=""
                                                                                    minFractionDigits="0"
                                                                                    maxFractionDigits="0" />
                                                                                VND
                                                                            </div>
                                                                            <div class="col-1 py-5">${item.quantity}
                                                                            </div>
                                                                            <div class="col-2 py-5">
                                                                                <fmt:formatNumber value="${item.price}"
                                                                                    type="currency" currencySymbol=""
                                                                                    minFractionDigits="0"
                                                                                    maxFractionDigits="0" />
                                                                                VND
                                                                            </div>
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <h5 class="mb-0 me-4">Total:</h5>
                                                <p class="mb-0">
                                                    <fmt:formatNumber value="${user.cart.totalPrice}" type="currency"
                                                        currencySymbol="" minFractionDigits="0" maxFractionDigits="0" />
                                                    VND
                                                </p>
                                            </div>
                                            <div
                                                class="row g-0 text-center align-items-center justify-content-center border-bottom py-2">
                                                <div class="col-12">
                                                    <div class="form-check text-start my-2">
                                                        <input type="radio" class="form-check-input bg-primary border-0"
                                                            checked id="Transfer-1" name="paymentMethod"
                                                            value="Direct Bank Transfer">
                                                        <label class="form-check-label" for="Transfer-1">Direct Bank
                                                            Transfer</label>
                                                    </div>
                                                    <p class="text-start text-dark">Make your payment directly into our
                                                        bank
                                                        account. Please
                                                        use your Order ID as the payment reference. Your order will not
                                                        be
                                                        shipped until the
                                                        funds have cleared in our account.</p>
                                                </div>
                                            </div>
                                            <div
                                                class="row g-4 text-center align-items-center justify-content-center border-bottom py-2">
                                                <div class="col-12">
                                                    <div class="form-check text-start my-2">
                                                        <input type="radio" class="form-check-input bg-primary border-0"
                                                            id="Payments-1" name="paymentMethod" value="Check Payments">
                                                        <label class="form-check-label" for="Payments-1">Check
                                                            Payments</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-2"
                                                data-wow-delay="0.1s">
                                                <div class="col-12">
                                                    <div class="form-check text-start my-2">
                                                        <input type="radio" class="form-check-input bg-primary border-0"
                                                            id="Delivery-1" name="paymentMethod"
                                                            value="Cash On Delivery">
                                                        <label class="form-check-label" for="Delivery-1">Cash On
                                                            Delivery</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-2"
                                                data-wow-delay="0.2s">
                                                <div class="col-12">
                                                    <div class="form-check text-start my-2">
                                                        <input type="radio" class="form-check-input bg-primary border-0"
                                                            id="Paypal-1" name="paymentMethod" value="Paypal">
                                                        <label class="form-check-label" for="Paypal-1">Paypal</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div
                                                class="row g-4 text-center align-items-center justify-content-center pt-4">
                                                <button type="submit"
                                                    class="btn btn-primary border-secondary py-3 px-4 text-uppercase w-100 text-primary">Place
                                                    Order</button>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                            <!-- Checkout Page End -->

                            <!-- Back to Top -->
                            <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i
                                    class="fa fa-arrow-up"></i></a>


                            <!-- JavaScript Libraries -->
                            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                            <script
                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                            <script src="/client/lib/wow/wow.min.js"></script>
                            <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>


                            <!-- Template Javascript -->
                            <script src="/client/js/main.js"></script>
                    </body>

                    </html>