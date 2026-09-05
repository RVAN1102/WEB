package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = cateService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            cateService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");

            if (categoryname == null || categoryname.trim().length() < 2) {
                req.setAttribute("error", "Tên danh mục không được để trống và phải có ít nhất 2 ký tự!");
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            int status = 1;
            try {
                if (statusStr != null) status = Integer.parseInt(statusStr);
            } catch (Exception e) {}

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            Part part = req.getPart("images1");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String lowerName = filename.toLowerCase();
                if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") && 
                    !lowerName.endsWith(".png") && !lowerName.endsWith(".webp") && !lowerName.endsWith(".gif")) {
                    req.setAttribute("error", "Định dạng file không hỗ trợ! Vui lòng chỉ tải lên file ảnh (.jpg, .jpeg, .png, .webp, .gif).");
                    req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                    return;
                }
                String ext = filename.substring(filename.lastIndexOf(".") + 1);
                String fname = System.currentTimeMillis() + "." + ext;
                
                File uploadDir = new File(Constant.DIR + "/category");
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                part.write(Constant.DIR + "/category/" + fname);
                category.setImages("category/" + fname);
            } else {
                String imageUrl = req.getParameter("images");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    category.setImages(imageUrl.trim());
                }
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else if (url.contains("/admin/category/update")) {
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");

            Category category = cateService.findById(categoryid);
            if (category == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            if (categoryname == null || categoryname.trim().length() < 2) {
                req.setAttribute("error", "Tên danh mục không được để trống và phải có ít nhất 2 ký tự!");
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            int status = 1;
            try {
                if (statusStr != null) status = Integer.parseInt(statusStr);
            } catch (Exception e) {}

            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            Part part = req.getPart("images1");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String lowerName = filename.toLowerCase();
                if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") && 
                    !lowerName.endsWith(".png") && !lowerName.endsWith(".webp") && !lowerName.endsWith(".gif")) {
                    req.setAttribute("error", "Định dạng file không hỗ trợ! Vui lòng chỉ tải lên file ảnh (.jpg, .jpeg, .png, .webp, .gif).");
                    req.setAttribute("cate", category);
                    req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                    return;
                }
                String ext = filename.substring(filename.lastIndexOf(".") + 1);
                String fname = System.currentTimeMillis() + "." + ext;

                File uploadDir = new File(Constant.DIR + "/category");
                if (!uploadDir.exists()) uploadDir.mkdirs();

                part.write(Constant.DIR + "/category/" + fname);
                category.setImages("category/" + fname);
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}