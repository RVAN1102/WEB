<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title>${product.productName} - Chi Tiết Sản Phẩm</title>
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
            --shadow-card: 0 4px 16px rgba(0,0,0,0.06);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px 20px 60px 20px;
        }

        .breadcrumb-nav {
            margin-bottom: 24px;
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

        .detail-card {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 35px;
            box-shadow: var(--shadow-card);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        @media (max-width: 768px) {
            .detail-card {
                grid-template-columns: 1fr;
                padding: 20px;
                gap: 25px;
            }
        }

        .product-image-box {
            background-color: #fcfcfc;
            border-radius: 10px;
            border: 1px solid #eaeaea;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 380px;
        }

        .product-image-box img {
            max-width: 100%;
            max-height: 420px;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .product-image-box img:hover {
            transform: scale(1.03);
        }

        .product-info-box {
            display: flex;
            flex-direction: column;
        }

        .category-tag {
            display: inline-block;
            background-color: #e9ecef;
            color: #495057;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 5px 12px;
            border-radius: 15px;
            margin-bottom: 12px;
            align-self: flex-start;
        }

        .product-name {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0 0 15px 0;
            line-height: 1.3;
            color: #1a1a1a;
        }

        .price-box {
            background-color: #fff5f5;
            padding: 16px 20px;
            border-radius: 8px;
            border-left: 4px solid var(--accent-price);
            margin-bottom: 20px;
        }

        .price-label {
            font-size: 0.85rem;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .price-value {
            font-size: 1.9rem;
            font-weight: 800;
            color: var(--accent-price);
        }

        .meta-list {
            list-style: none;
            padding: 0;
            margin: 0 0 24px 0;
            border-top: 1px solid #f0f0f0;
            border-bottom: 1px solid #f0f0f0;
            padding: 15px 0;
        }

        .meta-list li {
            padding: 6px 0;
            font-size: 0.95rem;
            display: flex;
            gap: 10px;
        }

        .meta-list li strong {
            min-width: 130px;
            color: #555;
        }

        .description-box {
            margin-bottom: 30px;
            flex-grow: 1;
        }

        .description-box h4 {
            margin: 0 0 10px 0;
            font-size: 1.1rem;
            color: #333;
        }

        .description-content {
            color: #555;
            line-height: 1.6;
            font-size: 0.95rem;
            white-space: pre-line;
        }

        .action-group {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: auto;
        }

        .btn {
            padding: 12px 22px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
        }

        .btn-buy {
            background-color: var(--accent-price);
            color: white;
            flex: 1;
        }

        .btn-buy:hover {
            background-color: #d62828;
            transform: translateY(-2px);
        }

        .btn-back-product {
            background-color: #e9ecef;
            color: #495057;
        }

        .btn-back-product:hover {
            background-color: #dee2e6;
        }

        .btn-back-home {
            background-color: #f8f9fa;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn-back-home:hover {
            background-color: var(--primary);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb-nav">
            <a href="<c:url value='/home'/>">Trang chủ</a> &raquo; 
            <a href="<c:url value='/product'/>">Sản phẩm</a> &raquo; 
            <span>${product.productName}</span>
        </div>

        <div class="detail-card">
            <!-- Left: Ảnh sản phẩm -->
            <div class="product-image-box">
                <c:choose>
                    <c:when test="${empty product.images}">
                        <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80" alt="${product.productName}">
                    </c:when>
                    <c:when test="${product.images.startsWith('http')}">
                        <img src="${product.images}" alt="${product.productName}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';">
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${product.images}" var="detailImgUrl"/>
                        <img src="${detailImgUrl}" alt="${product.productName}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';">
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Right: Thông tin chi tiết -->
            <div class="product-info-box">
                <span class="category-tag">
                    📁 ${product.category != null ? product.category.categoryname : 'Chưa phân loại'}
                </span>

                <h1 class="product-name">${product.productName}</h1>

                <div class="price-box">
                    <div class="price-label">Giá niêm yết:</div>
                    <div class="price-value">
                        <fmt:formatNumber value="${product.price}" pattern="#,##0" /> VNĐ
                    </div>
                </div>

                <ul class="meta-list">
                    <li>
                        <strong>Tình trạng hàng:</strong>
                        <c:choose>
                            <c:when test="${product.quantity > 0}">
                                <span style="color: #28a745; font-weight: 600;">Còn hàng (${product.quantity} sản phẩm)</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #dc3545; font-weight: 600;">Hết hàng tạm thời</span>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <c:if test="${not empty product.createDate}">
                        <li>
                            <strong>Ngày đăng bán:</strong>
                            <span><fmt:formatDate value="${product.createDate}" pattern="dd/MM/yyyy" /></span>
                        </li>
                    </c:if>
                    <li>
                        <strong>Mã sản phẩm:</strong>
                        <span>#SP-${product.productId}</span>
                    </li>
                </ul>

                <div class="description-box">
                    <h4>Mô tả sản phẩm</h4>
                    <div class="description-content">
                        <c:choose>
                            <c:when test="${empty product.description}">
                                <p style="color: #888; font-style: italic;">Chưa có mô tả chi tiết cho sản phẩm này.</p>
                            </c:when>
                            <c:otherwise>
                                ${product.description}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="action-group">
                    <button type="button" class="btn btn-buy" onclick="alert('Đã thêm sản phẩm vào giỏ hàng thành công!')">
                        🛒 Thêm Vào Giỏ Hàng
                    </button>
                    <a href="<c:url value='/product'/>" class="btn btn-back-product">
                        ← Danh sách sản phẩm
                    </a>
                    <a href="<c:url value='/home'/>" class="btn btn-back-home">
                        🏠 Trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
