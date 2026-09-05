<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="admin-sidebar p-3" id="adminSidebar">
    <!-- Brand Logo -->
    <div class="d-flex align-items-center gap-2 pb-3 mb-3 border-bottom border-secondary border-opacity-25 px-2">
        <span class="brand-dot"></span>
        <div>
            <div class="fw-bold text-white lh-1 fs-5 font-mono">SHOPPING<span class="text-primary">MVC</span></div>
            <span class="text-muted small fw-medium font-mono" style="font-size: 0.7rem; letter-spacing: 0.06em;">QUẢN LÝ BÁN LẺ</span>
        </div>
    </div>

    <!-- Admin Profile Badge -->
    <div class="p-2.5 rounded-2 mb-3 border border-secondary border-opacity-25 d-flex align-items-center gap-2.5" style="background: rgba(255,255,255,0.04);">
        <div class="rounded-circle bg-white text-dark d-flex align-items-center justify-content-center fw-bold font-mono" style="width: 34px; height: 34px; flex-shrink: 0; font-size: 0.85rem;">
            ${not empty sessionScope.account.fullName ? sessionScope.account.fullName.substring(0,1) : 'A'}
        </div>
        <div class="overflow-hidden">
            <div class="text-white fw-semibold small text-truncate mb-0">${sessionScope.account != null ? sessionScope.account.fullName : 'Quản trị viên'}</div>
            <span class="text-muted small font-mono" style="font-size: 0.7rem;">Quản trị viên kho hàng</span>
        </div>
    </div>

    <!-- Navigation Menu -->
    <c:set var="reqUri" value="${requestScope['jakarta.servlet.forward.request_uri']}"/>
    <ul class="nav nav-pills flex-column mb-auto gap-1">
        <li class="nav-item">
            <a href="<c:url value='/admin/home'/>" class="nav-link ${reqUri != null && reqUri.contains('/admin/home') ? 'active' : ''}">
                <i class="bi bi-speedometer2 fs-5"></i>
                <span>Bảng Điều Khiển</span>
            </a>
        </li>

        <li class="text-uppercase text-secondary small fw-bold px-3 pt-3 pb-1 font-mono" style="font-size: 0.6875rem; letter-spacing: 0.08em;">KHO HÀNG & MẶT HÀNG</li>
        <li class="nav-item">
            <a href="<c:url value='/admin/products'/>" class="nav-link ${reqUri != null && reqUri.contains('/admin/product') ? 'active' : ''}">
                <i class="bi bi-box-seam fs-5"></i>
                <span>Danh sách sản phẩm</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<c:url value='/admin/categories'/>" class="nav-link ${reqUri != null && reqUri.contains('/admin/categor') ? 'active' : ''}">
                <i class="bi bi-folder2-open fs-5"></i>
                <span>Danh mục sản phẩm</span>
            </a>
        </li>

        <li class="text-uppercase text-secondary small fw-bold px-3 pt-3 pb-1 font-mono" style="font-size: 0.6875rem; letter-spacing: 0.08em;">TÀI KHOẢN & HỆ THỐNG</li>
        <li class="nav-item">
            <a href="<c:url value='/myprofile'/>" class="nav-link ${reqUri != null && reqUri.contains('/myprofile') ? 'active' : ''}">
                <i class="bi bi-person-gear fs-5"></i>
                <span>Hồ sơ cá nhân</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<c:url value='/home'/>" class="nav-link" target="_blank">
                <i class="bi bi-box-arrow-up-right fs-5"></i>
                <span>Xem cửa hàng bán lẻ</span>
            </a>
        </li>
    </ul>

    <!-- Bottom Logout -->
    <div class="mt-auto pt-3 border-top border-secondary border-opacity-25">
        <a href="<c:url value='/logout'/>" class="nav-link text-danger d-flex align-items-center gap-2 p-2 rounded-2">
            <i class="bi bi-box-arrow-left fs-5"></i>
            <span class="fw-semibold small">Đăng xuất</span>
        </a>
    </div>
</aside>
