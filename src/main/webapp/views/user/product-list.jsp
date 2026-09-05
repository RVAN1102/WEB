<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title>Tất Cả Sản Phẩm - Shopping MVC</title>
    <style>
        :root {
            --primary: #0d6efd;
            --primary-hover: #0b5ed7;
            --bg-color: #f8f9fa;
            --card-bg: #ffffff;
            --text-dark: #212529;
            --text-muted: #6c757d;
            --accent-price: #e63946;
            --radius-md: 12px;
            --shadow-sm: 0 2px 8px rgba(0,0,0,0.06);
            --shadow-hover: 0 10px 24px rgba(0,0,0,0.12);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px 20px 60px 20px;
        }

        .breadcrumb-nav {
            margin-bottom: 20px;
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .breadcrumb-nav a {
            color: var(--primary);
            text-decoration: none;
        }

        .breadcrumb-nav a:hover {
            text-decoration: underline;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 12px;
        }

        .page-title {
            font-size: 1.6rem;
            font-weight: 700;
            margin: 0;
            color: #1a1a1a;
        }

        .product-count-badge {
            background-color: #e9ecef;
            color: #495057;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        /* Grid 6 products / page */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .product-card {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            text-decoration: none;
            color: inherit;
            border: 1px solid #f0f0f0;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-hover);
            border-color: #dee2e6;
        }

        .product-img-wrapper {
            width: 100%;
            height: 220px;
            overflow: hidden;
            background-color: #f8f9fa;
        }

        .product-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
            display: block;
            color: transparent;
        }

        .product-card:hover .product-img-wrapper img {
            transform: scale(1.06);
        }

        .product-info {
            padding: 18px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-cat {
            font-size: 0.85rem;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .product-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin: 0 0 10px 0;
            line-height: 1.4;
            height: 2.8em;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--accent-price);
            margin-top: auto;
            margin-bottom: 12px;
        }

        .btn-view-detail {
            background-color: #e7f1ff;
            color: var(--primary);
            padding: 10px 0;
            border-radius: 6px;
            text-align: center;
            font-weight: 600;
            font-size: 0.9rem;
            transition: background-color 0.2s;
        }

        .product-card:hover .btn-view-detail {
            background-color: var(--primary);
            color: white;
        }

        /* Phân trang (Pagination) */
        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
        }

        .page-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            height: 40px;
            padding: 0 12px;
            border-radius: 8px;
            background-color: white;
            color: var(--text-dark);
            border: 1px solid #dee2e6;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .page-link:hover {
            background-color: #e9ecef;
            border-color: #ced4da;
        }

        .page-link.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .page-link.disabled {
            color: #adb5bd;
            pointer-events: none;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb-nav">
            <a href="<c:url value='/home'/>">Trang chủ</a> &raquo; <span>Danh sách tất cả sản phẩm</span>
        </div>

        <div class="page-header">
            <h1 class="page-title">🛍️ Tất Cả Sản Phẩm</h1>
            <span class="product-count-badge">Tổng số: ${totalProducts} sản phẩm (Trang ${currentPage} / ${totalPages})</span>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <div style="background: #fff; padding: 60px 20px; text-align: center; border-radius: 12px; color: #6c757d; box-shadow: var(--shadow-sm);">
                    <h3 style="margin-bottom: 10px;">Chưa có sản phẩm nào đang bán</h3>
                    <p>Vui lòng quay lại sau hoặc truy cập trang quản trị để thêm sản phẩm mới.</p>
                    <a href="<c:url value='/home'/>" style="color: var(--primary); font-weight: 600;">← Về Trang Chủ</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 6 Sản phẩm / Trang -->
                <div class="product-grid">
                    <c:forEach items="${products}" var="p">
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-card">
                            <div class="product-img-wrapper">
                                <c:choose>
                                    <c:when test="${empty p.images}">
                                        <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80" alt="${p.productName}">
                                    </c:when>
                                    <c:when test="${p.images.startsWith('http')}">
                                        <img src="${p.images}" alt="${p.productName}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';">
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${p.images}" var="pImgUrl"/>
                                        <img src="${pImgUrl}" alt="${p.productName}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="product-info">
                                <span class="product-cat">${p.category != null ? p.category.categoryname : 'Sản phẩm'}</span>
                                <div class="product-title" title="${p.productName}">${p.productName}</div>
                                <div class="product-price">
                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" /> đ
                                </div>
                                <div class="btn-view-detail">Bấm xem chi tiết &raquo;</div>
                            </div>
                        </a>
                    </c:forEach>
                </div>

                <!-- Phân Trang (Pagination) -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination-container">
                        <!-- Nút Trang trước -->
                        <a href="<c:url value='/product?page=${currentPage - 1}'/>" class="page-link ${currentPage == 1 ? 'disabled' : ''}">
                            &laquo; Trước
                        </a>

                        <!-- Các trang số -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="<c:url value='/product?page=${i}'/>" class="page-link ${i == currentPage ? 'active' : ''}">
                                ${i}
                            </a>
                        </c:forEach>

                        <!-- Nút Trang sau -->
                        <a href="<c:url value='/product?page=${currentPage + 1}'/>" class="page-link ${currentPage == totalPages ? 'disabled' : ''}">
                            Sau &raquo;
                        </a>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
