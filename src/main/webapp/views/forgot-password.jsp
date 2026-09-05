<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Shopping MVC</title>
    <!-- Google Fonts: Plus Jakarta Sans & JetBrains Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --font-sans: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            --font-mono: 'JetBrains Mono', monospace;
            --bg-canvas: #f8fafc;
            --bg-surface: #ffffff;
            --border-subtle: #e2e8f0;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --accent-primary: #0284c7;
        }
        body {
            font-family: var(--font-sans);
            background-color: var(--bg-canvas);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px 16px;
            color: var(--text-primary);
        }
        .font-mono {
            font-family: var(--font-mono);
        }
        .auth-card {
            background: var(--bg-surface);
            border: 1px solid var(--border-subtle);
            border-radius: 6px;
            box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05);
            max-width: 440px;
            width: 100%;
            padding: 36px 32px;
            text-align: center;
        }
        .brand-badge {
            font-family: var(--font-mono);
            font-size: 0.6875rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--text-secondary);
            display: inline-block;
            margin-bottom: 8px;
            padding: 2px 8px;
            background-color: #f1f5f9;
            border: 1px solid var(--border-subtle);
            border-radius: 4px;
        }
        .form-control {
            border-radius: 4px;
            padding: 0.625rem 0.875rem;
            border: 1px solid #cbd5e1;
            font-size: 0.9375rem;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .form-control:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.12);
        }
        .input-group-text {
            border-radius: 4px 0 0 4px;
            background-color: #f8fafc;
            border: 1px solid #cbd5e1;
            border-right: none;
            color: var(--text-secondary);
        }
        .input-group .form-control {
            border-radius: 0 4px 4px 0;
        }
        .btn-editorial-submit {
            background-color: #0f172a;
            color: #ffffff;
            border: 1px solid #0f172a;
            border-radius: 4px;
            padding: 0.75rem 1.25rem;
            font-weight: 600;
            font-size: 0.9375rem;
            transition: all 0.15s ease;
        }
        .btn-editorial-submit:hover {
            background-color: #1e293b;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <span class="brand-badge">KHÔI PHỤC TRUY CẬP // QUÊN MẬT KHẨU</span>
        <h1 class="h4 fw-bold text-dark mb-1">
            SHOPPING<span style="color: var(--accent-primary);">.</span>MVC
        </h1>
        <p class="text-secondary small mb-4">Nhập email hoặc tên tài khoản để nhận mã xác thực khôi phục mật khẩu</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show small text-start d-flex align-items-center gap-2 rounded-1 mb-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill fs-6 flex-shrink-0"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="<c:url value='/forgot-password'/>" method="post" class="needs-validation text-start" novalidate>
            <div class="mb-4">
                <label for="account_input" class="form-label fw-semibold small text-dark font-mono mb-1" style="font-size: 0.8125rem;">EMAIL HOẶC TÊN TÀI KHOẢN (*)</label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-person-bounding-box"></i></span>
                    <input type="text" id="account_input" name="account_input" class="form-control font-mono" 
                           placeholder="Nhập email hoặc username..." required autofocus />
                    <div class="invalid-feedback">
                        Vui lòng nhập Email hoặc Tên tài khoản.
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-editorial-submit w-100">
                <i class="bi bi-send me-1.5"></i> Gửi Mã Xác Thực OTP
            </button>
        </form>

        <div class="mt-4 pt-3 border-top small text-secondary">
            <a href="<c:url value='/login'/>" class="text-decoration-none fw-bold" style="color: var(--accent-primary);">&larr; Quay lại đăng nhập</a>
        </div>
    </div>

    <!-- Bootstrap 5 Validation -->
    <script>
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
