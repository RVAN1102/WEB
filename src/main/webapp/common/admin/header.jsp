<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="navbar navbar-expand sticky-top bg-white border-bottom px-4 py-2.5 shadow-xs" style="z-index: 1010; border-color: #e2e8f0 !important;">
    <div class="container-fluid px-0 d-flex justify-content-between align-items-center">
        <!-- Left: Toggle & Title -->
        <div class="d-flex align-items-center gap-3">
            <button class="btn btn-sm btn-outline-secondary d-md-none rounded-2" type="button" data-bs-toggle="collapse" data-bs-target="#adminSidebar">
                <i class="bi bi-list fs-5"></i>
            </button>
            <div class="d-flex align-items-center gap-2">
                <span class="badge bg-light text-dark border rounded-1 px-2.5 py-1 small fw-semibold font-mono">
                    HỆ THỐNG QUẢN TRỊ BÁN LẺ
                </span>
                <span class="text-muted small d-none d-lg-inline">• Shopping MVC Retail Operation Platform</span>
            </div>
        </div>

        <!-- Right Side Nav Actions -->
        <div class="d-flex align-items-center gap-2.5">
            <!-- View Storefront Button -->
            <a href="<c:url value='/home'/>" class="btn btn-outline-dark btn-sm rounded-1 px-3 py-1.5 fw-semibold d-inline-flex align-items-center gap-1.5" target="_blank">
                <i class="bi bi-shop"></i>
                <span class="d-none d-sm-inline">Xem Cửa Hàng</span>
            </a>

            <!-- User Menu Dropdown -->
            <div class="dropdown">
                <button class="btn btn-light border btn-sm rounded-1 px-3 py-1.5 d-flex align-items-center gap-2 dropdown-toggle" type="button" id="adminDropdownMenu" data-bs-toggle="dropdown">
                    <span class="rounded-circle bg-dark text-white small fw-bold d-inline-flex align-items-center justify-content-center font-mono" style="width: 22px; height: 22px; font-size: 0.75rem;">
                        ${not empty sessionScope.account.fullName ? sessionScope.account.fullName.substring(0,1) : 'A'}
                    </span>
                    <span class="small fw-semibold text-dark d-none d-sm-inline">
                        ${sessionScope.account != null ? sessionScope.account.fullName : 'Admin'}
                    </span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-sm border rounded-2 mt-1 py-1" aria-labelledby="adminDropdownMenu" style="min-width: 200px;">
                    <li class="px-3 py-2 border-bottom">
                        <div class="small fw-bold text-dark">${sessionScope.account != null ? sessionScope.account.fullName : 'Admin'}</div>
                        <div class="text-muted small font-mono">Quản trị viên kho hàng</div>
                    </li>
                    <li><a class="dropdown-item py-2 small" href="<c:url value='/myprofile'/>"><i class="bi bi-person me-2"></i>Hồ sơ cá nhân</a></li>
                    <li><a class="dropdown-item py-2 small" href="<c:url value='/admin/categories'/>"><i class="bi bi-folder me-2"></i>Quản lý danh mục</a></li>
                    <li><a class="dropdown-item py-2 small" href="<c:url value='/admin/products'/>"><i class="bi bi-box-seam me-2"></i>Quản lý sản phẩm</a></li>
                    <li><hr class="dropdown-divider my-1"></li>
                    <li><a class="dropdown-item py-2 small text-danger fw-semibold" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-left me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
