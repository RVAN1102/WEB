<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Cá Nhân</title>
    <style>
        .profile-box {
            max-width: 500px;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            font-family: Arial, sans-serif;
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
        .form-group input[type="text"], 
        .form-group input[type="file"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .avatar-preview { text-align: center; margin-bottom: 15px; }
        .avatar-preview img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #007bff;
        }
        .btn-update {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-update:hover { background-color: #0056b3; }
        .success-msg {
            color: #155724;
            background-color: #d4edda;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="profile-box">
        <h2>Cập Nhật Hồ Sơ</h2>

        <c:if test="${not empty message}">
            <div class="success-msg">${message}</div>
        </c:if>

        <div class="avatar-preview">
            <c:choose>
                <c:when test="${empty user.images}">
                    <img id="avatarImage" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='120' height='120' viewBox='0 0 120 120'><rect width='120' height='120' fill='%23e9ecef'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='12' fill='%236c757d'>Chưa có ảnh</text></svg>" alt="Avatar" />
                </c:when>
                <c:when test="${user.images.startsWith('http')}">
                    <img id="avatarImage" src="${user.images}" alt="Avatar" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image?fname=${user.images}" var="imgUrl"/>
                    <img id="avatarImage" src="${imgUrl}" alt="Avatar" />
                </c:otherwise>
            </c:choose>
        </div>

        <form action="<c:url value='/profile/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${user.id}"/>

            <div class="form-group">
                <label>Tên đăng nhập:</label>
                <input type="text" value="${user.username}" disabled="disabled" style="background: #f1f3f5;"/>
            </div>

            <div class="form-group">
                <label>Họ và tên (Fullname):</label>
                <input type="text" name="fullname" value="${user.fullname}" required/>
            </div>

            <div class="form-group">
                <label>Số điện thoại (Phone):</label>
                <input type="text" name="phone" value="${user.phone}"/>
            </div>

            <div class="form-group">
                <label>Ảnh đại diện (Chọn file mới):</label>
                <input type="file" name="images" id="imageInput" accept="image/*" onchange="previewImage(event)"/>
            </div>

            <button type="submit" class="btn-update" style="margin-top: 15px;">Lưu Thay Đổi</button>
        </form>
    </div>

    <script>
        function previewImage(event) {
            var file = event.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var img = document.getElementById('avatarImage');
                    if (img) {
                        img.src = e.target.result;
                    }
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>