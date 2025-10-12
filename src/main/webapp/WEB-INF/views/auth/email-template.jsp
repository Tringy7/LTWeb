<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Xác nhận mã</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            padding: 20px;
            border: 1px solid #ddd;
        }

        .code {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Yêu cầu đặt lại mật khẩu</h2>
        <p>Xin chào,</p>
        <p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Vui lòng sử dụng mã xác thực dưới đây
            để tiếp tục.</p>
        <p>Mã xác thực của bạn là:</p>
        <p class="code">${code}</p>
        <p>Mã này sẽ hết hạn sau 5 phút. Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>
        <p>Trân trọng,<br>Đội ngũ hỗ trợ.</p>
    </div>
</body>

</html>