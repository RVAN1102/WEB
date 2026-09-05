package vn.iotstar.controller.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserService;
import vn.iotstar.util.EmailUtil;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/verify-otp", "/resend-otp"})
public class VerifyOtpController extends HttpServlet {

    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/resend-otp")) {
            handleResendOtp(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("verifyUsername") : null;
        req.setAttribute("username", username);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String otp = req.getParameter("otp");

        if (username == null || username.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên tài khoản và mã OTP!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        User user = userService.findByUsername(username.trim());
        if (user == null) {
            req.setAttribute("error", "Không tìm thấy tài khoản!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (user.getStatus() == 1) {
            req.setAttribute("message", "Tài khoản của bạn đã được kích hoạt từ trước. Hãy đăng nhập!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (otp.trim().equals(user.getCode())) {
            // Xác thực thành công -> kích hoạt tài khoản
            user.setStatus(1);
            user.setCode(null);
            userService.update(user);

            HttpSession session = req.getSession();
            session.removeAttribute("verifyUsername");
            session.removeAttribute("verifyEmail");

            req.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng thử lại!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }

    private void handleResendOtp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("verifyUsername") : req.getParameter("username");

        if (username != null && !username.trim().isEmpty()) {
            User user = userService.findByUsername(username.trim());
            if (user != null && user.getStatus() == 0) {
                String newOtp = EmailUtil.generateOTP();
                user.setCode(newOtp);
                userService.update(user);

                EmailUtil.sendEmail(user.getEmail(), "Mã OTP kích hoạt tài khoản mới - Shopping MVC",
                        EmailUtil.getActivationEmailTemplate(user.getFullname(), newOtp), newOtp);

                req.setAttribute("message", "Đã gửi lại mã OTP mới về email: " + user.getEmail());
                req.setAttribute("username", username);
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                return;
            }
        }

        req.setAttribute("error", "Không thể gửi lại mã OTP. Vui lòng kiểm tra lại tài khoản!");
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }
}
