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
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistUsername(username)) {
            req.setAttribute("alert", "Tên tài khoản đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        try {
            // 1. Sinh mã OTP 6 số
            String otpCode = EmailUtil.generateOTP();

            // 2. Tạo User JPA với status = 0 (chờ kích hoạt) và code = otpCode
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password.trim());
            user.setEmail(email.trim());
            user.setFullname(fullname.trim());
            user.setPhone(phone != null ? phone.trim() : "");
            user.setRoleid(5);
            user.setStatus(0); // Chưa kích hoạt
            user.setCode(otpCode);

            userService.insert(user);

            // Đồng bộ sang bảng [User] JDBC để tương thích
            try {
                java.sql.Connection conn = new vn.iotstar.connection.DBConnection().getConnection();
                java.sql.PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createddate) VALUES (?,?,?,?,?,?,?,?)"
                );
                ps.setString(1, email);
                ps.setString(2, username);
                ps.setString(3, fullname);
                ps.setString(4, password);
                ps.setString(5, null);
                ps.setInt(6, 5);
                ps.setString(7, phone);
                ps.setDate(8, new java.sql.Date(System.currentTimeMillis()));
                ps.executeUpdate();
                conn.close();
            } catch (Exception ex) {
                // Bỏ qua nếu có lỗi khóa ngoại phụ
            }

            // 3. Gửi email kích hoạt
            EmailUtil.sendEmail(email, "Xác thực tài khoản Shopping MVC - Mã OTP của bạn", 
                    EmailUtil.getActivationEmailTemplate(fullname, otpCode), otpCode);

            // 4. Lưu username/email vào session để trang OTP nhận diện
            HttpSession session = req.getSession();
            session.setAttribute("verifyUsername", username);
            session.setAttribute("verifyEmail", email);

            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } catch (Exception e) {
            req.setAttribute("alert", "Lỗi tạo tài khoản: " + e.getMessage());
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}