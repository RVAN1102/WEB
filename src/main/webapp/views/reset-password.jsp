<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - Shopping MVC</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
        }
        .auth-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 440px;
            padding: 35px 30px;
            box-sizing: border-box;
            text-align: center;
        }
        .auth-icon {
            width: 60px;
            height: 60px;
            line-height: 60px;
            border-radius: 50%;
            background: #e8f5e9;
            color: #28a745;
            font-size: 28px;
            margin: 0 auto 15px auto;
        }
        h2 {
            margin: 0 0 8px 0;
            color: #212529;
            font-size: 24px;
        }
        p.subtitle {
            color: #6c757d;
            font-size: 14px;
            margin: 0 0 25px 0;
            line-height: 1.5;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: left;
        }
        .form-group {
            margin-bottom: 18px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 14px;
            color: #495057;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #0d6efd;
            outline: none;
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 20px !important;
            font-weight: bold;
            text-align: center;
        }
        .btn-submit {
            width: 100%;
            background: #28a745;
            color: #ffffff;
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background: #218838;
        }
        .action-links {
            margin-top: 20px;
            font-size: 14px;
        }
        .action-links a {
            color: #0d6efd;
            text-decoration: none;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-icon">🛡️</div>
        <h2>Đặt Lại Mật Khẩu</h2>
        <p class="subtitle">Nhập mã OTP đã nhận qua email và mật khẩu mới của bạn.</p>

        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>

        <form action="<c:url value='/reset-password'/>" method="post">
            <div class="form-group">
                <label for="username">Tên tài khoản:</label>
                <input type="text" id="username" name="username" value="${username}" required 
                       <c:if test="${not empty username}">readonly style="background-color: #f8f9fa;"</c:if>/>
            </div>

            <div class="form-group">
                <label for="otp">Mã xác thực OTP:</label>
                <input type="text" id="otp" name="otp" class="otp-input" maxlength="6" placeholder="------" required autofocus />
            </div>

            <div class="form-group">
                <label for="new_password">Mật khẩu mới:</label>
                <input type="password" id="new_password" name="new_password" placeholder="Nhập mật khẩu mới..." required />
            </div>

            <div class="form-group">
                <label for="confirm_password">Xác nhận mật khẩu mới:</label>
                <input type="password" id="confirm_password" name="confirm_password" placeholder="Nhập lại mật khẩu mới..." required />
            </div>

            <button type="submit" class="btn-submit">Xác Nhận Đổi Mật Khẩu</button>
        </form>

        <div class="action-links">
            <p><a href="<c:url value='/login'/>">← Quay lại Đăng nhập</a></p>
        </div>
    </div>
</body>
</html>
