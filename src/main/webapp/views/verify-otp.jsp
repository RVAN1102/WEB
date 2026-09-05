<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - Kích Hoạt Tài Khoản | Shopping MVC</title>
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
        .otp-card {
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
        .otp-input {
            letter-spacing: 12px;
            font-family: var(--font-mono);
            font-size: 24px !important;
            font-weight: 700;
            text-align: center;
            padding: 0.625rem 0.5rem;
            border: 1.5px solid #cbd5e1;
            border-radius: 4px;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .otp-input:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.12);
        }
        .form-control {
            border-radius: 4px;
            padding: 0.625rem 0.875rem;
            border: 1px solid #cbd5e1;
        }
        .form-control:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.12);
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
    <div class="otp-card">
        <span class="brand-badge">XÁC MINH DANH TÍNH // OTP</span>
        <h1 class="h4 fw-bold text-dark mb-1">
            SHOPPING<span style="color: var(--accent-primary);">.</span>MVC
        </h1>
        <p class="text-secondary small mb-4">Nhập mã xác thực 6 chữ số vừa được gửi đến email đăng ký của bạn</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show small text-start d-flex align-items-center gap-2 rounded-1 mb-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill fs-6 flex-shrink-0"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show small text-start d-flex align-items-center gap-2 rounded-1 mb-3" role="alert">
                <i class="bi bi-check-circle-fill fs-6 flex-shrink-0"></i>
                <div>${message}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="<c:url value='/verify-otp'/>" method="post" class="needs-validation text-start" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold small text-dark font-mono mb-1" style="font-size: 0.8125rem;">TÀI KHOẢN KÍCH HOẠT</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 rounded-start-1"><i class="bi bi-person text-secondary"></i></span>
                    <input type="text" id="username" name="username" value="${username}" class="form-control border-start-0 rounded-end-1 font-mono" required 
                           <c:if test="${not empty username}">readonly style="background-color: #f8fafc;"</c:if>/>
                </div>
            </div>

            <div class="mb-4">
                <label for="otp" class="form-label fw-semibold small text-dark d-flex justify-content-between font-mono mb-1" style="font-size: 0.8125rem;">
                    <span>MÃ XÁC THỰC OTP</span>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i>Hạn: 5 phút</span>
                </label>
                <input type="text" id="otp" name="otp" class="form-control otp-input" maxlength="6" 
                       placeholder="••••••" pattern="^[0-9]{6}$" required autofocus />
                <div class="invalid-feedback text-center font-mono small">
                    Mã xác thực OTP phải gồm đúng 6 chữ số.
                </div>
            </div>

            <button type="submit" class="btn btn-editorial-submit w-100">
                <i class="bi bi-check2-circle me-1.5"></i> Xác Nhận Kích Hoạt
            </button>
        </form>

        <div class="mt-4 pt-3 border-top small text-secondary">
            <p class="mb-1">Không nhận được mã? <a href="<c:url value='/resend-otp?username=${username}'/>" class="text-decoration-none fw-bold" style="color: var(--accent-primary);">Gửi lại mã OTP</a></p>
            <p class="mb-0"><a href="<c:url value='/login'/>" class="text-decoration-none text-muted font-mono">&larr; Quay lại đăng nhập</a></p>
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
