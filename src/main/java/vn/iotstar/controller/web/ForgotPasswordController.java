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
@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {

    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/reset-password")) {
            HttpSession session = req.getSession(false);
            String username = (session != null) ? (String) session.getAttribute("resetUsername") : null;
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.contains("/reset-password")) {
            handleResetPassword(req, resp);
        } else {
            handleForgotPassword(req, resp);
        }
    }

    private void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountInput = req.getParameter("account_input");

        if (accountInput == null || accountInput.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập Email hoặc Tên tài khoản!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        accountInput = accountInput.trim();
        User user = userService.findByEmail(accountInput);
        if (user == null) {
            user = userService.findByUsername(accountInput);
        }

        if (user == null) {
            req.setAttribute("error", "Không tìm thấy tài khoản tương ứng với thông tin bạn cung cấp!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Sinh mã OTP 6 số và cập nhật vào User
        String otp = EmailUtil.generateOTP();
        user.setCode(otp);
        userService.update(user);

        // Gửi email OTP
        EmailUtil.sendEmail(user.getEmail(), "Mã OTP đặt lại mật khẩu - Shopping MVC",
                EmailUtil.getResetPasswordEmailTemplate(user.getFullname(), otp), otp);

        HttpSession session = req.getSession();
        session.setAttribute("resetUsername", user.getUsername());
        session.setAttribute("resetEmail", user.getEmail());

        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }

    private void handleResetPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("new_password");
        String confirmPassword = req.getParameter("confirm_password");

        if (username == null || username.trim().isEmpty() || otp == null || otp.trim().isEmpty()
                || newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ các thông tin!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!otp.trim().matches("^[0-9]{6}$")) {
            req.setAttribute("error", "Mã xác thực OTP không đúng định dạng (phải gồm 6 chữ số)!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (newPassword.trim().length() < 6) {
            req.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Xác nhận mật khẩu mới không khớp!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        User user = userService.findByUsername(username.trim());
        if (user == null) {
            req.setAttribute("error", "Không tìm thấy tài khoản hợp lệ!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (otp.trim().equals(user.getCode())) {
            // Đặt lại mật khẩu thành công
            user.setPassword(newPassword.trim());
            user.setCode(null);
            userService.update(user);

            // Đồng bộ sang bảng JDBC [User] nếu có
            try {
                java.sql.Connection conn = new vn.iotstar.connection.DBConnection().getConnection();
                java.sql.PreparedStatement ps = conn.prepareStatement(
                    "UPDATE [User] SET password = ? WHERE username = ?"
                );
                ps.setString(1, newPassword.trim());
                ps.setString(2, user.getUsername());
                ps.executeUpdate();
                conn.close();
            } catch (Exception e) {
                // Bỏ qua lỗi phụ
            }

            HttpSession session = req.getSession();
            session.removeAttribute("resetUsername");
            session.removeAttribute("resetEmail");

            req.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng kiểm tra lại!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}
