<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng ký</title>
<style>
    body { font-family: Arial, sans-serif; margin: 50px; }
    .form-box { width: 350px; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
    .alert { color: red; margin-bottom: 10px; }
    .input-group { margin-bottom: 12px; }
    .input-group label { display: block; }
    .input-group input { width: 95%; padding: 8px; }
    .btn { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; cursor: pointer; }
</style>
</head>
<body>
<div class="form-box">
    <h2>Tạo tài khoản mới</h2>
    <c:if test="${alert != null}">
        <div class="alert">${alert}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="input-group">
            <label>Tài khoản</label>
            <input type="text" name="username" required>
        </div>
        <div class="input-group">
            <label>Họ và tên</label>
            <input type="text" name="fullname" required>
        </div>
        <div class="input-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>
        <div class="input-group">
            <label>Số điện thoại</label>
            <input type="text" name="phone" required>
        </div>
        <div class="input-group">
            <label>Mật khẩu</label>
            <input type="password" name="password" required>
        </div>
        <button type="submit" class="btn">Tạo tài khoản</button>
    </form>
    <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
</div>
</body>
</html>