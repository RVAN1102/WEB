<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<style>
    body { font-family: Arial, sans-serif; margin: 50px; }
    .form-box { width: 320px; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
    .alert { color: red; margin-bottom: 10px; }
    .input-group { margin-bottom: 15px; }
    .input-group label { display: block; }
    .input-group input { width: 95%; padding: 8px; }
    .btn { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; cursor: pointer; }
</style>
</head>
<body>
<div class="form-box">
    <h2>Đăng Nhập Vào Hệ Thống</h2>
    <c:if test="${alert != null}">
        <div class="alert">${alert}</div>
    </c:if>
    <c:if test="${message != null}">
        <div style="color: green; margin-bottom: 10px;">${message}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="input-group">
            <label>Tài khoản</label>
            <input type="text" name="username" placeholder="Nhập tên đăng nhập" required>
        </div>
        <div class="input-group">
            <label>Mật khẩu</label>
            <input type="password" name="password" placeholder="Nhập mật khẩu" required>
        </div>
        <div class="input-group" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <input type="checkbox" name="remember" style="width: auto;"> Nhớ tôi
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/forgot-password" style="font-size: 13px; color: #007bff; text-decoration: none;">Quên mật khẩu?</a>
            </div>
        </div>
        <button type="submit" class="btn">Đăng nhập</button>
    </form>
    <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký</a></p>
</div>
</body>
</html>