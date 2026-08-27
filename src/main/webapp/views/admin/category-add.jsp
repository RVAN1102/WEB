<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Mới</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 20px; }
        .card { background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        input[type="text"], input[type="file"] { width: 100%; padding: 10px; border: 1px solid #ced4da; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
        .btn-submit:hover { background-color: #218838; }
        .btn-back { display: inline-block; margin-top: 15px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
    <%@ include file="/common/web/topbar.jsp" %>
    <div class="card">
        <h2>Thêm Danh Mục Mới</h2>
        <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Tên danh mục:</label>
                <input type="text" name="categoryname" required>
            </div>
            <div class="form-group">
                <label>Link ảnh (nếu dùng link ngoài):</label>
                <input type="text" name="images">
            </div>
            <div class="form-group">
                <label>Hoặc Upload ảnh từ máy tính:</label>
                <input type="file" name="images1" accept="image/*">
            </div>
            <div class="form-group">
                <label>Trạng thái:</label>
                <input type="radio" name="status" value="1" checked> Hoạt động
                <input type="radio" name="status" value="0"> Khóa
            </div>
            <button type="submit" class="btn-submit">Lưu Danh Mục</button>
        </form>
        <a href="<c:url value='/admin/categories'/>" class="btn-back">← Quay lại danh sách</a>
    </div>
</body>
</html>