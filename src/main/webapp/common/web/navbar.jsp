<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="sub-nav-bar navbar navbar-expand-md py-0">
    <div class="container">
        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler border-0 py-2" type="button" data-bs-toggle="collapse" 
                data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-md-0 gap-lg-1">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.endsWith('/home') || pageContext.request.requestURI.endsWith('/') ? 'active text-primary' : ''}" 
                       href="<c:url value='/home'/>">
                        Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('/product') ? 'active text-primary' : ''}" 
                       href="<c:url value='/product'/>">
                        Tất Cả Sản Phẩm
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="categoryDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Danh Mục
                    </a>
                    <ul class="dropdown-menu shadow-sm border rounded-2 py-1 mt-1" aria-labelledby="categoryDropdown" style="min-width: 220px;">
                        <li><a class="dropdown-item small py-2" href="<c:url value='/product?cid=3'/>">Điện thoại di động</a></li>
                        <li><a class="dropdown-item small py-2" href="<c:url value='/product?cid=4'/>">Máy tính bảng</a></li>
                        <li><a class="dropdown-item small py-2" href="<c:url value='/product?cid=5'/>">Laptop & Máy tính</a></li>
                        <li><a class="dropdown-item small py-2" href="<c:url value='/product?cid=6'/>">Tai nghe & Thiết bị âm thanh</a></li>
                        <li><a class="dropdown-item small py-2" href="<c:url value='/product?cid=7'/>">Đồng hồ thông minh</a></li>
                        <li><hr class="dropdown-divider my-1"></li>
                        <li><a class="dropdown-item small py-2 text-primary fw-semibold" href="<c:url value='/product'/>">Xem toàn bộ kho hàng &raquo;</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/product'/>">
                        Sản Phẩm Mới
                    </a>
                </li>
            </ul>

            <div class="d-none d-lg-flex align-items-center gap-3 font-mono text-muted small" style="font-size: 0.75rem;">
                <span>HÀNG CHÍNH HÃNG 100%</span>
                <span class="opacity-40">/</span>
                <span>BẢO HÀNH 12 THÁNG</span>
                <span class="opacity-40">/</span>
                <span>ĐỔI TRẢ 30 NGÀY</span>
            </div>
        </div>
    </div>
</nav>
