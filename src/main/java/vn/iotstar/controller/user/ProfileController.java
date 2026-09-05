package vn.iotstar.controller.user;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = {"/myprofile", "/profile/update", "/user/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserDao userDao = new UserDao();

    // Phương thức lấy tên file theo đúng tài liệu upload multipart của thầy
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return Constant.DEFAULT_FILENAME;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Object account = session.getAttribute("account");

        // Nếu chưa đăng nhập thì chuyển hướng về trang login
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = 0;
        String username = "";
        if (account instanceof vn.iotstar.entity.User) {
            userId = ((vn.iotstar.entity.User) account).getId();
            username = ((vn.iotstar.entity.User) account).getUsername();
        } else if (account instanceof vn.iotstar.model.User) {
            userId = ((vn.iotstar.model.User) account).getId();
            username = ((vn.iotstar.model.User) account).getUserName();
        }

        // Ưu tiên lấy dữ liệu mới nhất từ CSDL qua JPA theo username để tránh xung đột ID giữa 2 bảng User và users
        User currentUser = null;
        if (username != null && !username.trim().isEmpty()) {
            currentUser = userDao.findByUsername(username.trim());
        }
        if (currentUser == null && userId > 0) {
            currentUser = userDao.findById(userId);
        }

        if (currentUser == null) {
            currentUser = new User();
            currentUser.setUsername(username);
            if (account instanceof vn.iotstar.model.User) {
                vn.iotstar.model.User m = (vn.iotstar.model.User) account;
                currentUser.setFullname(m.getFullName());
                currentUser.setEmail(m.getEmail());
                currentUser.setPhone(m.getPhone());
                currentUser.setPassword(m.getPassWord());
                currentUser.setRoleid(m.getRoleid());
            }
        }

        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        Object account = session.getAttribute("account");

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int id = 0;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {}

        String sessionUsername = "";
        if (account instanceof vn.iotstar.entity.User) {
            sessionUsername = ((vn.iotstar.entity.User) account).getUsername();
        } else if (account instanceof vn.iotstar.model.User) {
            sessionUsername = ((vn.iotstar.model.User) account).getUserName();
        }

        // Tìm user theo username chính xác đang đăng nhập
        User user = null;
        if (sessionUsername != null && !sessionUsername.trim().isEmpty()) {
            user = userDao.findByUsername(sessionUsername.trim());
        }
        if (user == null && id > 0) {
            user = userDao.findById(id);
        }
        if (user == null) {
            user = new User();
            user.setId(id);
            user.setUsername(sessionUsername);
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        user.setFullname(fullname);
        user.setPhone(phone);

        // Khởi tạo thư mục upload theo tài liệu của thầy[cite: 2]
        String uploadPath = Constant.UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            // Xử lý đọc file từ request multipart
            Part part = req.getPart("images");
            if (part != null && part.getSize() > 0) {
                String originalFileName = getFileName(part);
                if (!originalFileName.isEmpty() && !originalFileName.equals(Constant.DEFAULT_FILENAME)) {
                    String cleanFileName = Paths.get(originalFileName).getFileName().toString();
                    String fileName = System.currentTimeMillis() + "_" + cleanFileName;
                    part.write(uploadPath + File.separator + fileName); // Ghi file ra ổ đĩa
                    user.setImages(fileName);
                }
            }

            // Cập nhật thông tin vào DB qua JPA (Slide 31)
            userDao.update(user);

            // Đồng bộ sang cả bảng [User] (JDBC)
            try {
                java.sql.Connection conn = new vn.iotstar.connection.DBConnection().getConnection();
                java.sql.PreparedStatement ps = conn.prepareStatement(
                    "UPDATE [User] SET fullname = ?, phone = ?" + 
                    (user.getImages() != null ? ", avatar = ?" : "") + 
                    " WHERE username = ?"
                );
                ps.setString(1, user.getFullname());
                ps.setString(2, user.getPhone());
                if (user.getImages() != null) {
                    ps.setString(3, user.getImages());
                    ps.setString(4, user.getUsername());
                } else {
                    ps.setString(3, user.getUsername());
                }
                ps.executeUpdate();
                conn.close();
            } catch (Exception ex) {
                // Bỏ qua nếu bảng User không có cột hoặc lỗi phụ
            }

            // Đồng bộ lại dữ liệu trong session
            if (account instanceof vn.iotstar.model.User) {
                vn.iotstar.model.User mUser = (vn.iotstar.model.User) account;
                mUser.setFullName(user.getFullname());
                mUser.setPhone(user.getPhone());
                if (user.getImages() != null) {
                    mUser.setAvatar(user.getImages());
                }
                session.setAttribute("account", mUser);
            } else {
                session.setAttribute("account", user);
            }

            req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        } catch (Exception e) {
            req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }
}