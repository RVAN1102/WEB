<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="referrer" content="no-referrer">
    <title>Quản Lý Danh Mục Sản Phẩm</title>
</head>
<body>
    <div class="py-2">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="badge bg-light text-dark border rounded-1 px-2.5 py-1 small fw-semibold font-mono">
                        <i class="bi bi-folder2 me-1"></i>PHÂN LOẠI HÀNG HÓA
                    </span>
                </div>
                <h3 class="fw-bold mb-0 text-dark">Danh Mục Sản Phẩm</h3>
                <p class="text-muted mb-0 small">Quản lý các nhóm phân loại hàng hóa đang phân phối trên hệ thống</p>
            </div>
            <div class="d-flex gap-2">
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary rounded-pill px-3.5 py-2 fw-semibold shadow-sm d-inline-flex align-items-center gap-2">
                    <i class="bi bi-plus-circle-fill"></i>
                    <span>Thêm Danh Mục Mới</span>
                </a>
            </div>
        </div>

        <!-- Table Card -->
        <div class="card admin-card overflow-hidden">
            <div class="p-3 border-bottom bg-white d-flex justify-content-between align-items-center flex-wrap gap-2">
                <span class="fw-bold text-dark small text-uppercase" style="letter-spacing: 0.05em;">
                    <i class="bi bi-table text-primary me-2"></i>Tất Cả Danh Mục
                </span>
                <span class="badge bg-light text-muted border px-2.5 py-1.5 rounded-pill small">
                    Tổng: <strong class="text-primary">${not empty listcate ? listcate.size() : 0}</strong> danh mục
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-custom align-middle mb-0">
                    <thead>
                        <tr>
                            <th scope="col" class="text-center" style="width: 5%;">#</th>
                            <th scope="col" style="width: 15%;">Hình Ảnh</th>
                            <th scope="col" style="width: 40%;">Tên Danh Mục</th>
                            <th scope="col" class="text-center" style="width: 20%;">Trạng Thái</th>
                            <th scope="col" class="text-end pe-4" style="width: 20%;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty listcate}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <div class="py-4">
                                            <i class="bi bi-inbox fs-1 text-secondary opacity-50 d-block mb-2"></i>
                                            <h6 class="fw-bold text-dark">Chưa có danh mục nào</h6>
                                            <p class="small text-muted mb-3">Hãy bấm "Thêm Danh Mục Mới" để tạo phân loại hàng đầu tiên.</p>
                                            <a href="<c:url value='/admin/category/add'/>" class="btn btn-sm btn-primary rounded-pill px-3">
                                                <i class="bi bi-plus me-1"></i>Thêm ngay
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listcate}" var="cate" varStatus="STT">
                                    <tr>
                                        <td class="text-center fw-semibold text-muted">${STT.index + 1}</td>
                                        <td>
                                            <div class="rounded-3 border overflow-hidden d-flex align-items-center justify-content-center bg-light" style="width: 60px; height: 50px;">
                                                <c:choose>
                                                    <c:when test="${empty cate.images}">
                                                        <i class="bi bi-image text-muted fs-4"></i>
                                                    </c:when>
                                                    <c:when test="${cate.images.startsWith('http')}">
                                                        <img src="${cate.images}" alt="${cate.categoryname}" 
                                                             style="width: 100%; height: 100%; object-fit: cover;" 
                                                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                                        <img src="${imgUrl}" alt="${cate.categoryname}" 
                                                             style="width: 100%; height: 100%; object-fit: cover;" 
                                                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-dark fs-6 mb-0.5">${cate.categoryname}</div>
                                            <span class="badge bg-light text-secondary border px-2 py-0.5 small" style="font-size: 0.72rem;">ID: #${cate.categoryid}</span>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.status == 1}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill fw-semibold small">
                                                        <i class="bi bi-check-circle-fill me-1"></i>Hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border px-3 py-1.5 rounded-pill fw-semibold small">
                                                        <i class="bi bi-lock-fill me-1"></i>Đã khóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <div class="btn-group btn-group-sm shadow-xs">
                                                <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-outline-primary px-2.5 py-1.5" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil-square me-1"></i>Sửa
                                                </a>
                                                <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-outline-danger px-2.5 py-1.5" 
                                                   onclick="return confirm('Bạn chắc chắn muốn xóa danh mục này?');" title="Xóa danh mục">
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