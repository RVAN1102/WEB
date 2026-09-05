<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title>Trang Chủ Mua Sắm - Shopping MVC</title>
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

        .hero-banner {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: #fff;
            padding: 40px 30px;
            border-radius: var(--radius-md);
            margin-bottom: 35px;
            box-shadow: 0 4px 15px rgba(30, 60, 114, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .hero-text h1 {
            margin: 0 0 10px 0;
            font-size: 2rem;
            font-weight: 700;
        }

        .hero-text p {
            margin: 0;
            font-size: 1.05rem;
            opacity: 0.9;
        }

        .btn-banner {
            background-color: #ffc107;
            color: #212529;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 700;
            text-decoration: none;
            transition: transform 0.2s, background-color 0.2s;
            display: inline-block;
        }

        .btn-banner:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 12px;
        }

        .section-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: #1a1a1a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .see-all-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .see-all-link:hover {
            text-decoration: underline;
        }

        /* Danh mục */
        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
            gap: 20px;
            margin-bottom: 45px;
        }

        .category-card {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 18px 15px;
            text-align: center;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .category-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-hover);
        }

        .category-card img {
            width: 100%;
            height: 110px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 12px;
            background-color: #f1f3f5;
        }

        .category-card h4 {
            margin: 0;
            font-size: 1rem;
            font-weight: 600;
        }

        /* Sản phẩm Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(215px, 1fr));
            gap: 22px;
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
            position: relative;
            border: 1px solid #f0f0f0;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-hover);
            border-color: #dee2e6;
        }

        .product-img-wrapper {
            width: 100%;
            height: 180px;
            overflow: hidden;
            background-color: #f8f9fa;
            position: relative;
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

        .badge-new {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #e63946;
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .product-info {
            padding: 14px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-cat {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .product-title {
            font-size: 0.95rem;
            font-weight: 600;
            margin: 0 0 8px 0;
            line-height: 1.35;
            height: 2.7em;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-price {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--accent-price);
            margin-top: auto;
            margin-bottom: 8px;
        }

        .btn-view-detail {
            background-color: #e7f1ff;
            color: var(--primary);
            padding: 8px 0;
            border-radius: 6px;
            text-align: center;
            font-weight: 600;
            font-size: 0.85rem;
            transition: background-color 0.2s;
        }

        .product-card:hover .btn-view-detail {
            background-color: var(--primary);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Hero Banner -->
        <div class="hero-banner">
            <div class="hero-text">
                <h1>Chào Mừng Đến Với Shopping MVC!</h1>
                <p>Khám phá công nghệ hiện đại, chất lượng đỉnh cao và ưu đãi hấp dẫn mỗi ngày.</p>
            </div>
            <div>
                <a href="<c:url value='/product'/>" class="btn-banner">Khám Phá Toàn Bộ Sản Phẩm →</a>
            </div>
        </div>

        <!-- 1. Danh Mục Nổi Bật -->
        <div class="section-header">
            <h2 class="section-title">📂 Danh Mục Nổi Bật</h2>
        </div>

        <div class="category-grid">
            <c:forEach items="${cateList}" var="cate">
                <c:if test="${cate.status == 1}">
                    <a href="<c:url value='/product?cid=${cate.categoryid}'/>" class="category-card">
                        <c:choose>
                            <c:when test="${empty cate.images}">
                                <img src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='170' height='110' viewBox='0 0 170 110'><rect width='170' height='110' fill='%23e9ecef'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='12' fill='%236c757d'>No Image</text></svg>" alt="${cate.categoryname}" />
                            </c:when>
                            <c:when test="${cate.images.startsWith('http')}">
                                <img src="${cate.images}" alt="${cate.categoryname}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                <img src="${imgUrl}" alt="${cate.categoryname}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                            </c:otherwise>
                        </c:choose>
                        <h4>${cate.categoryname}</h4>
                    </a>
                </c:if>
            </c:forEach>
        </div>

        <!-- 2. 10 Sản Phẩm Mới Nhất -->
        <div class="section-header">
            <h2 class="section-title">🔥 10 Sản Phẩm Mới Nhất</h2>
            <a href="<c:url value='/product'/>" class="see-all-link">Xem tất cả sản phẩm &raquo;</a>
        </div>

        <c:choose>
            <c:when test="${empty top10Products}">
                <div style="background: #fff; padding: 40px; text-align: center; border-radius: 12px; color: #6c757d;">
                    <p style="font-size: 1.1rem; margin: 0;">Hiện tại chưa có sản phẩm nào được đăng tải.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach items="${top10Products}" var="p">
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-card">
                            <div class="product-img-wrapper">
                                <span class="badge-new">Mới</span>
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
                                <div class="btn-view-detail">Xem chi tiết</div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>