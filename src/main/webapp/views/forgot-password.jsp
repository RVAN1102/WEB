<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Shopping MVC</title>
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
            background: #fff3cd;
            color: #ffc107;
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
        }
        input[type="text"]:focus {
            border-color: #0d6efd;
            outline: none;
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
        <div class="auth-icon">🔑</div>
        <h2>Quên Mật Khẩu</h2>
        <p class="subtitle">Nhập email hoặc tên tài khoản của bạn. Chúng tôi sẽ gửi mã OTP xác nhận về email đã đăng ký.</p>

        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>

        <form action="<c:url value='/forgot-password'/>" method="post">
            <div class="form-group">
                <label for="account_input">Email hoặc Tên tài khoản:</label>
                <input type="text" id="account_input" name="account_input" placeholder="Nhập email hoặc username..." required autofocus />
            </div>

            <button type="submit" class="btn-submit">Gửi Mã Xác Thực OTP</button>
        </form>

        <div class="action-links">
            <p><a href="<c:url value='/login'/>">← Quay lại Đăng nhập</a></p>
        </div>
    </div>
</body>
</html>
