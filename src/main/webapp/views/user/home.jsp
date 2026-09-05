<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title>Thiết Bị Công Nghệ Chính Hãng - Shopping MVC</title>
</head>
<body>
    <div class="container py-4">
        <!-- 1. Editorial Hero Section -->
        <section class="editorial-hero mb-4">
            <div class="row align-items-center g-4">
                <div class="col-lg-7 col-xl-7">
                    <div class="editorial-hero-eyebrow">
                        <span>BỘ SƯU TẬP THIẾT BỊ 2026</span>
                    </div>
                    <h1 class="editorial-hero-heading">
                        Thiết Kế Chuẩn Mực.<br>
                        Hiệu Năng Đỉnh Cao.
                    </h1>
                    <p class="editorial-hero-desc">
                        Tuyển chọn các dòng điện thoại thông minh, máy tính xách tay và thiết bị âm thanh hàng đầu với chế độ bảo hành chính hãng 12 tháng và hỗ trợ kỹ thuật tận tâm.
                    </p>
                    <div class="d-flex flex-wrap gap-3">
                        <a href="<c:url value='/product'/>" class="btn-editorial-primary">
                            <span>Khám Phá Kho Hàng</span>
                            <i class="bi bi-arrow-right"></i>
                        </a>
                        <a href="#featuredCategories" class="btn-editorial-outline">
                            <span>Xem Danh Mục</span>
                        </a>
                    </div>
                </div>
                <div class="col-lg-5 col-xl-5 d-none d-lg-block">
                    <div class="hero-product-stage">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="hero-spec-tag">SẢN PHẨM TIÊU BIỂU</span>
                            <span class="badge bg-white text-dark font-mono rounded-1 small" style="font-size: 0.6875rem;">MỚI RA MẮT</span>
                        </div>
                        <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600&q=80" alt="Smartphone Flagship" />
                        <div class="d-flex justify-content-between align-items-baseline">
                            <div>
                                <h6 class="text-white fw-bold mb-0">Smartphone Flagship Series</h6>
                                <span class="small text-muted font-mono">Màn hình OLED 120Hz &bull; Khung hợp kim</span>
                            </div>
                            <a href="<c:url value='/product'/>" class="text-white text-decoration-none small fw-semibold font-mono">
                                Chi tiết &rarr;
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 2. Architectural Assurance Strip (Non-AI, Minimalist) -->
        <section class="mb-5">
            <div class="assurance-strip">
                <div class="assurance-item">
                    <i class="bi bi-patch-check assurance-item-icon"></i>
                    <div>
                        <div class="assurance-item-title">100% Chính Hãng</div>
                        <div class="assurance-item-subtitle">Phân phối ủy quyền, hóa đơn VAT đầy đủ</div>
                    </div>
                </div>
                <div class="assurance-item">
                    <i class="bi bi-box-seam assurance-item-icon"></i>
                    <div>
                        <div class="assurance-item-title">Giao Nhanh Toàn Quốc</div>
                        <div class="assurance-item-subtitle">Miễn phí vận chuyển cho đơn từ 500.000₫</div>
                    </div>
                </div>
                <div class="assurance-item">
                    <i class="bi bi-arrow-repeat assurance-item-icon"></i>
                    <div>
                        <div class="assurance-item-title">Đổi Mới 30 Ngày</div>
                        <div class="assurance-item-subtitle">Áp dụng cho lỗi kỹ thuật từ nhà sản xuất</div>
                    </div>
                </div>
                <div class="assurance-item">
                    <i class="bi bi-shield-check assurance-item-icon"></i>
                    <div>
                        <div class="assurance-item-title">Bảo Hành 12 Tháng</div>
                        <div class="assurance-item-subtitle">Tiếp nhận tại trung tâm bảo hành toàn quốc</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. Category Matrix Section -->
        <section id="featuredCategories" class="mb-5">
            <div class="d-flex justify-content-between align-items-end mb-3 border-bottom pb-2">
                <div>
                    <span class="font-mono text-uppercase small text-muted fw-bold" style="font-size: 0.75rem; letter-spacing: 0.08em;">PHÂN LOẠI MẶT HÀNG</span>
                    <h2 class="h5 fw-bold mb-0 text-dark mt-0.5">Danh Mục Sản Phẩm</h2>
                </div>
                <a href="<c:url value='/product'/>" class="text-decoration-none fw-semibold text-dark small font-mono">
                    Tất cả danh mục &rarr;
                </a>
            </div>

            <div class="row g-3 row-cols-2 row-cols-md-3 row-cols-lg-6">
                <c:forEach items="${cateList}" var="cate">
                    <c:if test="${cate.status == 1}">
                        <div class="col">
                            <a href="<c:url value='/product?cid=${cate.categoryid}'/>" class="category-spec-card">
                                <div class="category-stage-box">
                                    <c:choose>
                                        <c:when test="${empty cate.images}">
                                            <i class="bi bi-device-ssd fs-3 text-secondary"></i>
                                        </c:when>
                                        <c:when test="${cate.images.startsWith('http')}">
                                            <img src="${cate.images}" alt="${cate.categoryname}" 
                                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                            <img src="${imgUrl}" alt="${cate.categoryname}" 
                                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="category-spec-name">${cate.categoryname}</div>
                                <span class="category-spec-count">Xem mặt hàng &rarr;</span>
                            </a>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </section>

        <!-- 4. Top 10 Latest Products Matrix -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-end mb-3 border-bottom pb-2">
                <div>
                    <span class="font-mono text-uppercase small text-muted fw-bold" style="font-size: 0.75rem; letter-spacing: 0.08em;">ĐỢT HÀNG MỚI VỀ</span>
                    <h2 class="h5 fw-bold mb-0 text-dark mt-0.5">10 Sản Phẩm Mới Nhất</h2>
                </div>
                <a href="<c:url value='/product'/>" class="text-decoration-none fw-semibold text-dark small font-mono">
                    Toàn bộ kho hàng &rarr;
                </a>
            </div>

            <c:choose>
                <c:when test="${empty top10Products}">
                    <div class="bg-white rounded-2 p-5 text-center border text-muted">
                        <i class="bi bi-box2 fs-2 text-secondary mb-2 d-block"></i>
                        <h6 class="fw-bold">Kho hàng hiện đang cập nhật</h6>
                        <p class="small mb-0">Các mặt hàng mới sẽ được cập nhật sớm nhất.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3 row-cols-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">
                        <c:forEach items="${top10Products}" var="p">
                            <div class="col">
                                <div class="product-matrix-card">
                                    <!-- Image Stage -->
                                    <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-matrix-media d-block">
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
                                    </a>

                                    <!-- Content Body -->
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

                                        <!-- Price Row -->
                                        <div class="product-matrix-price-row">
                                            <div class="product-price-val">
                                                <fmt:formatNumber value="${p.price}" pattern="#,##0" /> ₫
                                            </div>
                                            <c:if test="${p.quantity > 0}">
                                                <span class="font-mono text-muted small" style="font-size: 0.6875rem;">Kho: ${p.quantity}</span>
                                            </c:if>
                                        </div>

                                        <!-- Actions -->
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
                </c:otherwise>
            </c:choose>
        </section>

        <!-- 5. Editorial Membership Banner -->
        <section class="p-4 p-md-5 rounded-3 text-white position-relative overflow-hidden mb-3" style="background: var(--surface-dark); border: 1px solid rgba(255,255,255,0.08);">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="font-mono text-uppercase small text-muted fw-bold d-block mb-1" style="letter-spacing: 0.1em;">DỊCH VỤ KHÁCH HÀNG</span>
                    <h3 class="fw-bold mb-2 text-white">Đăng Ký Tài Khoản Thành Viên</h3>
                    <p class="text-muted small mb-0" style="max-width: 540px;">
                        Quản lý lịch sử đơn hàng, cập nhật tình trạng giao nhận theo thời gian thực và hưởng quyền lợi bảo hành điện tử nhanh chóng.
                    </p>
                </div>
                <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                    <c:choose>
                        <c:when test="${sessionScope.account == null}">
                            <a href="<c:url value='/register'/>" class="btn btn-light rounded-2 px-4 py-2 fw-bold text-dark">
                                Đăng Ký Tài Khoản &rarr;
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/product'/>" class="btn btn-light rounded-2 px-4 py-2 fw-bold text-dark">
                                Tiếp Tục Mua Sắm &rarr;
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
    </div>
</body>
</html>