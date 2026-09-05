package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 15     // 15MB
)
@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/update",
    "/admin/product/delete"
})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listproduct", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String statusStr = req.getParameter("status");
            String categoryIdStr = req.getParameter("categoryId");
            String imageUrl = req.getParameter("images");

            // Server-side validation
            if (productName == null || productName.trim().length() < 3) {
                req.setAttribute("error", "Tên sản phẩm không được để trống và phải có ít nhất 3 ký tự!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            double price = 0;
            int quantity = 0;
            int status = 1;
            int categoryId = 0;

            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) throw new IllegalArgumentException("Giá không được âm");
            } catch (Exception e) {
                req.setAttribute("error", "Giá bán không hợp lệ! Phải là số lớn hơn hoặc bằng 0.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity < 0) throw new IllegalArgumentException("Số lượng không được âm");
            } catch (Exception e) {
                req.setAttribute("error", "Số lượng trong kho không hợp lệ! Phải là số nguyên lớn hơn hoặc bằng 0.");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            try {
                if (statusStr != null) status = Integer.parseInt(statusStr);
                if (categoryIdStr != null) categoryId = Integer.parseInt(categoryIdStr);
            } catch (Exception e) {}

            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCreateDate(new Date(System.currentTimeMillis()));

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Handle file upload
            Part part = req.getPart("images1");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String lowerName = filename.toLowerCase();
                if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") && 
                    !lowerName.endsWith(".png") && !lowerName.endsWith(".webp") && !lowerName.endsWith(".gif")) {
                    req.setAttribute("error", "Định dạng file ảnh không hỗ trợ! Vui lòng chỉ tải lên file ảnh (.jpg, .jpeg, .png, .webp, .gif).");
                    req.setAttribute("categories", categoryService.findAll());
                    req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                    return;
                }

                String ext = filename.substring(filename.lastIndexOf(".") + 1);
                String fname = System.currentTimeMillis() + "." + ext;

                File uploadDir = new File(Constant.DIR + "/product");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                part.write(Constant.DIR + "/product/" + fname);
                product.setImages("product/" + fname);
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                product.setImages(imageUrl.trim());
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if (url.contains("/admin/product/update")) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String statusStr = req.getParameter("status");
            String categoryIdStr = req.getParameter("categoryId");
            String oldImages = req.getParameter("images");

            Product product = productService.findById(productId);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            // Server-side validation
            if (productName == null || productName.trim().length() < 3) {
                req.setAttribute("error", "Tên sản phẩm không được để trống và phải có ít nhất 3 ký tự!");
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            double price = 0;
            int quantity = 0;
            int status = 1;
            int categoryId = 0;

            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) throw new IllegalArgumentException("Giá không được âm");
            } catch (Exception e) {
                req.setAttribute("error", "Giá bán không hợp lệ! Phải là số lớn hơn hoặc bằng 0.");
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity < 0) throw new IllegalArgumentException("Số lượng không được âm");
            } catch (Exception e) {
                req.setAttribute("error", "Số lượng trong kho không hợp lệ! Phải là số nguyên lớn hơn hoặc bằng 0.");
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            try {
                if (statusStr != null) status = Integer.parseInt(statusStr);
                if (categoryIdStr != null) categoryId = Integer.parseInt(categoryIdStr);
            } catch (Exception e) {}

            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            Part part = req.getPart("images1");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String lowerName = filename.toLowerCase();
                if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") && 
                    !lowerName.endsWith(".png") && !lowerName.endsWith(".webp") && !lowerName.endsWith(".gif")) {
                    req.setAttribute("error", "Định dạng file ảnh không hỗ trợ! Vui lòng chỉ tải lên file ảnh (.jpg, .jpeg, .png, .webp, .gif).");
                    req.setAttribute("product", product);
                    req.setAttribute("categories", categoryService.findAll());
                    req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                    return;
                }

                String ext = filename.substring(filename.lastIndexOf(".") + 1);
                String fname = System.currentTimeMillis() + "." + ext;

                File uploadDir = new File(Constant.DIR + "/product");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                part.write(Constant.DIR + "/product/" + fname);
                product.setImages("product/" + fname);
            } else if (oldImages != null && !oldImages.trim().isEmpty()) {
                product.setImages(oldImages.trim());
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
