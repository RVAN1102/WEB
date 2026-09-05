package vn.iotstar.controller.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;

// Bắt cả trang gốc domain /Shopping_MVC/ và /Shopping_MVC
@WebServlet(urlPatterns = {"", "/"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        // Bỏ qua nếu là tài nguyên tĩnh (assets, css, js, png, jpg, v.v.)
        if (servletPath != null && (servletPath.startsWith("/assets") || servletPath.contains("."))) {
            req.getServletContext().getNamedDispatcher("default").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user != null) {
            // Đã xác thực thành công -> Đẩy sang WaitingController để chuyển hướng đúng vai trò
            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            // Chưa xác thực -> Bắt buộc về trang Đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}