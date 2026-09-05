<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <title>${product.productName} - Chi Tiết Sản Phẩm | Shopping MVC</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumbs -->
        <nav aria-label="breadcrumb" class="mb-3 font-mono small">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none text-muted">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none text-muted">Kho Hàng</a></li>
                <c:if test="${product.category != null}">
                    <li class="breadcrumb-item"><a href="<c:url value='/product?cid=${product.category.categoryid}'/>" class="text-decoration-none text-muted">${product.category.categoryname}</a></li>
                </c:if>
                <li class="breadcrumb-item active text-dark fw-semibold text-truncate" style="max-width: 280px;" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <!-- Product Presentation Grid -->
        <div class="bg-white border rounded-2 p-4 p-lg-5 mb-4">
            <div class="row g-4 g-lg-5 align-items-start">
                <!-- Left: Product Image Stage -->
                <div class="col-12 col-lg-6">
                    <div class="product-detail-stage">
                        <c:choose>
                            <c:when test="${empty product.images}">
                                <img id="mainProductImage" src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=700&q=80" alt="${product.productName}" class="img-fluid">
                            </c:when>
                            <c:when test="${product.images.startsWith('http')}">
                                <img id="mainProductImage" src="${product.images}" alt="${product.productName}" class="img-fluid" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=700&q=80';">
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${product.images}" var="detailImgUrl"/>
                                <img id="mainProductImage" src="${detailImgUrl}" alt="${product.productName}" class="img-fluid" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=700&q=80';">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Assurance Micro-strip -->
                    <div class="row g-2 mt-2 font-mono text-muted text-center" style="font-size: 0.75rem;">
                        <div class="col-6 col-md-3">
                            <div class="p-2 border rounded-1 bg-light">BẢO HÀNH 12T</div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="p-2 border rounded-1 bg-light">ĐỔI TRẢ 30 NGÀY</div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="p-2 border rounded-1 bg-light">GIAO TOÀN QUỐC</div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="p-2 border rounded-1 bg-light">100% CHÍNH HÃNG</div>
                        </div>
                    </div>
                </div>

                <!-- Right: Information & Purchasing -->
                <div class="col-12 col-lg-6 d-flex flex-column">
                    <div class="d-flex align-items-center gap-2 mb-2 font-mono" style="font-size: 0.75rem;">
                        <span class="text-uppercase fw-bold text-dark">[ ${product.category != null ? product.category.categoryname : 'THIẾT BỊ'} ]</span>
                        <span class="text-muted">&bull;</span>
                        <span class="text-muted">MÃ SP: #SP-${product.productId}</span>
                    </div>

                    <h1 class="h4 fw-bold text-dark mb-3 lh-base">${product.productName}</h1>

                    <!-- Price Block -->
                    <div class="p-3 bg-light border rounded-1 mb-4">
                        <div class="font-mono text-muted small mb-1">GIÁ NIÊM YẾT CHÍNH THỨC</div>
                        <div class="d-flex align-items-baseline gap-3">
                            <span class="font-mono fs-2 fw-bold text-dark">
                                <fmt:formatNumber value="${product.price}" pattern="#,##0" /> ₫
                            </span>
                            <span class="small text-muted font-mono">(Đã bao gồm thuế VAT)</span>
                        </div>
                    </div>

                    <!-- Inventory & Specs Snapshot -->
                    <div class="mb-4">
                        <div class="d-flex align-items-center gap-2 mb-2 font-mono small">
                            <span class="text-muted" style="min-width: 110px;">TÌNH TRẠNG:</span>
                            <c:choose>
                                <c:when test="${product.quantity > 0}">
                                    <span class="text-success fw-bold">● Còn hàng (${product.quantity} đơn vị sẵn có)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary fw-bold">○ Tạm hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty product.createDate}">
                            <div class="d-flex align-items-center gap-2 mb-2 font-mono small">
                                <span class="text-muted" style="min-width: 110px;">NGÀY NIÊM YẾT:</span>
                                <span class="text-dark"><fmt:formatDate value="${product.createDate}" pattern="dd/MM/yyyy" /></span>
                            </div>
                        </c:if>
                        <div class="d-flex align-items-center gap-2 font-mono small">
                            <span class="text-muted" style="min-width: 110px;">GIAO NHẬN:</span>
                            <span class="text-dark">Miễn phí vận chuyển toàn quốc cho đơn hàng từ 500.000₫</span>
                        </div>
                    </div>

                    <!-- Quantity & Action Buttons -->
                    <div class="mt-auto pt-3 border-top">
                        <div class="d-flex align-items-center gap-3 mb-3">
                            <span class="font-mono small text-dark fw-bold">SỐ LƯỢNG:</span>
                            <div class="input-group" style="width: 120px;">
                                <button class="btn btn-outline-secondary btn-sm rounded-start-1" type="button" onclick="decrementQty()">-</button>
                                <input type="number" id="purchaseQty" class="form-control form-control-sm text-center fw-bold font-mono" value="1" min="1" max="${product.quantity > 0 ? product.quantity : 1}">
                                <button class="btn btn-outline-secondary btn-sm rounded-end-1" type="button" onclick="incrementQty()">+</button>
                            </div>
                        </div>

                        <div class="row g-2">
                            <div class="col-12 col-sm-6">
                                <button type="button" class="btn btn-dark w-100 py-2.5 rounded-1 fw-bold d-flex align-items-center justify-content-center gap-2" onclick="addToCart()">
                                    <i class="bi bi-cart-plus"></i> Thêm Vào Giỏ Hàng
                                </button>
                            </div>
                            <div class="col-12 col-sm-6">
                                <button type="button" class="btn btn-primary w-100 py-2.5 rounded-1 fw-bold d-flex align-items-center justify-content-center gap-2" onclick="buyNow()">
                                    <i class="bi bi-bag-check"></i> Mua Ngay
                                </button>
                            </div>
                        </div>

                        <div class="d-flex align-items-center justify-content-between mt-3 pt-2 font-mono small">
                            <a href="<c:url value='/product'/>" class="text-decoration-none text-muted">
                                &larr; Quay lại danh sách
                            </a>
                            <a href="<c:url value='/home'/>" class="text-decoration-none text-muted">
                                Trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Specifications & Documentation Tabs -->
        <div class="bg-white border rounded-2 p-4 p-lg-5 mb-4">
            <ul class="nav nav-tabs border-bottom mb-4" id="productTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-bold text-dark py-2.5 px-4 font-mono small" id="desc-tab" data-bs-toggle="tab" data-bs-target="#desc-pane" type="button" role="tab">
                        MÔ TẢ SẢN PHẨM
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-bold text-muted py-2.5 px-4 font-mono small" id="specs-tab" data-bs-toggle="tab" data-bs-target="#specs-pane" type="button" role="tab">
                        THÔNG SỐ KỸ THUẬT
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-bold text-muted py-2.5 px-4 font-mono small" id="warranty-tab" data-bs-toggle="tab" data-bs-target="#warranty-pane" type="button" role="tab">
                        CHÍNH SÁCH BẢO HÀNH
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="productTabsContent">
                <!-- Tab 1: Description -->
                <div class="tab-pane fade show active" id="desc-pane" role="tabpanel" tabindex="0">
                    <div class="lh-lg text-secondary">
                        <c:choose>
                            <c:when test="${empty product.description}">
                                <div class="text-muted small">
                                    Mô tả kỹ thuật cho mặt hàng này đang được cập nhật từ nhà sản xuất. Quý khách vui lòng liên hệ hotline 1800 6868 để nhận tư vấn thông số cụ thể.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="white-space: pre-line;">${product.description}</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Tab 2: Specs -->
                <div class="tab-pane fade" id="specs-pane" role="tabpanel" tabindex="0">
                    <table class="product-spec-table">
                        <tbody>
                            <tr>
                                <th>Tên sản phẩm</th>
                                <td>${product.productName}</td>
                            </tr>
                            <tr>
                                <th>Mã quản lý</th>
                                <td>#SP-${product.productId}</td>
                            </tr>
                            <tr>
                                <th>Phân loại</th>
                                <td>${product.category != null ? product.category.categoryname : 'Công nghệ'}</td>
                            </tr>
                            <tr>
                                <th>Tình trạng kho</th>
                                <td>${product.quantity > 0 ? 'Có sẵn tại kho hàng' : 'Đang nhập thêm'}</td>
                            </tr>
                            <tr>
                                <th>Tiêu chuẩn bảo hành</th>
                                <td>12 tháng chính hãng ủy quyền</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Tab 3: Warranty -->
                <div class="tab-pane fade" id="warranty-pane" role="tabpanel" tabindex="0">
                    <div class="text-secondary small lh-lg">
                        <h6 class="fw-bold text-dark mb-2">Quy Chế Bảo Hành & Đổi Trả</h6>
                        <ul class="mb-0 ps-3">
                            <li class="mb-1">Cam kết sản phẩm mới 100%, nguyên hộp, nguyên phụ kiện từ nhà sản xuất.</li>
                            <li class="mb-1">Hỗ trợ 1 đổi 1 trong 30 ngày đầu tiên nếu phát hiện lỗi phần cứng do nhà sản xuất.</li>
                            <li class="mb-1">Bảo hành 12 tháng tại các trung tâm dịch vụ khách hàng ủy quyền trên toàn quốc.</li>
                            <li>Hỗ trợ kỹ thuật và giải đáp thắc mắc vận hành miễn phí trọn đời sản phẩm.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Interaction Script -->
    <script>
        function incrementQty() {
            const input = document.getElementById('purchaseQty');
            const max = parseInt(input.getAttribute('max')) || 999;
            let val = parseInt(input.value) || 1;
            if (val < max) {
                input.value = val + 1;
            }
        }

        function decrementQty() {
            const input = document.getElementById('purchaseQty');
            let val = parseInt(input.value) || 1;
            if (val > 1) {
                input.value = val - 1;
            }
        }

        function addToCart() {
            const qty = document.getElementById('purchaseQty').value;
            if (window.showToast) {
                window.showToast('Đã thêm ' + qty + ' sản phẩm vào giỏ hàng!');
            }
        }

        function buyNow() {
            const qty = document.getElementById('purchaseQty').value;
            if (window.showToast) {
                window.showToast('Đang chuyển hướng tới cổng thanh toán cho ' + qty + ' sản phẩm...');
            }
        }
    </script>
</body>
</html>
