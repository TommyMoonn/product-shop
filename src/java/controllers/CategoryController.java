package controllers;

import exceptions.ValidationException;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Category;
import models.services.CategoryService;

@WebServlet(name = "CategoryController", urlPatterns = {"/category"})
public class CategoryController extends HttpServlet {

    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showCategoryList(request, response);
                break;
            case "add":
                showCategoryAddForm(request, response);
                break;
            case "update":
                showCategoryUpdateForm(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
        }
    }

    public void showCategoryList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", categoryService.findAll());
        request.getRequestDispatcher("/views/category/category-list.jsp").forward(request, response);
    }

    public void showCategoryAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/category/category-add.jsp").forward(request, response);
    }

    public void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category c = new Category();
        c.setCategoryName(request.getParameter("categoryName").trim());
        c.setMemo(request.getParameter("memo"));
        try {
            categoryService.create(c);
            response.sendRedirect(request.getContextPath() + "/category?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showCategoryList(request, response);
        }
    }

    public void showCategoryUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("typeId");
        Category c = categoryService.findById(id);
        request.setAttribute("category", c);
        request.getRequestDispatcher("/views/category/category-update.jsp").forward(request, response);
    }

    public void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category c = new Category();
        c.setTypeId(Integer.parseInt(request.getParameter("typeId")));
        c.setCategoryName(request.getParameter("categoryName").trim());
        c.setMemo(request.getParameter("memo"));
        try {
            categoryService.update(c);
            response.sendRedirect(request.getContextPath() + "/category?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showCategoryList(request, response);
        }
    }

    public void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeId = request.getParameter("typeId");

        try {
            categoryService.delete(typeId);
            response.sendRedirect(request.getContextPath() + "/category?action=list");

        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showCategoryList(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
