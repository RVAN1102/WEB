<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - Shopping MVC</title>
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
            --border-strong: #0f172a;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --text-muted: #94a3b8;
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
        .register-card {
            background: var(--bg-surface);
            border: 1px solid var(--border-subtle);
            border-radius: 6px;
            box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05);
            max-width: 520px;
            width: 100%;
            padding: 36px 32px;
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
    <div class="register-card">
        <!-- Brand Header -->
        <div class="text-center mb-4">
            <span class="brand-badge">THÀNH VIÊN MỚI // ĐĂNG KÝ HỒ SƠ</span>
            <h1 class="h4 fw-bold text-dark mb-1">
                SHOPPING<span style="color: var(--accent-primary);">.</span>MVC
            </h1>
            <p class="text-secondary small mb-0">Tạo tài khoản để theo dõi đơn hàng và nhận thông tin khuyến mãi</p>
        </div>

        <!-- Alert messages -->
        <c:if test="${not empty alert}">
            <div class="alert alert-danger alert-dismissible fade show small d-flex align-items-center gap-2 rounded-1 mb-3" role="alert">
                <i class="bi bi-exclamation-octagon-fill fs-6 flex-shrink-0"></i>
                <div>${alert}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show small d-flex align-items-center gap-2 rounded-1 mb-3" role="alert">
                <i class="bi bi-check-circle-fill fs-6 flex-shrink-0"></i>
                <div>${message}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
            <!-- Username -->
            <div class="mb-3">
                <label class="form-label fw-semibold small text-dark mb-1 font-mono" style="font-size: 0.8125rem;">TÊN ĐĂNG NHẬP <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                    <input type="text" name="username" value="${user.username}" class="form-control font-mono" 
                           placeholder="3-30 ký tự (chữ cái, số, gạch dưới)" 
                           pattern="^[a-zA-Z0-9_]{3,30}$" required autofocus>
                    <div class="invalid-feedback">
                        Tên đăng nhập từ 3-30 ký tự, không chứa ký tự đặc biệt hoặc khoảng trắng.
                    </div>
                </div>
            </div>

            <!-- Fullname -->
            <div class="mb-3">
                <label class="form-label fw-semibold small text-dark mb-1 font-mono" style="font-size: 0.8125rem;">HỌ VÀ TÊN <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" name="fullname" value="${user.fullname}" class="form-control" 
                           placeholder="Họ và tên đầy đủ" minlength="2" maxlength="100" required>
                    <div class="invalid-feedback">
                        Vui lòng nhập họ và tên (tối thiểu 2 ký tự).
                    </div>
                </div>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label fw-semibold small text-dark mb-1 font-mono" style="font-size: 0.8125rem;">ĐỊA CHỈ EMAIL <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" name="email" value="${user.email}" class="form-control font-mono" 
                           placeholder="name@domain.com" required>
                    <div class="invalid-feedback">
                        Vui lòng nhập email đúng định dạng (dùng để nhận OTP).
                    </div>
                </div>
            </div>

            <!-- Phone -->
            <div class="mb-3">
                <label class="form-label fw-semibold small text-dark mb-1 font-mono" style="font-size: 0.8125rem;">SỐ ĐIỆN THOẠI <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                    <input type="tel" name="phone" value="${user.phone}" class="form-control font-mono" 
                           placeholder="VD: 0901234567 (10 chữ số)" 
                           pattern="^(0[3|5|7|8|9])[0-9]{8}$" required>
                    <div class="invalid-feedback">
                        Vui lòng nhập số điện thoại Việt Nam hợp lệ (10 chữ số: 03x, 05x, 07x, 08x, 09x).
                    </div>
                </div>
            </div>

            <!-- Password -->
            <div class="mb-4">
                <label class="form-label fw-semibold small text-dark mb-1 font-mono" style="font-size: 0.8125rem;">MẬT KHẨU <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" name="password" id="registerPassword" class="form-control font-mono" 
                           placeholder="Tối thiểu 6 ký tự" minlength="6" required>
                    <button class="btn btn-outline-secondary border-start-0 border-top border-bottom border-end rounded-end" type="button" onclick="togglePasswordVisibility('registerPassword', this)">
                        <i class="bi bi-eye"></i>
                    </button>
                    <div class="invalid-feedback">
                        Mật khẩu phải có tối thiểu 6 ký tự.
                    </div>
                </div>
            </div>

            <!-- Terms agreement note -->
            <div class="mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="agreeTerms" required checked>
                    <label class="form-check-label small text-secondary user-select-none font-mono" for="agreeTerms" style="font-size: 0.8125rem;">
                        Tôi đồng ý với chính sách bảo mật & điều khoản bán hàng
                    </label>
                    <div class="invalid-feedback">
                        Bạn cần đồng ý với điều khoản để tiếp tục.
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-editorial-submit w-100">
                <i class="bi bi-person-plus me-1.5"></i> Đăng Ký Tài Khoản
            </button>
        </form>

        <!-- Footer Links -->
        <div class="text-center mt-4 pt-3 border-top small text-secondary">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold" style="color: var(--accent-primary);">Đăng nhập ngay</a>
        </div>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/home" class="text-decoration-none text-muted small font-mono">
                &larr; Quay về trang chủ
            </a>
        </div>
    </div>

    <!-- Interactive script -->
    <script>
        function togglePasswordVisibility(fieldId, btn) {
            const field = document.getElementById(fieldId);
            const icon = btn.querySelector('i');
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }

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