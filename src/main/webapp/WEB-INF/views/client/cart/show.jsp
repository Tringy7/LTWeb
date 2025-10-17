<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
                            style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">Cart Page</h1>
                        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s"
                            style="visibility: visible; animation-delay: 0.3s; animation-name: fadeInUp;">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="/shop">Shop</a></li>
                            <li class="breadcrumb-item active text-white">Cart Page</li>
                        </ol>
                    </div>
                    <!-- Single Page Header End -->

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <form action="/cart" method="post">
                            <input type="hidden" name="id" value="${cart.id}" />
                            <div class="container py-5">
                                <!-- Success/Error Messages -->
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fa fa-check-circle me-2"></i>${success}
                                        <c:if test="${not empty appliedVoucherCode}">
                                            <strong> Mã: ${appliedVoucherCode}</strong>
                                        </c:if>
                                        <c:if test="${not empty discountPercent}">
                                            <span> - Giảm <strong>${discountPercent}%</strong></span>
                                        </c:if>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fa fa-exclamation-circle me-2"></i>${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Image</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Size</th>
                                                <th scope="col">Shop</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Handle</th>
                                            </tr>
                                        </thead>
                                        <c:choose>
                                            <c:when
                                                test="${not empty cart.cartDetails and fn:length(cart.cartDetails) > 0}">
                                                <tbody>
                                                    <c:forEach var="item" items="${cart.cartDetails}"
                                                        varStatus="status">
                                                        <form:hidden path="cart.cartDetails[${i.index}].product.id"
                                                            value="${item.product.id}" />
                                                        <form:hidden path="cart.cartDetails[${i.index}].quantity"
                                                            value="${item.quantity}" />
                                                        <form:hidden path="cart.cartDetails[${i.index}].price"
                                                            value="${item.price}" />
                                                        <form:hidden path="cart.cartDetails[${i.index}].size"
                                                            value="${item.size}" />
                                                        <input type="hidden" name="cartDetails[${status.index}].id"
                                                            value="${item.id}" />
                                                        <tr class="cart-item-row">
                                                            <th scope="row">
                                                                <div class="d-flex align-items-center">
                                                                    <img src="/admin/images/product/${item.product.image}"
                                                                        class="img-fluid me-5 rounded"
                                                                        style="width: 80px; height: 80px;" alt="">
                                                                </div>
                                                            </th>
                                                            <td>
                                                                <p class="mb-0 mt-4">${item.product.name}</p>
                                                            </td>
                                                            <td>
                                                                <p class="mb-0 mt-4">${item.size}</p>
                                                            </td>
                                                            <td>
                                                                <p class="mb-0 mt-4">${item.product.shop.shopName}</p>
                                                            </td>
                                                            <td>
                                                                <div class="mb-0 mt-4 item-price"
                                                                    data-price="${item.product.price}"
                                                                    data-discount="${not empty item.voucher ? item.voucher.discountPercent : 0}">
                                                                    <c:if test="${not empty item.voucher}">
                                                                        <c:set var="discountedUnitPrice"
                                                                            value="${item.product.price * (1 - item.voucher.discountPercent / 100)}" />
                                                                        <del>
                                                                            <fmt:formatNumber
                                                                                value="${item.product.price}"
                                                                                type="currency" currencySymbol=""
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </del>
                                                                        <p class="mb-0" style="color: red;">
                                                                            <fmt:formatNumber
                                                                                value="${discountedUnitPrice}"
                                                                                type="currency" currencySymbol=""
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </p>
                                                                    </c:if>
                                                                    <c:if test="${empty item.voucher}">
                                                                        <p class="mb-0">
                                                                            <fmt:formatNumber
                                                                                value="${item.product.price}"
                                                                                type="currency" currencySymbol=""
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </p>
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group quantity mt-4"
                                                                    style="width: 100px;">
                                                                    <div class="input-group-btn">
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                            <i class="fa fa-minus"></i>
                                                                        </button>
                                                                    </div>
                                                                    <input type="text"
                                                                        class="form-control form-control-sm text-center border-0"
                                                                        min="1" value="${item.quantity}"
                                                                        name="cartDetails[${status.index}].quantity">
                                                                    <div class="input-group-btn">
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                            <i class="fa fa-plus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="mb-0 mt-4 item-total"
                                                                    data-total="${item.price}">
                                                                    <c:if test="${not empty item.voucher}">
                                                                        <c:set var="discountedTotalPrice"
                                                                            value="${item.price * (1 - item.voucher.discountPercent / 100)}" />
                                                                        <del>
                                                                            <fmt:formatNumber value="${item.price}"
                                                                                type="currency" currencySymbol=""
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </del>
                                                                        <p class="mb-0" style="color: red;">
                                                                            <fmt:formatNumber
                                                                                value="${discountedTotalPrice}"
                                                                                type="currency" currencySymbol=""
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </p>
                                                                    </c:if>
                                                                    <c:if test="${empty item.voucher}">
                                                                        <p class="mb-0">
                                                                            <fmt:formatNumber value="${item.price}"
                                                                                type="currency" currencySymbol=""
                                                                                minFractionDigits="0"
                                                                                maxFractionDigits="0" /> VND
                                                                        </p>
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                            <td class="mt-4">
                                                                <button type="submit"
                                                                    formaction="/cart/delete/${item.id}"
                                                                    formmethod="post"
                                                                    class="btn btn-md rounded-circle bg-light border mt-4">
                                                                    <i class="fa fa-times text-danger"></i> </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </c:when>
                                            <c:otherwise>
                                                <tbody>
                                                    <tr>
                                                        <td colspan="8" class="text-center py-5">
                                                            <h4>Giỏ hàng của bạn đang trống!</h4>
                                                            <a href="/shop"
                                                                class="btn btn-primary rounded-pill px-4 py-2 mt-3">Tiếp
                                                                tục mua sắm</a>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                                <div class="mt-5 d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <input type="text" class="border-0 border-bottom rounded me-3 py-3 mb-4"
                                            name="voucherCode" placeholder="Coupon Code">
                                        <button class="btn btn-primary rounded-pill px-4 py-3 me-2"
                                            formaction="/cart/apply-voucher" formmethod="post" type="submit">
                                            <i class="fa fa-check me-2"></i>Áp dụng Voucher
                                        </button>
                                        <button class="btn btn-danger rounded-pill px-4 py-3 me-2"
                                            formaction="/cart/remove-voucher" formmethod="post" type="submit">
                                            <i class="fa fa-times me-2"></i>Hủy Voucher
                                        </button>
                                        <a href="/voucher" class="btn btn-primary rounded-pill px-4 py-3 me-2">
                                            <i class="fa fa-ticket me-2"></i>Xem Voucher
                                        </a>
                                    </div>
                                </div>
                                <div class="row g-4 justify-content-end">
                                    <div class="col-8"></div>
                                    <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                                        <div class="bg-light rounded">
                                            <div class="p-4">
                                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span>
                                                </h1>
                                                <hr>
                                                <div class="d-flex justify-content-between mb-4">
                                                    <h5 class="mb-0 me-4">Total:</h5>
                                                    <p class="mb-0" id="cart-subtotal">
                                                        <fmt:formatNumber value="${cart.totalPrice}" type="currency"
                                                            currencySymbol="" minFractionDigits="0"
                                                            maxFractionDigits="0" />
                                                        VND
                                                    </p>
                                                </div>
                                                <hr>
                                            </div>
                                            <button
                                                class="btn btn-primary rounded-pill px-4 py-3 text-uppercase mb-4 ms-4"
                                                type="submit">Proceed Checkout</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- Cart Page End -->
                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/wow/wow.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>


                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Function to format number as currency
                            function formatCurrency(number) {
                                return new Intl.NumberFormat('vi-VN').format(number) + ' VND';
                            }

                            // Function to update the item total for a specific row
                            function updateItemTotal(row) {
                                const priceElement = row.querySelector('.item-price');
                                const price = parseFloat(priceElement.dataset.price);
                                const discount = parseFloat(priceElement.dataset.discount) || 0;
                                const quantityInput = row.querySelector('.quantity input');
                                let quantity = parseInt(quantityInput.value) || 1;

                                if (quantity < 1) {
                                    quantity = 1;
                                    quantityInput.value = 1;
                                }

                                // Calculate discounted price
                                const discountedPrice = price * (1 - discount / 100);
                                const originalTotal = price * quantity;
                                const newTotal = discountedPrice * quantity;

                                // Update the total display
                                const totalElement = row.querySelector('.item-total');

                                if (discount > 0) {
                                    // Has voucher - show strikethrough old price and new price
                                    const delElement = document.createElement('del');
                                    delElement.textContent = formatCurrency(originalTotal);

                                    const priceElement = document.createElement('p');
                                    priceElement.className = 'mb-0';
                                    priceElement.style.color = 'red';
                                    priceElement.textContent = formatCurrency(newTotal);

                                    totalElement.innerHTML = '';
                                    totalElement.appendChild(delElement);
                                    totalElement.appendChild(priceElement);
                                } else {
                                    // No voucher - show regular price
                                    const priceElement = document.createElement('p');
                                    priceElement.className = 'mb-0';
                                    priceElement.textContent = formatCurrency(newTotal);

                                    totalElement.innerHTML = '';
                                    totalElement.appendChild(priceElement);
                                }
                            }

                            // Function to update the total cart summary
                            function updateCartTotal() {
                                let subtotal = 0;
                                document.querySelectorAll('.cart-item-row').forEach(function (row) {
                                    const priceElement = row.querySelector('.item-price');
                                    const price = parseFloat(priceElement.dataset.price);
                                    const discount = parseFloat(priceElement.dataset.discount) || 0;
                                    const quantity = parseInt(row.querySelector('.quantity input').value);

                                    // Calculate with discount
                                    const discountedPrice = price * (1 - discount / 100);
                                    const itemTotal = discountedPrice * quantity;

                                    subtotal += itemTotal;
                                });

                                const shippingCost = 0; // Thay đổi nếu cần
                                const total = subtotal + shippingCost;
                                // Update the subtotal displayed on the client side.
                                document.getElementById('cart-subtotal').textContent = formatCurrency(total);

                                // Disable the checkout button if the cart is empty
                                const checkoutButton = document.querySelector('.btn-primary[type="submit"]');
                                if (subtotal === 0) {
                                    checkoutButton.disabled = true;
                                    checkoutButton.classList.add('disabled');
                                } else {
                                    checkoutButton.disabled = false;
                                    checkoutButton.classList.remove('disabled');
                                }
                            }

                            // Remove any existing jQuery click handlers from the template's main.js
                            $('.quantity button').off('click');

                            // Event listener for all quantity buttons (plus and minus)
                            document.querySelectorAll('.quantity button').forEach(button => {
                                button.addEventListener('click', function (e) {
                                    const row = this.closest('.cart-item-row');
                                    const quantityInput = row.querySelector('input');
                                    let quantity = parseInt(quantityInput.value) || 1;

                                    if (this.classList.contains('btn-plus')) {
                                        quantity++;
                                    } else if (this.classList.contains('btn-minus')) {
                                        if (quantity > 1) {
                                            quantity--;
                                        }
                                    }

                                    quantityInput.value = quantity;
                                    updateItemTotal(row);
                                    updateCartTotal();
                                });
                            });

                            // Event listener for manual input changes on quantity fields
                            document.querySelectorAll('.quantity input').forEach(input => {
                                input.addEventListener('input', function () {
                                    this.value = this.value.replace(/[^0-9]/g, '');
                                });

                                input.addEventListener('change', function () {
                                    const row = this.closest('.cart-item-row');
                                    updateItemTotal(row);
                                    updateCartTotal();
                                });
                            });

                            // Initial calculation in case the page is loaded with items
                            if (document.querySelectorAll('.cart-item-row').length > 0) {
                                // Initial calculation on page load
                                updateCartTotal();
                            } else {
                                updateCartTotal();
                            }
                        });

                        // Event listener for delete buttons
                        document.querySelectorAll('.btn-delete').forEach(button => {
                            button.addEventListener('click', function () {
                                const cartDetailId = this.dataset.id;
                                const row = this.closest('.cart-item-row');

                                if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                                    fetch(`/cart/delete/${cartDetailId}`, {
                                        method: 'POST',
                                    }).then(response => {
                                        if (response.ok) {
                                            row.remove();
                                            updateCartTotal();
                                            if (document.querySelectorAll('.cart-item-row').length === 0) {
                                                window.location.reload();
                                            }
                                        } else {
                                            alert('Có lỗi xảy ra, không thể xóa sản phẩm.');
                                        }
                                    }).catch(error => console.error('Error:', error));
                                }
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


                </body>