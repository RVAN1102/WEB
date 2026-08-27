package vn.iotstar.controller.user;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

@WebServlet(urlPatterns = {"/user/home"})
public class UserHomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Đổi sang kiểu ICategoryService
    private ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Đổi hàm getAll() thành findAll()
        List<Category> list = cateService.findAll();
        req.setAttribute("cateList", list);

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }
}