<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="main-site-header py-3">
    <div class="container d-flex align-items-center justify-content-between gap-3">
        <!-- 1. Architectural Brand Logo -->
        <a href="<c:url value='/home'/>" class="site-brand-logo">
            <span class="brand-dot"></span>
            <span>SHOPPING<span class="text-primary fw-bold">MVC</span></span>
        </a>

        <!-- 2. Integrated Search Bar -->
        <form action="<c:url value='/product'/>" method="get" class="header-search-form d-none d-md-block">
            <input type="text" name="search" class="header-search-input" 
                   value="${keyword != null ? keyword : ''}"
                   placeholder="Tìm kiếm sản phẩm, thương hiệu, linh kiện..." />
            <button class="header-search-submit" type="submit" aria-label="Tìm kiếm">
                <i class="bi bi-search"></i>
            </button>
        </form>

        <!-- 3. Direct Actions & Account -->
        <div class="d-flex align-items-center gap-2">
            <!-- Mobile Search Icon trigger -->
            <a href="<c:url value='/product'/>" class="btn btn-sm btn-outline-secondary d-md-none rounded-2 p-2">
                <i class="bi bi-search"></i>
            </a>

            <!-- Cart Action -->
            <a href="<c:url value='/product'/>" class="btn btn-outline-dark btn-sm rounded-2 px-3 py-2 d-inline-flex align-items-center gap-2" title="Giỏ hàng">
                <i class="bi bi-bag fs-6"></i>
                <span class="d-none d-sm-inline fw-semibold small">Giỏ Hàng</span>
                <span class="badge bg-dark text-white rounded-1 font-mono" style="font-size: 0.7rem;">0</span>
            </a>

            <!-- User Menu -->
            <c:choose>
                <c:when test="${sessionScope.account != null}">
                    <div class="dropdown">
                        <button class="btn btn-light btn-sm border rounded-2 px-2.5 py-1.5 d-flex align-items-center gap-2 dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <span class="rounded-circle bg-dark text-white small fw-bold d-inline-flex align-items-center justify-content-center" style="width: 22px; height: 22px; font-size: 0.7rem;">
                                ${sessionScope.account.fullName != null ? sessionScope.account.fullName.substring(0,1) : 'U'}
                            </span>
                            <span class="small fw-semibold text-dark d-none d-lg-inline">
                                ${sessionScope.account.fullName != null ? sessionScope.account.fullName : sessionScope.account.userName}
                            </span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow-sm border rounded-2 py-1 mt-1" style="min-width: 210px;">
                            <li class="px-3 py-2 border-bottom">
                                <div class="small fw-bold text-dark">${sessionScope.account.fullName}</div>
                                <div class="text-muted small font-mono">${sessionScope.account.email}</div>
                            </li>
                            <c:if test="${sessionScope.account.roleid == 1}">
                                <li><a class="dropdown-item small py-2 text-primary fw-semibold" href="<c:url value='/admin/home'/>"><i class="bi bi-speedometer2 me-2"></i>Bảng điều khiển quản trị</a></li>
                                <li><hr class="dropdown-divider my-1"></li>
                            </c:if>
                            <li><a class="dropdown-item small py-2" href="<c:url value='/myprofile'/>"><i class="bi bi-person me-2"></i>Hồ sơ tài khoản</a></li>
                            <li><hr class="dropdown-divider my-1"></li>
                            <li><a class="dropdown-item small py-2 text-danger fw-semibold" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/login'/>" class="btn btn-primary btn-sm rounded-2 px-3 py-2 fw-semibold small">
                        Đăng Nhập
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
