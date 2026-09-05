<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển Quản Trị - Shopping MVC</title>
</head>
<body>
    <div class="py-2">
        <!-- Welcome Header Banner -->
        <div class="p-4 p-lg-5 mb-4 rounded-3 text-white position-relative overflow-hidden" 
             style="background: var(--surface-dark); border: 1px solid rgba(255, 255, 255, 0.08);">
            <div class="row align-items-center position-relative z-2">
                <div class="col-lg-8">
                    <span class="font-mono text-uppercase small text-muted fw-bold d-block mb-2" style="letter-spacing: 0.1em;">
                        TRUNG TÂM VẬN HÀNH BÁN LẺ
                    </span>
                    <h1 class="h3 fw-bold text-white mb-2">Xin chào, ${sessionScope.account != null ? sessionScope.account.fullName : 'Quản trị viên'}</h1>
                    <p class="text-secondary small mb-3" style="max-width: 580px;">
                        Theo dõi tình trạng xuất nhập kho, điều chỉnh danh mục hàng hóa, kiểm soát số lượng sản phẩm tồn kho và kiểm tra chất lượng hiển thị trên cửa hàng trực tuyến.
                    </p>
                    <div class="d-flex gap-2 flex-wrap font-mono">
                        <a href="<c:url value='/admin/product/add'/>" class="btn btn-light btn-sm rounded-1 px-3 py-2 fw-semibold text-dark">
                            <i class="bi bi-plus me-1"></i>Thêm Sản Phẩm Mới
                        </a>
                        <a href="<c:url value='/admin/category/add'/>" class="btn btn-outline-light btn-sm rounded-1 px-3 py-2 fw-semibold">
                            <i class="bi bi-folder-plus me-1"></i>Thêm Danh Mục
                        </a>
                        <a href="<c:url value='/home'/>" class="btn btn-outline-secondary btn-sm rounded-1 px-3 py-2 text-white" target="_blank">
                            <i class="bi bi-box-arrow-up-right me-1"></i>Xem Cửa Hàng
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 text-end d-none d-lg-block">
                    <div class="p-3 rounded-2 border d-inline-block text-start font-mono" style="background: rgba(255,255,255,0.04); border-color: rgba(255,255,255,0.08) !important; width: 220px; font-size: 0.8125rem;">
                        <div class="text-muted small mb-1">TRẠNG THÁI HỆ THỐNG:</div>
                        <div class="text-success fw-bold d-flex align-items-center gap-1.5 mb-2">
                            <span>●</span>
                            <span>Sẵn sàng vận hành</span>
                        </div>
                        <div class="text-muted small mb-0.5">MÁY CHỦ CSDL:</div>
                        <div class="text-white fw-semibold">Kết nối thông suốt</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 4 Operational KPI Cards -->
        <div class="row g-3 mb-4">
            <!-- Metric 1: Products -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="admin-kpi-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="font-mono text-muted small text-uppercase" style="letter-spacing: 0.06em;">KHO HÀNG</span>
                            <i class="bi bi-box-seam text-primary fs-5"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">Danh Sách Mặt Hàng</h4>
                        <p class="text-muted small mb-0">Quản lý giá niêm yết, số lượng tồn kho và thông số kỹ thuật.</p>
                    </div>
                    <div class="mt-3 pt-3 border-top font-mono">
                        <a href="<c:url value='/admin/products'/>" class="text-decoration-none text-dark small fw-semibold d-flex align-items-center justify-content-between">
                            <span>Mở danh sách sản phẩm</span>
                            <span>&rarr;</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Metric 2: Categories -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="admin-kpi-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="font-mono text-muted small text-uppercase" style="letter-spacing: 0.06em;">PHÂN LOẠI</span>
                            <i class="bi bi-folder text-success fs-5"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">Danh Mục Sản Phẩm</h4>
                        <p class="text-muted small mb-0">Cơ cấu nhóm mặt hàng: Điện thoại, Laptop, Tablet, Phụ kiện.</p>
                    </div>
                    <div class="mt-3 pt-3 border-top font-mono">
                        <a href="<c:url value='/admin/categories'/>" class="text-decoration-none text-dark small fw-semibold d-flex align-items-center justify-content-between">
                            <span>Quản lý danh mục</span>
                            <span>&rarr;</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Metric 3: Security & Access -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="admin-kpi-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="font-mono text-muted small text-uppercase" style="letter-spacing: 0.06em;">BẢO MẬT</span>
                            <i class="bi bi-shield-check text-dark fs-5"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">Xác Thực Quản Trị</h4>
                        <p class="text-muted small mb-0">Kiểm soát phân quyền, cập nhật hồ sơ cá nhân và bảo mật tài khoản.</p>
                    </div>
                    <div class="mt-3 pt-3 border-top font-mono">
                        <a href="<c:url value='/myprofile'/>" class="text-decoration-none text-dark small fw-semibold d-flex align-items-center justify-content-between">
                            <span>Xem hồ sơ quản trị</span>
                            <span>&rarr;</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Metric 4: Storefront -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="admin-kpi-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="font-mono text-muted small text-uppercase" style="letter-spacing: 0.06em;">BÁN LẺ</span>
                            <i class="bi bi-shop text-dark fs-5"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">Giao Diện Khách Hàng</h4>
                        <p class="text-muted small mb-0">Kiểm tra trải nghiệm người dùng, giỏ hàng và danh mục trực quan.</p>
                    </div>
                    <div class="mt-3 pt-3 border-top font-mono">
                        <a href="<c:url value='/home'/>" class="text-decoration-none text-dark small fw-semibold d-flex align-items-center justify-content-between" target="_blank">
                            <span>Xem storefront</span>
                            <span>&rarr;</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Shortcut Actions Section -->
        <div class="admin-card p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6 class="fw-bold text-dark mb-0 font-mono text-uppercase" style="letter-spacing: 0.06em;">
                    THAO TÁC QUẢN LÝ NHANH
                </h6>
            </div>
            <div class="row g-3">
                <div class="col-12 col-md-4">
                    <a href="<c:url value='/admin/product/add'/>" class="card border p-3 text-decoration-none h-100 rounded-2 bg-light text-dark">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-box-seam fs-4 text-primary"></i>
                            <div>
                                <div class="fw-bold small mb-0">Đăng Sản Phẩm Mới</div>
                                <span class="text-muted small">Cập nhật thông số kỹ thuật, giá bán và ảnh</span>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-12 col-md-4">
                    <a href="<c:url value='/admin/category/add'/>" class="card border p-3 text-decoration-none h-100 rounded-2 bg-light text-dark">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-folder-plus fs-4 text-success"></i>
                            <div>
                                <div class="fw-bold small mb-0">Tạo Phân Loại Mới</div>
                                <span class="text-muted small">Thêm danh mục hàng hóa mới cho cửa hàng</span>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-12 col-md-4">
                    <a href="<c:url value='/home'/>" class="card border p-3 text-decoration-none h-100 rounded-2 bg-light text-dark" target="_blank">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-globe fs-4 text-dark"></i>
                            <div>
                                <div class="fw-bold small mb-0">Kiểm Tra Cửa Hàng</div>
                                <span class="text-muted small">Xem trang khách hàng trong tab mới</span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>