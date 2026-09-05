package vn.iotstar.controller.user;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/product", "/products", "/product/detail" })
public class UserProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/product/detail")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int productId = Integer.parseInt(idStr);
                    Product product = productService.findById(productId);
                    if (product != null) {
                        req.setAttribute("product", product);
                        req.getRequestDispatcher("/views/user/product-detail.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/product");
        } else {
            String cidStr = req.getParameter("cid");
            if (cidStr != null && !cidStr.isEmpty()) {
                try {
                    int cid = Integer.parseInt(cidStr);
                    List<Product> products = productService.findByCategoryId(cid);
                    req.setAttribute("products", products);
                    req.setAttribute("currentPage", 1);
                    req.setAttribute("totalPages", 1);
                    req.setAttribute("totalProducts", products.size());
                    req.setAttribute("selectedCid", cid);
                    req.getRequestDispatcher("/views/user/product-list.jsp").forward(req, resp);
                    return;
                } catch (NumberFormatException e) {
                    // Tiếp tục phân trang bình thường
                }
            }

            int pageSize = 6;
            int page = 1;
            String pageStr = req.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalProducts = productService.count();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<Product> products = productService.findAll(page, pageSize);

            req.setAttribute("products", products);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalProducts", totalProducts);

            req.getRequestDispatcher("/views/user/product-list.jsp").forward(req, resp);
        }
    }
}
