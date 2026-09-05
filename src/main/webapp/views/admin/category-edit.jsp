<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Danh Mục - Shopping MVC</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <!-- Breadcrumb & Back -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 font-mono small">
                        <li class="breadcrumb-item"><a href="<c:url value='/admin/categories'/>" class="text-decoration-none text-muted">Danh mục</a></li>
                        <li class="breadcrumb-item active fw-medium text-dark" aria-current="page">Chỉnh sửa #${cate.categoryid}</li>
                    </ol>
                </nav>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-sm btn-outline-secondary rounded-1 px-3 font-mono">
                    <i class="bi bi-arrow-left me-1"></i>Danh sách
                </a>
            </div>

            <!-- Main Form Card -->
            <div class="admin-card overflow-hidden">
                <div class="p-4 border-bottom bg-white d-flex align-items-center justify-content-between">
                    <div>
                        <span class="font-mono text-uppercase small text-muted fw-bold d-block" style="font-size: 0.75rem; letter-spacing: 0.08em;">ĐIỀU CHỈNH PHÂN LOẠI</span>
                        <h5 class="mb-0 fw-bold text-dark mt-0.5">Chỉnh Sửa Danh Mục #${cate.categoryid}</h5>
                    </div>
                    <div class="rounded-1 p-2 bg-light border text-dark font-mono small">
                        <i class="bi bi-pencil-square fs-5"></i>
                    </div>
                </div>

                <div class="p-4 bg-white">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4 rounded-1 border" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2 flex-shrink-0"></i>
                            <div class="small">${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="categoryid" value="${cate.categoryid}">

                        <!-- Category Name -->
                        <div class="mb-4">
                            <label for="categoryname" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">TÊN DANH MỤC <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-1" id="categoryname" name="categoryname" 
                                   value="${cate.categoryname}" minlength="2" maxlength="100" required 
                                   placeholder="Nhập tên danh mục..." />
                            <div class="invalid-feedback">
                                Vui lòng nhập tên danh mục hợp lệ (từ 2 đến 100 ký tự).
                            </div>
                        </div>

                        <!-- Current Image -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted d-block font-mono">ẢNH HIỆN TẠI:</label>
                            <div class="p-2 border rounded-1 d-inline-block bg-light">
                                <c:choose>
                                    <c:when test="${empty cate.images}">
                                        <p class="text-muted fst-italic mb-0 small font-mono">Chưa có ảnh</p>
                                    </c:when>
                                    <c:when test="${cate.images.startsWith('http')}">
                                        <img id="catePreview" src="${cate.images}" alt="${cate.categoryname}" 
                                             class="rounded-1" style="max-height: 120px; max-width: 160px; object-fit: cover;" 
                                             onerror="this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                        <img id="catePreview" src="${imgUrl}" alt="${cate.categoryname}" 
                                             class="rounded-1" style="max-height: 120px; max-width: 160px; object-fit: cover;" 
                                             onerror="this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <input type="hidden" name="images" value="${cate.images}">
                        </div>

                        <!-- Change Image File Upload -->
                        <div class="mb-3">
                            <label for="imageFile" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">THAY ĐỔI ẢNH (TẢI FILE MỚI)</label>
                            <input class="form-control rounded-1 font-mono small" type="file" id="imageFile" name="images1" 
                                   accept="image/png, image/jpeg, image/jpg, image/webp, image/gif" 
                                   onchange="previewCateImage(event)" />
                            <div class="form-text small text-muted">Định dạng hỗ trợ: JPG, PNG, WEBP, GIF. Bỏ qua nếu không muốn đổi ảnh.</div>
                        </div>

                        <!-- Status -->
                        <div class="mb-4 pt-2">
                            <label class="form-label fw-semibold small text-dark d-block font-mono" style="font-size: 0.8125rem;">TRẠNG THÁI HIỂN THỊ</label>
                            <div class="d-flex gap-4 font-mono small">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" ${cate.status == 1 ? 'checked' : ''}>
                                    <label class="form-check-label text-success fw-semibold user-select-none" for="statusActive">
                                        <i class="bi bi-check-circle-fill me-1"></i>Hoạt động
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="status" id="statusLocked" value="0" ${cate.status == 0 ? 'checked' : ''}>
                                    <label class="form-check-label text-secondary user-select-none" for="statusLocked">
                                        <i class="bi bi-lock-fill me-1"></i>Tạm khóa
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Buttons -->
                        <div class="d-flex gap-2 justify-content-end pt-4 border-top font-mono small">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-light px-4 border rounded-1 fw-medium">Hủy bỏ</a>
                            <button type="submit" class="btn btn-dark px-4 rounded-1 fw-semibold">
                                <i class="bi bi-floppy me-1"></i>Cập Nhật Danh Mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewCateImage(event) {
            const file = event.target.files[0];
            const previewImg = document.getElementById('catePreview');
            if (file && previewImg) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }

        // Bootstrap 5 client-side validation
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