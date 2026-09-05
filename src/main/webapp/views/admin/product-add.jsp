<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm Mới</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 20px; }
        .card { background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 650px; margin: auto; }
        .form-group { margin-bottom: 18px; }
        label { font-weight: 600; display: block; margin-bottom: 6px; color: #333; }
        input[type="text"], input[type="number"], select, textarea, input[type="file"] {
            width: 100%; padding: 10px 12px; border: 1px solid #ced4da; border-radius: 5px; box-sizing: border-box; font-size: 14px;
        }
        textarea { resize: vertical; height: 100px; }
        .form-row { display: flex; gap: 15px; }
        .form-col { flex: 1; }
        .btn-submit { background-color: #28a745; color: white; padding: 12px 24px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; font-size: 15px; }
        .btn-submit:hover { background-color: #218838; }
        .btn-back { display: inline-block; margin-top: 15px; color: #007bff; text-decoration: none; font-weight: 500; }
        .radio-group { display: flex; gap: 20px; align-items: center; margin-top: 6px; }
    </style>
</head>
<body>
    <%@ include file="/common/web/topbar.jsp" %>
    <div class="card">
        <h2 style="margin-top: 0; margin-bottom: 20px; color: #2c3e50;">Thêm Sản Phẩm Mới (JPA)</h2>
        <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Tên sản phẩm (*):</label>
                <input type="text" name="productName" placeholder="Nhập tên sản phẩm..." required>
            </div>

            <div class="form-group">
                <label>Danh mục (*):</label>
                <select name="categoryId" required>
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.categoryid}">${c.categoryname}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <div class="form-group form-col">
                    <label>Giá bán (VNĐ) (*):</label>
                    <input type="number" name="price" min="0" step="1000" placeholder="VD: 500000" required>
                </div>
                <div class="form-group form-col">
                    <label>Số lượng kho (*):</label>
                    <input type="number" name="quantity" min="0" placeholder="VD: 100" required>
                </div>
            </div>

            <div class="form-group">
                <label>Mô tả chi tiết:</label>
                <textarea name="description" placeholder="Thông số kĩ thuật, đặc điểm nổi bật..."></textarea>
            </div>

            <div class="form-group">
                <label>Link ảnh trực tiếp (URL):</label>
                <input type="text" name="images" placeholder="https://example.com/image.jpg">
            </div>

            <div class="form-group">
                <label>Hoặc Upload ảnh từ máy tính:</label>
                <input type="file" name="images1" accept="image/*">
            </div>

            <div class="form-group">
                <label>Trạng thái hiển thị:</label>
                <div class="radio-group">
                    <label style="font-weight: normal; margin: 0; cursor: pointer;">
                        <input type="radio" name="status" value="1" checked> Đang bán (Hiển thị)
                    </label>
                    <label style="font-weight: normal; margin: 0; cursor: pointer;">
                        <input type="radio" name="status" value="0"> Tạm ẩn
                    </label>
                </div>
            </div>

            <button type="submit" class="btn-submit">Lưu Sản Phẩm</button>
        </form>
        <a href="<c:url value='/admin/products'/>" class="btn-back">← Quay lại danh sách sản phẩm</a>
    </div>
</body>
</html>
