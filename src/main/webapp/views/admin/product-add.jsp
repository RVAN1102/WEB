<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm Mới - Shopping MVC</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-9 col-xl-8">
            <!-- Breadcrumb & Back -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 font-mono small">
                        <li class="breadcrumb-item"><a href="<c:url value='/admin/products'/>" class="text-decoration-none text-muted">Sản phẩm</a></li>
                        <li class="breadcrumb-item active fw-medium text-dark" aria-current="page">Thêm mới</li>
                    </ol>
                </nav>
                <a href="<c:url value='/admin/products'/>" class="btn btn-sm btn-outline-secondary rounded-1 px-3 font-mono">
                    <i class="bi bi-arrow-left me-1"></i>Danh sách
                </a>
            </div>

            <!-- Main Form Card -->
            <div class="admin-card overflow-hidden">
                <div class="p-4 border-bottom bg-white d-flex align-items-center justify-content-between">
                    <div>
                        <span class="font-mono text-uppercase small text-muted fw-bold d-block" style="font-size: 0.75rem; letter-spacing: 0.08em;">QUẢN LÝ KHO HÀNG</span>
                        <h5 class="mb-0 fw-bold text-dark mt-0.5">Thêm Sản Phẩm Mới</h5>
                    </div>
                    <div class="rounded-1 p-2 bg-light border text-dark font-mono small">
                        <i class="bi bi-box-seam fs-5"></i>
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

                    <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <!-- Product Name -->
                        <div class="mb-4">
                            <label for="productName" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">TÊN SẢN PHẨM <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-1" id="productName" name="productName" 
                                   minlength="3" maxlength="255" required placeholder="Nhập tên sản phẩm (VD: iPhone 16 Pro Max 256GB Desert Titanium...)" />
                            <div class="invalid-feedback">
                                Vui lòng nhập tên sản phẩm (ít nhất 3 ký tự).
                            </div>
                        </div>

                        <!-- Category -->
                        <div class="mb-4">
                            <label for="categoryId" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">DANH MỤC SẢN PHẨM <span class="text-danger">*</span></label>
                            <select class="form-select rounded-1 py-2 font-mono small" id="categoryId" name="categoryId" required>
                                <option value="" disabled selected>-- Chọn danh mục sản phẩm --</option>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryid}">${c.categoryname}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn danh mục cho sản phẩm.
                            </div>
                        </div>

                        <!-- Price & Quantity -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="price" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">GIÁ NIÊM YẾT (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light border-end-0 rounded-start-1 text-muted font-mono">₫</span>
                                    <input type="number" class="form-control rounded-end-1 font-mono" id="price" name="price" 
                                           min="0" step="1000" required placeholder="VD: 25000000" />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập giá hợp lệ (&ge; 0).
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="quantity" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">SỐ LƯỢNG KHO <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light border-end-0 rounded-start-1 text-muted"><i class="bi bi-boxes"></i></span>
                                    <input type="number" class="form-control rounded-end-1 font-mono" id="quantity" name="quantity" 
                                           min="0" required placeholder="VD: 50" />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số lượng tồn kho (&ge; 0).
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Description -->
                        <div class="mb-4">
                            <label for="description" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">MÔ TẢ THÔNG SỐ SẢN PHẨM</label>
                            <textarea class="form-control rounded-1" id="description" name="description" rows="4" 
                                      placeholder="Mô tả các đặc điểm kỹ thuật nổi bật, cấu hình, thời lượng pin, chế độ bảo hành..."></textarea>
                        </div>

                        <!-- Image URL -->
                        <div class="mb-3">
                            <label for="images" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">ĐƯỜNG DẪN HÌNH ẢNH (URL)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted border-end-0 rounded-start-1"><i class="bi bi-link-45deg"></i></span>
                                <input type="text" class="form-control rounded-end-1 font-mono small" id="images" name="images" 
                                       placeholder="https://images.unsplash.com/photo-..." />
                            </div>
                            <div class="form-text small text-muted">Dán liên kết ảnh trực tiếp từ internet nếu có.</div>
                        </div>

                        <!-- File Upload -->
                        <div class="mb-3">
                            <label for="imageFile" class="form-label fw-semibold small text-dark font-mono" style="font-size: 0.8125rem;">HOẶC TẢI ẢNH TỪ THIẾT BỊ</label>
                            <input class="form-control rounded-1 font-mono small" type="file" id="imageFile" name="images1" 
                                   accept="image/png, image/jpeg, image/jpg, image/webp, image/gif" 
                                   onchange="previewProdImage(event)" />
                            <div class="form-text small text-muted">Định dạng hỗ trợ: JPG, PNG, WEBP, GIF (Khuyến nghị tỷ lệ vuông 600x600px).</div>
                        </div>

                        <!-- Preview Container -->
                        <div class="mb-4 d-none" id="previewContainer">
                            <label class="form-label fw-semibold small text-muted d-block font-mono">XEM TRƯỚC HÌNH ẢNH:</label>
                            <div class="p-2 border rounded-1 d-inline-block bg-light">
                                <img id="prodPreview" src="" alt="Preview" class="rounded-1" style="max-height: 140px; max-width: 180px; object-fit: cover;" />
                            </div>
                        </div>

                        <!-- Status -->
                        <div class="mb-4 pt-2">
                            <label class="form-label fw-semibold small text-dark d-block font-mono" style="font-size: 0.8125rem;">TRẠNG THÁI BÁN HÀNG</label>
                            <div class="d-flex gap-4 font-mono small">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" checked>
                                    <label class="form-check-label text-success fw-semibold user-select-none" for="statusActive">
                                        <i class="bi bi-check-circle-fill me-1"></i>Đang mở bán
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="status" id="statusHidden" value="0">
                                    <label class="form-check-label text-secondary user-select-none" for="statusHidden">
                                        <i class="bi bi-eye-slash-fill me-1"></i>Tạm ẩn kho
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Buttons -->
                        <div class="d-flex gap-2 justify-content-end pt-4 border-top font-mono small">
                            <a href="<c:url value='/admin/products'/>" class="btn btn-light px-4 border rounded-1 fw-medium">Hủy bỏ</a>
                            <button type="submit" class="btn btn-dark px-4 rounded-1 fw-semibold">
                                <i class="bi bi-plus-circle me-1"></i>Lưu Sản Phẩm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewProdImage(event) {
            const file = event.target.files[0];
            const previewContainer = document.getElementById('previewContainer');
            const previewImg = document.getElementById('prodPreview');
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewContainer.classList.remove('d-none');
                };
                reader.readAsDataURL(file);
            } else {
                previewContainer.classList.add('d-none');
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
