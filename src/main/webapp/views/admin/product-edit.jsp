<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Sản Phẩm</title>
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
        .btn-submit { background-color: #007bff; color: white; padding: 12px 24px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; font-size: 15px; }
        .btn-submit:hover { background-color: #0069d9; }
        .btn-back { display: inline-block; margin-top: 15px; color: #007bff; text-decoration: none; font-weight: 500; }
        .radio-group { display: flex; gap: 20px; align-items: center; margin-top: 6px; }
        .img-preview { width: 140px; height: 105px; object-fit: cover; border: 1px solid #ddd; margin-bottom: 10px; border-radius: 4px; }
    </style>
</head>
<body>
    <%@ include file="/common/web/topbar.jsp" %>
    <div class="card">
        <h2 style="margin-top: 0; margin-bottom: 20px; color: #2c3e50;">Chỉnh Sửa Sản Phẩm (JPA)</h2>
        <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${product.productId}">

            <div class="form-group">
                <label>Tên sản phẩm (*):</label>
                <input type="text" name="productName" value="${product.productName}" required>
            </div>

            <div class="form-group">
                <label>Danh mục (*):</label>
                <select name="categoryId" required>
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.categoryid}" ${product.category != null && product.category.categoryid == c.categoryid ? 'selected' : ''}>
                            ${c.categoryname}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <div class="form-group form-col">
                    <label>Giá bán (VNĐ) (*):</label>
                    <input type="number" name="price" value="${product.price}" min="0" step="1000" required>
                </div>
                <div class="form-group form-col">
                    <label>Số lượng kho (*):</label>
                    <input type="number" name="quantity" value="${product.quantity}" min="0" required>
                </div>
            </div>

            <div class="form-group">
                <label>Mô tả chi tiết:</label>
                <textarea name="description">${product.description}</textarea>
            </div>

            <div class="form-group">
                <label>Ảnh hiện tại:</label><br>
                <c:choose>
                    <c:when test="${empty product.images}">
                        <p style="color: #888; font-style: italic;">Chưa có hình ảnh</p>
                    </c:when>
                    <c:when test="${product.images.startsWith('http')}">
                        <img class="img-preview" src="${product.images}" alt="${product.productName}">
                    </c:when>
                    <c:otherwise>
                        <img class="img-preview" src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}">
                    </c:otherwise>
                </c:choose>
                <input type="hidden" name="images" value="${product.images}">
            </div>

            <div class="form-group">
                <label>Thay đổi ảnh (Upload file mới):</label>
                <input type="file" name="images1" accept="image/*">
            </div>

            <div class="form-group">
                <label>Trạng thái hiển thị:</label>
                <div class="radio-group">
                    <label style="font-weight: normal; margin: 0; cursor: pointer;">
                        <input type="radio" name="status" value="1" ${product.status == 1 ? 'checked' : ''}> Đang bán (Hiển thị)
                    </label>
                    <label style="font-weight: normal; margin: 0; cursor: pointer;">
                        <input type="radio" name="status" value="0" ${product.status == 0 ? 'checked' : ''}> Tạm ẩn
                    </label>
                </div>
            </div>

            <button type="submit" class="btn-submit">Cập nhật Sản Phẩm</button>
        </form>
        <a href="<c:url value='/admin/products'/>" class="btn-back">← Quay lại danh sách sản phẩm</a>
    </div>
</body>
</html>
