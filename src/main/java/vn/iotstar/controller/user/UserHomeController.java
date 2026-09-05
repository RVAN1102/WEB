package vn.iotstar.controller.user;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/user/home", "/home"})
public class UserHomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ICategoryService cateService = new CategoryServiceImpl();
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> list = cateService.findAll();
        req.setAttribute("cateList", list);

        // Lấy 10 sản phẩm mới nhất
        List<Product> top10Products = productService.findTop10Latest();
        req.setAttribute("top10Products", top10Products);

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }
}