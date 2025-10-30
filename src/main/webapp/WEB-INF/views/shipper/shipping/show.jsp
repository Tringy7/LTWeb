<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Giao Hàng</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-gray-100 font-sans">

            <div class="container mx-auto p-6 grid grid-cols-12 gap-6">

                <!-- Bảng bên trái: Danh sách đơn hàng -->
                <div class="col-span-7">
                    <h3 class="text-lg font-semibold mb-2">Đơn hàng đang giao</h3>
                    <div class="space-y-4">
                        <c:forEach var="detail" items="${orders}">
                            <a href="${pageContext.request.contextPath}/shipper/shipping/detail/${detail.id}"
                                class="no-underline hover:no-underline block">
                                <div
                                    class="bg-white p-4 rounded-lg shadow flex justify-between items-center cursor-pointer hover:bg-green-50 hover:border hover:border-orange-400 transition-all duration-200">
                                    <div class="flex items-center space-x-4">
                                        <div
                                            class="w-10 h-10 bg-green-200 rounded-full flex items-center justify-center text-green-700 font-bold">
                                            ${detail.id}
                                        </div>
                                        <div>
                                            <p class="font-semibold">Đơn hàng #${detail.id}</p>
                                            <p class="text-sm text-gray-500">Kho: ${detail.carrier.area}</p>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <p class="text-gray-700">${today}</p>
                                        <span class="text-green-500 font-semibold">Đang vận chuyển</span>
                                    </div>
                                    <div class="text-right font-semibold">${detail.finalPrice} VND</div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>


                <!-- Bảng bên phải: Thông tin giao hàng & bản đồ -->
                <div class="col-span-5 space-y-4">
                    <div class="bg-white p-4 rounded-lg shadow">
                        <h4 class="font-semibold mb-4">Bản đồ</h4>

                        <!-- Bản đồ Google Maps hiển thị đường đi -->
                        <div class="h-64 rounded overflow-hidden mb-4">
                            <iframe class="rounded w-full h-full"
                                src="https://www.google.com/maps/embed?pb=!1m28!1m12!1m3!1d3919.648!2d106.757!3d10.859!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m13!3e0!4m5!1s0x317527ad12345678%3A0xabcdef1234567890!2s%C4%90.%20s%E1%BB%91%2010%2C%20D%C4%A9%20An%2C%20Th%C3%A0nh%20ph%E1%BB%91%20H%E1%BB%93%20Ch%C3%AD%20Minh!3m2!1d10.849995!2d106.765547!4m5!1s0x317528abcd987654%3A0x123456abcdef!2s01%20%C4%90.%20V%C3%B5%20V%C4%83n%20Ng%C3%A2n%2C%20Linh%20Chi%E1%BB%81u%2C%20Th%E1%BB%A7%20%C4%90%E1%BB%A9c%2C%20TP.%20H%E1%BB%93%20Ch%C3%AD%20Minh!3m2!1d10.8505!2d106.7712!5e0!3m2!1svi!2sus!4v1760612345678!5m2!1svi!2sus"
                                loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>

                        <!-- Thông tin người gửi và người nhận -->
                        <div class="bg-gray-50 p-3 rounded">
                            <c:choose>
                                <c:when test="${not empty selectedOrder}">
                                    <p class="font-semibold text-gray-700">Kho hàng:</p>
                                    <p class="text-gray-500 text-sm">${selectedOrder.carrier.area}</p>

                                    <p class="font-semibold text-gray-700 mt-2">Địa chỉ người nhận:</p>
                                    <p class="text-gray-500 text-sm">${selectedOrder.address.receiverAddress}</p>

                                    <div class="mt-3 flex justify-between items-center">
                                        <p class="font-semibold text-gray-700">Tiền thu:</p>
                                        <p class="font-bold">${selectedOrder.finalPrice} VND</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-gray-500 italic">Hãy chọn một đơn hàng ở bảng bên trái để xem chi
                                        tiết.</p>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not empty selectedOrder}">
                                <a href="${pageContext.request.contextPath}/shipper/shipping/complete/${selectedOrder.id}"
                                    class="block w-full mt-3 bg-green-700 text-white py-2 rounded-lg font-semibold text-center 
                                          transition-all duration-200 hover:bg-green-800 hover:scale-[1.02]">
                                    Xác nhận giao hàng thành công
                                </a>
                            </c:if>
                        </div>

                    </div>
                </div>

            </div>

        </body>

        </html>