<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Danh Mục</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 20px; }
        .card { background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        input[type="text"], input[type="file"] { width: 100%; padding: 10px; border: 1px solid #ced4da; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
        .btn-submit:hover { background-color: #0069d9; }
        .btn-back { display: inline-block; margin-top: 15px; color: #007bff; text-decoration: none; }
        .img-preview { width: 150px; height: auto; border: 1px solid #ddd; margin-bottom: 10px; border-radius: 4px; }
    </style>
</head>
<body>
    <%@ include file="/common/web/topbar.jsp" %>
    <div class="card">
        <h2>Sửa Danh Mục</h2>
        <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryid" value="${cate.categoryid}">
            
            <div class="form-group">
                <label>Tên danh mục:</label>
                <input type="text" name="categoryname" value="${cate.categoryname}" required>
            </div>
            <div class="form-group">
                <label>Ảnh hiện tại:</label><br>
                <c:choose>
                    <c:when test="${cate.images.startsWith('http')}">
                        <img class="img-preview" src="${cate.images}">
                    </c:when>
                    <c:otherwise>
                        <img class="img-preview" src="<c:url value='/image?fname=${cate.images}'/>">
                    </c:otherwise>
                </c:choose>
                <input type="hidden" name="images" value="${cate.images}">
            </div>
            <div class="form-group">
                <label>Thay đổi ảnh (Upload file mới):</label>
                <input type="file" name="images1" accept="image/*">
            </div>
            <div class="form-group">
                <label>Trạng thái:</label>
                <input type="radio" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}> Hoạt động
                <input type="radio" name="status" value="0" ${cate.status == 0 ? 'checked' : ''}> Khóa
            </div>
            <button type="submit" class="btn-submit">Cập nhật Danh Mục</button>
        </form>
        <a href="<c:url value='/admin/categories'/>" class="btn-back">← Quay lại danh sách</a>
    </div>
</body>
</html>