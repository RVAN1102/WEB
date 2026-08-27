<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị - Admin Dashboard</title>
    <style>
        :root {
            --primary-color: #007bff;
            --primary-hover: #0056b3;
            --success-color: #28a745;
            --success-hover: #218838;
            --bg-color: #f4f6f9;
            --text-color: #2d3436;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .welcome-banner {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
        }

        .welcome-banner h2 {
            margin: 0 0 10px 0;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .welcome-banner p {
            margin: 0;
            opacity: 0.9;
            font-size: 1rem;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
        }

        .dash-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .dash-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .dash-card .icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .dash-card h3 {
            margin: 0 0 10px 0;
            font-size: 1.3rem;
            color: #1a1a1a;
        }

        .dash-card p {
            color: #636e72;
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .btn-action {
            display: inline-block;
            text-align: center;
            padding: 12px 20px;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }

        .btn-action:hover {
            background-color: var(--primary-hover);
        }

        .btn-success {
            background-color: var(--success-color);
        }

        .btn-success:hover {
            background-color: var(--success-hover);
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="/common/web/topbar.jsp" %>

        <div class="welcome-banner">
            <h2> Bảng Điều Khiển Quản Trị Hệ Thống</h2>
            <p>Chào mừng Quản trị viên! Quản lý thông tin danh mục, sản phẩm và dữ liệu hệ thống tại đây.</p>
        </div>

        <div class="dashboard-grid">
            <!-- Card Quản lý Danh mục (Chức năng JPA) -->
            <div class="dash-card">
                <div>
                    <div class="icon">📂</div>
                    <h3>Quản lý Danh mục</h3>
                    <p>Thêm, sửa, xóa và thay đổi trạng thái ẩn/hiện của các danh mục sản phẩm trong hệ thống bằng JPA.</p>
                </div>
                <a href="<c:url value='/admin/categories'/>" class="btn-action btn-success">
                    Truy cập Quản lý Danh mục →
                </a>
            </div>

            <!-- Card Quản lý Video / Sản phẩm -->
            <div class="dash-card">
                <div>
                    <div class="icon">🎬</div>
                    <h3>Quản lý Video / Sản phẩm</h3>
                    <p>Quản lý danh sách video bài giảng hoặc sản phẩm liên kết với từng danh mục trong cơ sở dữ liệu.</p>
                </div>
                <a href="#" class="btn-action" style="background-color: #6c757d; cursor: not-allowed;" onclick="alert('Tính năng đang được phát triển!'); return false;">
                    Đang cập nhật...
                </a>
            </div>

            <!-- Card Thống kê Hệ thống -->
            <div class="dash-card">
                <div>
                    <div class="icon">📊</div>
                    <h3>Thống kê & Báo cáo</h3>
                    <p>Xem tổng quan về số lượng danh mục, tổng sản phẩm và hoạt động tương tác trong hệ thống.</p>
                </div>
                <a href="#" class="btn-action" style="background-color: #6c757d; cursor: not-allowed;" onclick="alert('Tính năng đang được phát triển!'); return false;">
                    Đang cập nhật...
                </a>
            </div>
        </div>
    </div>
</body>
</html>