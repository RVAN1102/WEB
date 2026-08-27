package vn.iotstar.controller.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        File file = new File(Constant.DIR, fileName);

        if (file.exists() && file.isFile()) {
            // 1. Reset response để xóa sạch header/mã HTML nếu lỡ bị Filter khác chèn vào
            resp.reset();

            // 2. Thiết lập đúng MIME type và độ dài file
            String mimeType = getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "image/jpeg";
            }
            resp.setContentType(mimeType);
            resp.setContentLength((int) file.length());

            // 3. Đọc dữ liệu binary từ đĩa và ghi trực tiếp ra Output Stream
            try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
                 BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream())) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            }
        } else {
            System.err.println("[LỖI ĐỌC ẢNH] Không tìm thấy file: " + file.getAbsolutePath());
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}