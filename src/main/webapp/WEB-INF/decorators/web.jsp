<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title><sitemesh:write property="title"/> - Shopping MVC</title>

    <!-- Google Fonts: Plus Jakarta Sans (Body & Display) + JetBrains Mono (Technical Data & Specs) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons 1.11.3 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Shopping MVC Custom Theme CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/css/theme.css'/>">

    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100">
    <!-- 1. Top Utility Bar -->
    <div class="top-utility-bar">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-3">
                <span><i class="bi bi-shield-check text-primary me-1"></i>Hệ thống phân phối thiết bị công nghệ chính hãng</span>
                <span class="d-none d-md-inline opacity-50">&bull;</span>
                <span class="d-none d-md-inline">Miễn phí giao hàng cho đơn từ 500.000₫</span>
            </div>
            <div class="d-flex align-items-center gap-3">
                <span class="d-none d-sm-inline">Hotline: <strong>1800 6868</strong></span>
                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <span class="opacity-50">&bull;</span>
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <a href="<c:url value='/admin/home'/>" class="fw-semibold text-white">Quản trị</a>
                        </c:if>
                        <a href="<c:url value='/myprofile'/>">Tài khoản</a>
                        <a href="<c:url value='/logout'/>" class="text-danger">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <span class="opacity-50">&bull;</span>
                        <a href="<c:url value='/login'/>">Đăng nhập</a>
                        <a href="<c:url value='/register'/>" class="fw-semibold text-white">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- 2. Header (Brand & Primary Search) -->
    <%@ include file="/common/web/header.jsp"%>

    <!-- 3. Navigation Bar (Categories & Pages) -->
    <%@ include file="/common/web/navbar.jsp"%>

    <!-- 4. Dynamic Page Content -->
    <main class="flex-grow-1">
        <sitemesh:write property="body"/>
    </main>

    <!-- 5. Footer -->
    <%@ include file="/common/web/footer.jsp"%>

    <!-- Global Toast Feedback -->
    <div id="ecommerceToast" class="ecommerce-toast" role="status" aria-live="polite">
        <i class="bi bi-check-circle-fill text-success fs-6"></i>
        <span id="toastMessage">Thao tác thành công</span>
    </div>

    <!-- Bootstrap 5 Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.showToast = function(message) {
            const toast = document.getElementById('ecommerceToast');
            const toastMsg = document.getElementById('toastMessage');
            if (toast && toastMsg) {
                toastMsg.innerText = message || 'Thao tác thành công';
                toast.classList.add('show');
                setTimeout(() => {
                    toast.classList.remove('show');
                }, 2600);
            }
        };
    </script>
</body>
</html>