<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="bg-white border-top pt-5 pb-4 mt-5">
    <div class="container">
        <div class="row g-4 mb-4">
            <!-- Col 1: Brand & Contact -->
            <div class="col-12 col-lg-4">
                <a href="<c:url value='/home'/>" class="site-brand-logo mb-3">
                    <span class="brand-dot"></span>
                    <span>SHOPPING<span class="text-primary fw-bold">MVC</span></span>
                </a>
                <p class="text-secondary small pe-lg-4 my-3">
                    Hệ thống bán lẻ thiết bị công nghệ chính hãng. Cung cấp sản phẩm công nghệ tiêu chuẩn quốc tế, bảo hành ủy quyền và dịch vụ khách hàng chuyên nghiệp.
                </p>
                <div class="text-secondary small font-mono">
                    <div class="mb-1.5"><i class="bi bi-geo-alt me-1.5 text-dark"></i>Số 1 Võ Văn Ngân, TP. Thủ Đức, TP. Hồ Chí Minh</div>
                    <div class="mb-1.5"><i class="bi bi-telephone me-1.5 text-dark"></i>Hotline CSKH: <strong>1800 6868</strong> (08:00 - 21:30)</div>
                    <div><i class="bi bi-envelope me-1.5 text-dark"></i>Email: cskh@shoppingmvc.vn</div>
                </div>
            </div>

            <!-- Col 2: Categories -->
            <div class="col-6 col-md-3 col-lg-2">
                <h6 class="font-mono text-uppercase small text-dark fw-bold mb-3" style="letter-spacing: 0.08em;">Danh Mục Hàng</h6>
                <ul class="list-unstyled small text-secondary mb-0">
                    <li class="mb-2"><a href="<c:url value='/product?cid=3'/>" class="text-decoration-none text-secondary">Điện thoại di động</a></li>
                    <li class="mb-2"><a href="<c:url value='/product?cid=5'/>" class="text-decoration-none text-secondary">Máy tính & Laptop</a></li>
                    <li class="mb-2"><a href="<c:url value='/product?cid=4'/>" class="text-decoration-none text-secondary">Máy tính bảng</a></li>
                    <li class="mb-2"><a href="<c:url value='/product?cid=6'/>" class="text-decoration-none text-secondary">Tai nghe & Âm thanh</a></li>
                    <li class="mb-2"><a href="<c:url value='/product?cid=7'/>" class="text-decoration-none text-secondary">Đồng hồ thông minh</a></li>
                    <li><a href="<c:url value='/product'/>" class="text-decoration-none text-primary fw-semibold">Tất cả sản phẩm &rarr;</a></li>
                </ul>
            </div>

            <!-- Col 3: Policies -->
            <div class="col-6 col-md-3 col-lg-3">
                <h6 class="font-mono text-uppercase small text-dark fw-bold mb-3" style="letter-spacing: 0.08em;">Chính Sách Bán Hàng</h6>
                <ul class="list-unstyled small text-secondary mb-0">
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Quy chế bảo hành chính hãng 12 tháng</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Chính sách 1 đổi 1 trong vòng 30 ngày</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Vận chuyển và giao nhận toàn quốc</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Phương thức thanh toán & trả góp 0%</a></li>
                    <li><a href="#" class="text-decoration-none text-secondary">Bảo mật thông tin người tiêu dùng</a></li>
                </ul>
            </div>

            <!-- Col 4: Newsletter & Payments -->
            <div class="col-12 col-md-6 col-lg-3">
                <h6 class="font-mono text-uppercase small text-dark fw-bold mb-3" style="letter-spacing: 0.08em;">Đăng Ký Bản Tin</h6>
                <p class="text-secondary small mb-3">Nhận thông báo khi có đợt hàng mới, ưu đãi thành viên và bản tin công nghệ.</p>
                <form class="input-group mb-3" onsubmit="event.preventDefault(); window.showToast('Đã đăng ký nhận bản tin thành công'); this.reset();">
                    <input type="email" class="form-control form-control-sm rounded-start-2 border-end-0" placeholder="Địa chỉ email của bạn..." required />
                    <button class="btn btn-dark btn-sm rounded-end-2 px-3 fw-semibold" type="submit">Gửi</button>
                </form>

                <div class="small text-muted mb-2">Thanh toán an toàn qua</div>
                <div class="d-flex gap-3 text-secondary fs-5">
                    <i class="bi bi-credit-card" title="Thẻ quốc tế"></i>
                    <i class="bi bi-wallet2" title="Ví điện tử"></i>
                    <i class="bi bi-qr-code" title="Chuyển khoản QR"></i>
                    <i class="bi bi-cash" title="Tiền mặt"></i>
                </div>
            </div>
        </div>

        <hr class="my-4 border-secondary opacity-25">

        <div class="row align-items-center text-secondary small gy-2 font-mono" style="font-size: 0.75rem;">
            <div class="col-md-6 text-center text-md-start">
                &copy; 2026 <strong>Shopping MVC</strong> &bull; Hệ thống bán lẻ thiết bị công nghệ chính hãng.
            </div>
            <div class="col-md-6 text-center text-md-end text-muted">
                Giấy phép kinh doanh số 0312345678 do Sở KH&ĐT cấp &bull; Đã đăng ký Bộ Công Thương
            </div>
        </div>
    </div>
</footer>
