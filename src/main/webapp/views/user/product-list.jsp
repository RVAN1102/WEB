<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title>Kho Hàng & Sản Phẩm - Shopping MVC</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumbs -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb mb-0 small font-mono">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none text-muted">Trang Chủ</a></li>
                <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">
                    <c:choose>
                        <c:when test="${not empty selectedCid}">Phân Loại #${selectedCid}</c:when>
                        <c:when test="${not empty keyword}">Tìm kiếm: "${keyword}"</c:when>
                        <c:otherwise>Toàn Bộ Kho Hàng</c:otherwise>
                    </c:choose>
                </li>
            </ol>
        </nav>

        <!-- Header Section -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-3 pb-3 mb-4 border-bottom">
            <div>
                <span class="font-mono text-uppercase small text-muted fw-bold" style="font-size: 0.75rem; letter-spacing: 0.08em;">BỘ SƯU TẬP & KHO THIẾT BỊ</span>
                <h1 class="h4 fw-bold mb-1 text-dark mt-1">
                    <c:choose>
                        <c:when test="${not empty selectedCid}">Mặt Hàng Theo Danh Mục</c:when>
                        <c:when test="${not empty keyword}">Kết Quả Tìm Kiếm</c:when>
                        <c:otherwise>Tất Cả Sản Phẩm Chính Hãng</c:otherwise>
                    </c:choose>
                </h1>
                <p class="text-secondary small mb-0">Niêm yết giá bán công khai, tình trạng tồn kho thực tế và chính sách bảo hành 12 tháng.</p>
            </div>
            
            <div class="d-flex align-items-center gap-2 font-mono small">
                <c:if test="${not empty selectedCid || not empty keyword}">
                    <a href="<c:url value='/product'/>" class="btn btn-sm btn-outline-dark rounded-1 px-3">
                        <i class="bi bi-x me-1"></i>Bỏ lọc
                    </a>
                </c:if>
                <div class="p-2 border rounded-1 bg-white text-muted">
                    <span>Tổng: <strong class="text-dark">${totalProducts}</strong> mặt hàng &bull; Trang ${currentPage}/${totalPages}</span>
                </div>
            </div>
        </div>

        <!-- Product Grid Content -->
        <c:choose>
            <c:when test="${empty products}">
                <div class="bg-white border rounded-2 p-5 text-center my-4">
                    <i class="bi bi-box2 fs-2 text-secondary mb-2 d-block"></i>
                    <h5 class="fw-bold text-dark mb-1">Không tìm thấy sản phẩm phù hợp</h5>
                    <p class="text-muted small max-w-md mx-auto mb-4" style="max-width: 440px;">Hiện tại danh mục hoặc từ khóa này chưa có sản phẩm. Bạn có thể xem các nhóm hàng khác hoặc quay lại trang chủ.</p>
                    <div class="d-flex justify-content-center gap-2">
                        <a href="<c:url value='/product'/>" class="btn btn-dark btn-sm rounded-1 px-3 py-2">
                            Toàn Bộ Kho Hàng
                        </a>
                        <a href="<c:url value='/home'/>" class="btn btn-light btn-sm border rounded-1 px-3 py-2">
                            Về Trang Chủ
                        </a>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <!-- 6 Sản phẩm / Trang Grid -->
                <div class="row g-3 g-md-4 mb-5">
                    <c:forEach items="${products}" var="p">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <div class="product-matrix-card">
                                <!-- Image Stage -->
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-matrix-media d-block">
                                    <c:choose>
                                        <c:when test="${empty p.images}">
                                            <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80" alt="${p.productName}" loading="lazy">
                                        </c:when>
                                        <c:when test="${p.images.startsWith('http')}">
                                            <img src="${p.images}" alt="${p.productName}" loading="lazy" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';">
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${p.images}" var="pImgUrl"/>
                                            <img src="${pImgUrl}" alt="${p.productName}" loading="lazy" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';">
                                        </c:otherwise>
                                    </c:choose>
                                </a>

                                <!-- Body -->
                                <div class="product-matrix-content">
                                    <div class="product-meta-header">
                                        <span class="product-category-meta">
                                            ${p.category != null ? p.category.categoryname : 'Thiết bị'}
                                        </span>
                                        <span class="product-stock-indicator ${p.quantity > 0 ? 'in-stock' : 'out-of-stock'}">
                                            <span>${p.quantity > 0 ? '● Còn hàng' : '○ Tạm hết'}</span>
                                        </span>
                                    </div>

                                    <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-decoration-none">
                                        <h3 class="product-matrix-title" title="${p.productName}">
                                            ${p.productName}
                                        </h3>
                                    </a>

                                    <div class="product-matrix-price-row">
                                        <div class="product-price-val">
                                            <fmt:formatNumber value="${p.price}" pattern="#,##0" /> ₫
                                        </div>
                                        <c:if test="${p.quantity > 0}">
                                            <span class="font-mono text-muted small" style="font-size: 0.6875rem;">Kho: ${p.quantity}</span>
                                        </c:if>
                                    </div>

                                    <div class="product-action-row">
                                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn-card-inspect">
                                            Chi tiết
                                        </a>
                                        <button type="button" class="btn-card-cart" 
                                                onclick="window.showToast('Đã thêm sản phẩm vào giỏ hàng');" 
                                                title="Thêm vào giỏ">
                                            <i class="bi bi-cart-plus"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Clean Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Phân trang sản phẩm" class="d-flex justify-content-center my-4 font-mono">
                        <ul class="pagination pagination-sm mb-0">
                            <!-- Prev button -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link text-dark" href="<c:url value='/product?page=${currentPage - 1}${not empty selectedCid ? \"&cid=\".concat(selectedCid) : \"\"}${not empty keyword ? \"&search=\".concat(keyword) : \"\"}'/>">
                                    &larr; Trước
                                </a>
                            </li>

                            <!-- Page Numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link ${i == currentPage ? 'bg-dark border-dark text-white' : 'text-dark'}" 
                                       href="<c:url value='/product?page=${i}${not empty selectedCid ? \"&cid=\".concat(selectedCid) : \"\"}${not empty keyword ? \"&search=\".concat(keyword) : \"\"}'/>">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Next button -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link text-dark" href="<c:url value='/product?page=${currentPage + 1}${not empty selectedCid ? \"&cid=\".concat(selectedCid) : \"\"}${not empty keyword ? \"&search=\".concat(keyword) : \"\"}'/>">
                                    Sau &rarr;
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
