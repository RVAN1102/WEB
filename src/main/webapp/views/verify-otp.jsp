<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - Kích Hoạt Tài Khoản</title>
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
        .otp-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 440px;
            padding: 35px 30px;
            box-sizing: border-box;
            text-align: center;
        }
        .otp-icon {
            width: 60px;
            height: 60px;
            line-height: 60px;
            border-radius: 50%;
            background: #e3f2fd;
            color: #0d6efd;
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
        .alert-success {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: left;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 14px;
            color: #495057;
        }
        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }
        input[type="text"]:focus {
            border-color: #0d6efd;
            outline: none;
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 22px !important;
            font-weight: bold;
            text-align: center;
        }
        .btn-submit {
            width: 100%;
            background: #0d6efd;
            color: #ffffff;
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover {
            background: #0b5ed7;
        }
        .action-links {
            margin-top: 20px;
            font-size: 14px;
            color: #6c757d;
        }
        .action-links a {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="otp-card">
        <div class="otp-icon">✉️</div>
        <h2>Kích Hoạt Tài Khoản</h2>
        <p class="subtitle">Vui lòng nhập mã OTP 6 chữ số đã được gửi tới email của bạn để hoàn tất kích hoạt.</p>

        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert-success">${message}</div>
        </c:if>

        <form action="<c:url value='/verify-otp'/>" method="post">
            <div class="form-group">
                <label for="username">Tên tài khoản:</label>
                <input type="text" id="username" name="username" value="${username}" required 
                       <c:if test="${not empty username}">readonly style="background-color: #f8f9fa;"</c:if>/>
            </div>

            <div class="form-group">
                <label for="otp">Mã xác thực OTP:</label>
                <input type="text" id="otp" name="otp" class="otp-input" maxlength="6" placeholder="------" required autofocus />
            </div>

            <button type="submit" class="btn-submit">Xác Nhận Kích Hoạt</button>
        </form>

        <div class="action-links">
            <p>Không nhận được mã? <a href="<c:url value='/resend-otp?username=${username}'/>">Gửi lại mã OTP</a></p>
            <p><a href="<c:url value='/login'/>">← Quay lại Đăng nhập</a></p>
        </div>
    </div>
</body>
</html>
