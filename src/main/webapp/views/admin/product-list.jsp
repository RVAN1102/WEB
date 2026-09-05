<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="referrer" content="no-referrer">
    <title>Quản Lý Sản Phẩm - Admin</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 20px; }
        .card { background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 1100px; margin: auto; }
        .header-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #e9ecef; padding-bottom: 10px; }
        .btn-add { background-color: #28a745; color: white; padding: 9px 16px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .btn-add:hover { background-color: #218838; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #dee2e6; vertical-align: middle; }
        th { background-color: #f8f9fa; color: #495057; font-weight: 600; }
        tr:hover { background-color: #f1f3f5; }
        .img-thumb { width: 80px; height: 60px; object-fit: cover; border-radius: 4px; border: 1px solid #ced4da; }
        .badge { padding: 5px 10px; border-radius: 12px; font-size: 0.85em; font-weight: bold; }
        .badge-active { background-color: #d4edda; color: #155724; }
        .badge-locked { background-color: #f8d7da; color: #721c24; }
        .badge-category { background-color: #e2e3e5; color: #383d41; }
        .btn-action { padding: 5px 10px; border-radius: 4px; text-decoration: none; font-size: 0.9em; color: white; margin: 0 2px; }
        .btn-edit { background-color: #007bff; }
        .btn-edit:hover { background-color: #0069d9; }
        .btn-delete { background-color: #dc3545; }
        .btn-delete:hover { background-color: #c82333; }
        .price-text { color: #d9534f; font-weight: bold; }
    </style>
</head>
<body>
    <%@ include file="/common/web/topbar.jsp" %>

    <div class="card">
        <div class="header-bar">
            <h2>Quản Lý Sản Phẩm (JPA)</h2>
            <div>
                <a href="<c:url value='/admin/categories'/>" style="margin-right: 15px; color: #007bff; text-decoration: none; font-weight: 600;">📁 Quản lý danh mục</a>
                <a href="<c:url value='/admin/product/add'/>" class="btn-add">+ Thêm sản phẩm mới</a>
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th width="5%">STT</th>
                    <th width="12%">Hình ảnh</th>
                    <th width="25%">Tên sản phẩm</th>
                    <th width="15%">Danh mục</th>
                    <th width="12%">Giá bán</th>
                    <th width="8%">Số lượng</th>
                    <th width="10%">Trạng thái</th>
                    <th width="13%">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty listproduct}">
                        <tr>
                            <td colspan="8" style="padding: 30px; color: #6c757d;">Chưa có sản phẩm nào. Hãy bấm "+ Thêm sản phẩm mới" để bắt đầu.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${listproduct}" var="p" varStatus="STT">
                            <tr>
                                <td>${STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty p.images}">
                                            <img class="img-thumb" src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80" alt="No Image" />
                                        </c:when>
                                        <c:when test="${p.images.startsWith('http')}">
                                            <img class="img-thumb" src="${p.images}" alt="${p.productName}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${p.images}" var="imgUrl"/>
                                            <img class="img-thumb" src="${imgUrl}" alt="${p.productName}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: left;">
                                    <strong>${p.productName}</strong>
                                </td>
                                <td>
                                    <span class="badge badge-category">${p.category != null ? p.category.categoryname : 'Chưa phân loại'}</span>
                                </td>
                                <td>
                                    <span class="price-text">
                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" /> đ
                                    </span>
                                </td>
                                <td>${p.quantity}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 1}">
                                            <span class="badge badge-active">Đang bán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-locked">Tạm ẩn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn-action btn-edit">Sửa</a>
                                    <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn-action btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>
