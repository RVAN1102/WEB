<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="referrer" content="no-referrer">
    <title>Quản Lý Sản Phẩm - Kho Hàng</title>
</head>
<body>
    <div class="py-2">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="badge bg-light text-dark border rounded-1 px-2.5 py-1 small fw-semibold font-mono">
                        <i class="bi bi-box-seam me-1"></i>KHO HÀNG & SẢN PHẨM
                    </span>
                </div>
                <h3 class="fw-bold mb-0 text-dark">Danh Sách Sản Phẩm</h3>
                <p class="text-muted mb-0 small">Quản lý giá niêm yết, số lượng tồn kho, hình ảnh và danh mục liên kết</p>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary rounded-pill px-3 py-2 fw-semibold d-inline-flex align-items-center gap-1.5">
                    <i class="bi bi-folder2-open"></i>
                    <span>Xem Danh Mục</span>
                </a>
                <a href="<c:url value='/admin/product/add'/>" class="btn btn-primary rounded-pill px-3.5 py-2 fw-semibold shadow-sm d-inline-flex align-items-center gap-2">
                    <i class="bi bi-plus-circle-fill"></i>
                    <span>Thêm Sản Phẩm Mới</span>
                </a>
            </div>
        </div>

        <!-- Table Card -->
        <div class="card admin-card overflow-hidden">
            <div class="p-3 border-bottom bg-white d-flex justify-content-between align-items-center flex-wrap gap-2">
                <span class="fw-bold text-dark small text-uppercase" style="letter-spacing: 0.05em;">
                    <i class="bi bi-boxes text-primary me-2"></i>Mặt Hàng Kinh Doanh
                </span>
                <span class="badge bg-light text-muted border px-2.5 py-1.5 rounded-pill small">
                    Tổng: <strong class="text-primary">${not empty listproduct ? listproduct.size() : 0}</strong> sản phẩm
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-custom align-middle mb-0">
                    <thead>
                        <tr>
                            <th scope="col" class="text-center" style="width: 5%;">#</th>
                            <th scope="col" style="width: 12%;">Hình Ảnh</th>
                            <th scope="col" style="width: 25%;">Tên Sản Phẩm</th>
                            <th scope="col" style="width: 15%;">Danh Mục</th>
                            <th scope="col" class="text-end" style="width: 15%;">Giá Bán</th>
                            <th scope="col" class="text-center" style="width: 10%;">Tồn Kho</th>
                            <th scope="col" class="text-center" style="width: 10%;">Trạng Thái</th>
                            <th scope="col" class="text-end pe-4" style="width: 13%;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty listproduct}">
                                <tr>
                                    <td colspan="8" class="text-center py-5 text-muted">
                                        <div class="py-4">
                                            <i class="bi bi-box2 fs-1 text-secondary opacity-50 d-block mb-2"></i>
                                            <h6 class="fw-bold text-dark">Chưa có sản phẩm nào trong kho</h6>
                                            <p class="small text-muted mb-3">Hãy bấm "Thêm Sản Phẩm Mới" để đăng bán mặt hàng đầu tiên.</p>
                                            <a href="<c:url value='/admin/product/add'/>" class="btn btn-sm btn-primary rounded-pill px-3">
                                                <i class="bi bi-plus me-1"></i>Thêm sản phẩm
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listproduct}" var="p" varStatus="STT">
                                    <tr>
                                        <td class="text-center fw-semibold text-muted">${STT.index + 1}</td>
                                        <td>
                                            <div class="rounded-3 border overflow-hidden d-flex align-items-center justify-content-center bg-light" style="width: 60px; height: 50px;">
                                                <c:choose>
                                                    <c:when test="${empty p.images}">
                                                        <i class="bi bi-image text-muted fs-4"></i>
                                                    </c:when>
                                                    <c:when test="${p.images.startsWith('http')}">
                                                        <img src="${p.images}" alt="${p.productName}" 
                                                             style="width: 100%; height: 100%; object-fit: cover;" 
                                                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url value="/image?fname=${p.images}" var="imgUrl"/>
                                                        <img src="${imgUrl}" alt="${p.productName}" 
                                                             style="width: 100%; height: 100%; object-fit: cover;" 
                                                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80';" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-dark text-truncate" style="max-width: 240px;" title="${p.productName}">
                                                ${p.productName}
                                            </div>
                                            <span class="badge bg-light text-secondary border px-2 py-0.5 small" style="font-size: 0.72rem;">ID: #${p.productId}</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2.5 py-1 rounded-pill small">
                                                <i class="bi bi-tag-fill me-1"></i>${p.category != null ? p.category.categoryname : 'Chưa phân loại'}
                                            </span>
                                        </td>
                                        <td class="text-end fw-bold text-danger fs-6">
                                            <fmt:formatNumber value="${p.price}" pattern="#,##0" /> đ
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${p.quantity > 0}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1 rounded-pill small fw-semibold">
                                                        ${p.quantity} sp
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2.5 py-1 rounded-pill small fw-semibold">
                                                        Hết hàng
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${p.status == 1}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1 rounded-pill small fw-semibold">
                                                        <i class="bi bi-check-circle-fill me-1"></i>Đang bán
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border px-2.5 py-1 rounded-pill small fw-semibold">
                                                        <i class="bi bi-eye-slash-fill me-1"></i>Tạm ẩn
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <div class="btn-group btn-group-sm shadow-xs">
                                                <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-outline-primary px-2.5 py-1.5" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil-square me-1"></i>Sửa
                                                </a>
                                                <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn btn-outline-danger px-2.5 py-1.5" 
                                                   onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?');" title="Xóa sản phẩm">
                                                    <i class="bi bi-trash me-1"></i>Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
