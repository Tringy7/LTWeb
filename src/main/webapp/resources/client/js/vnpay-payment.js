// VNPAY Payment Handler
document.addEventListener('DOMContentLoaded', function () {
    const vnpayButton = document.getElementById('vnpayButton');
    
    if (vnpayButton) {
        vnpayButton.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Lấy orderId và totalPrice từ data attributes của button
            const orderId = vnpayButton.getAttribute('data-order-id');
            const totalPriceStr = vnpayButton.getAttribute('data-total-price');
            
            // Chuyển đổi totalPrice từ string thành integer (loại bỏ phần thập phân)
            const totalPrice = Math.round(parseFloat(totalPriceStr));
            
            console.log('Order ID:', orderId);
            console.log('Total Price String:', totalPriceStr);
            console.log('Total Price (integer):', totalPrice);
            
            if (!orderId || !totalPrice || totalPrice === 0) {
                alert('Không tìm thấy thông tin đơn hàng hoặc giá trị không hợp lệ!');
                return;
            }
            
            // Show loading
            vnpayButton.disabled = true;
            vnpayButton.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang xử lý...';
            
            // Create payment URL
            const paymentUrl = '/payment/create-payment?amount=' + totalPrice + '&orderId=' + orderId;
            
            // Call API to get VNPAY payment URL
            fetch(paymentUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text();
                })
                .then(url => {
                    console.log('Payment URL:', url);
                    // Redirect to VNPAY payment page
                    window.location.href = url;
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi tạo thanh toán! Vui lòng thử lại.');
                    // Reset button
                    vnpayButton.disabled = false;
                    vnpayButton.innerHTML = '<i class="fas fa-credit-card me-1"></i>Thanh toán VNPAY';
                });
        });
    }
});
