<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - Shopping MVC</title>
</head>
<body>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-3">
                    <ol class="breadcrumb font-mono small mb-0">
                        <li class="breadcrumb-item"><a href="<c:url value='/'/>" class="text-decoration-none text-muted">Trang Chủ</a></li>
                        <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Hồ Sơ Tài Khoản</li>
                    </ol>
                </nav>

                <div class="bg-white border rounded-2 overflow-hidden shadow-xs">
                    <!-- Header -->
                    <div class="p-4 border-bottom bg-white d-flex align-items-center justify-content-between">
                        <div>
                            <span class="font-mono text-uppercase small text-muted fw-bold d-block" style="font-size: 0.75rem; letter-spacing: 0.08em;">THÔNG TIN THÀNH VIÊN</span>
                            <h1 class="h5 fw-bold mb-0 text-dark mt-0.5">Hồ Sơ Cá Nhân</h1>
                        </div>
                        <span class="font-mono small px-2.5 py-1 border rounded-1 bg-light text-dark fw-semibold">
                            <c:choose>
                                <c:when test="${user.roleid == 1}">QUẢN TRỊ VIÊN</c:when>
                                <c:otherwise>KHÁCH HÀNG</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="p-4 p-md-5">
                        <!-- Notifications -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show d-flex align-items-center mb-4 rounded-1" role="alert">
                                <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                                <div class="small">${message}</div>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4 rounded-1" role="alert">
                                <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                                <div class="small">${error}</div>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form action="<c:url value='/profile/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="${user.id}"/>

                            <!-- Avatar section -->
                            <div class="text-center mb-4 pb-3 border-bottom">
                                <div class="position-relative d-inline-block">
                                    <c:choose>
                                        <c:when test="${empty user.images}">
                                            <img id="avatarImage" src="https://ui-avatars.com/api/?name=${user.fullname != null ? user.fullname : user.username}&background=0f172a&color=fff&size=150" 
                                                 alt="Avatar" class="rounded-circle border border-2 border-secondary-subtle object-fit-cover" 
                                                 style="width: 110px; height: 110px;" />
                                        </c:when>
                                        <c:when test="${user.images.startsWith('http')}">
                                            <img id="avatarImage" src="${user.images}" alt="Avatar" 
                                                 class="rounded-circle border border-2 border-secondary-subtle object-fit-cover" 
                                                 style="width: 110px; height: 110px;" 
                                                 onerror="this.src='https://ui-avatars.com/api/?name=${user.username}&background=0f172a&color=fff&size=150';" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${user.images}" var="imgUrl"/>
                                            <img id="avatarImage" src="${imgUrl}" alt="Avatar" 
                                                 class="rounded-circle border border-2 border-secondary-subtle object-fit-cover" 
                                                 style="width: 110px; height: 110px;" 
                                                 onerror="this.src='https://ui-avatars.com/api/?name=${user.username}&background=0f172a&color=fff&size=150';" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mt-2 text-muted small font-mono">ID TÀI KHOẢN: #USER-${user.id}</div>
                            </div>

                            <!-- Username (Readonly) -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-dark font-mono small" style="font-size: 0.8125rem;">TÊN ĐĂNG NHẬP (CỐ ĐỊNH)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light rounded-start-1"><i class="bi bi-person text-secondary"></i></span>
                                    <input type="text" class="form-control bg-light rounded-end-1 font-mono" value="${user.username}" disabled readonly />
                                </div>
                            </div>

                            <!-- Email (Readonly) -->
                            <c:if test="${not empty user.email}">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold text-dark font-mono small" style="font-size: 0.8125rem;">ĐỊA CHỈ EMAIL</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light rounded-start-1"><i class="bi bi-envelope text-secondary"></i></span>
                                        <input type="email" class="form-control bg-light rounded-end-1 font-mono" value="${user.email}" disabled readonly />
                                    </div>
                                </div>
                            </c:if>

                            <!-- Full Name -->
                            <div class="mb-3">
                                <label for="fullname" class="form-label fw-semibold text-dark font-mono small" style="font-size: 0.8125rem;">HỌ VÀ TÊN <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text rounded-start-1"><i class="bi bi-card-heading text-secondary"></i></span>
                                    <input type="text" class="form-control rounded-end-1" id="fullname" name="fullname" 
                                           value="${user.fullname}" minlength="2" maxlength="100" required 
                                           placeholder="Nhập họ và tên đầy đủ" />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập họ và tên (tối thiểu 2 ký tự).
                                    </div>
                                </div>
                            </div>

                            <!-- Phone -->
                            <div class="mb-3">
                                <label for="phone" class="form-label fw-semibold text-dark font-mono small" style="font-size: 0.8125rem;">SỐ ĐIỆN THOẠI</label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text rounded-start-1"><i class="bi bi-telephone text-secondary"></i></span>
                                    <input type="tel" class="form-control rounded-end-1 font-mono" id="phone" name="phone" 
                                           value="${user.phone}" pattern="^(0[35789])[0-9]{8}$" 
                                           placeholder="VD: 0987654321" />
                                    <div class="invalid-feedback">
                                        Số điện thoại không hợp lệ (gồm 10 số, bắt đầu bằng 03, 05, 07, 08, 09).
                                    </div>
                                </div>
                            </div>

                            <!-- Avatar Upload -->
                            <div class="mb-4">
                                <label for="imageInput" class="form-label fw-semibold text-dark font-mono small" style="font-size: 0.8125rem;">CẬP NHẬT ẢNH ĐẠI DIỆN</label>
                                <input class="form-control rounded-1 font-mono small" type="file" id="imageInput" name="images" 
                                       accept="image/png, image/jpeg, image/jpg, image/webp, image/gif" 
                                       onchange="previewImage(event)" />
                                <div class="form-text small">Hỗ trợ file ảnh JPG, PNG, WEBP dung lượng tối đa 5MB.</div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2 justify-content-end pt-3 border-top">
                                <a href="<c:url value='/'/>" class="btn btn-light rounded-1 px-4 border small font-mono">
                                    Quay Lại
                                </a>
                                <button type="submit" class="btn btn-dark rounded-1 px-4 fw-semibold small font-mono">
                                    <i class="bi bi-check2 me-1"></i>Lưu Thay Đổi
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                if (file.size > 5 * 1024 * 1024) {
                    alert("Kích thước file ảnh không được vượt quá 5MB!");
                    event.target.value = "";
                    return;
                }
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.getElementById('avatarImage');
                    if (img) {
                        img.src = e.target.result;
                    }
                };
                reader.readAsDataURL(file);
            }
        }

        (function () {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>