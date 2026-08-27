package vn.iotstar.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;

// Áp dụng Filter cho toàn bộ các trang cần bảo vệ
@WebFilter(urlPatterns = {"/admin/*", "/user/*", "/manager/*"})
public class SecurityFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("account") : null;

        // 1. Chưa đăng nhập -> Chuyển về trang Login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Đã đăng nhập nhưng cố tình gõ URL không đúng quyền
        String uri = req.getRequestURI();
        if (uri.contains("/admin/") && user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/waiting"); // Đá về trang phân luồng chuẩn
            return;
        }

        // 3. Đúng quyền và hợp lệ -> Cho phép đi tiếp vào Controller
        chain.doFilter(request, response);
    }
}