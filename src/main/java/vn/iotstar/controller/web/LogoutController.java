package vn.iotstar.controller.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Hủy Session tài khoản hiện tại
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute("account");
            session.invalidate();
        }

        // 2. Xóa Cookie ghi nhớ đăng nhập (nếu có)
        Cookie cookie = new Cookie("username", "");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);

        // 3. Đá về trang Đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}