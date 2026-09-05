<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title><sitemesh:write property="title"/> - Quản Trị Hệ Thống | Shopping MVC</title>

    <!-- Google Fonts: Plus Jakarta Sans & JetBrains Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Shopping MVC Custom Theme CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/css/theme.css'/>">

    <style>
        :root {
            --admin-primary: #1d4ed8;
            --admin-primary-hover: #1e40af;
            --admin-bg: #f8fafc;
            --admin-sidebar-bg: #090d14;
            --admin-card-bg: #ffffff;
            --admin-border: #e2e8f0;
            --font-sans: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            --font-mono: 'JetBrains Mono', monospace;
        }
        body {
            font-family: var(--font-sans);
            background-color: var(--admin-bg);
            color: #090d15;
            min-height: 100vh;
        }
        .admin-main-wrapper {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
            overflow-x: hidden;
        }
        .table-custom th {
            background-color: #f8fafc;
            color: #475569;
            font-family: var(--font-mono);
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            padding: 0.85rem 1rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .table-custom td {
            padding: 0.9rem 1rem;
            vertical-align: middle;
            color: #1e293b;
            font-size: 0.875rem;
            border-bottom: 1px solid #f1f5f9;
        }
        .table-custom tr:hover td {
            background-color: #f8fafc;
        }
    </style>

    <sitemesh:write property="head"/>
</head>
<body>
    <div class="d-flex min-vh-100">
        <!-- 1. Left Sidebar -->
        <%@ include file="/common/admin/left.jsp"%>

        <!-- 2. Main Content Wrapper -->
        <div class="admin-main-wrapper">
            <!-- Admin Topbar Header -->
            <%@ include file="/common/admin/header.jsp"%>

            <!-- Page Body -->
            <main class="container-fluid px-4 py-4 flex-grow-1">
                <sitemesh:write property="body"/>
            </main>

            <!-- Admin Footer -->
            <%@ include file="/common/admin/footer.jsp"%>
        </div>
    </div>

    <!-- Bootstrap 5.3.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
