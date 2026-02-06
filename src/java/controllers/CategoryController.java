package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entity.Category;
import models.dao.CategoryDAO;

@WebServlet(name = "CategoryController", urlPatterns = {"/category"})
public class CategoryController extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

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
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "category");
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
            default:
                response.sendRedirect(request.getContextPath() + "category");
        }
    }

    public void showCategoryList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> list = categoryDAO.getAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/category/category-list.jsp").forward(request, response);
    }

    //redirect to add form jsp
    public void showCategoryAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/category/category-add.jsp").forward(request, response);
    }

    //call service to do add operation
    public void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category c = new Category();
        c.setCategoryName(request.getParameter("categoryName"));
        c.setMemo(request.getParameter("memo"));
        int success = categoryDAO.insert(c);

        if (success > 0) {
            response.sendRedirect(request.getContextPath() + "/category");
        } else {
            request.setAttribute("error", "Failed to add category"); //sends error 
            request.getRequestDispatcher("/views/category/category-add.jsp").forward(request, response); //goes back to add form to retry
        }
    }

    //redirect to update form jsp
    public void showCategoryUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("typeId");
        Category c = categoryDAO.getById(id);
        request.setAttribute("category",c);
        request.getRequestDispatcher("/views/category/category-update.jsp").forward(request,response);
    }

    //call service to do update operation
    public void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category c = new Category();
        c.setTypeId(Integer.parseInt(request.getParameter("typeId")));
        c.setCategoryName(request.getParameter("categoryName"));
        c.setMemo(request.getParameter("memo"));
        
        int success = categoryDAO.update(c);

        if (success > 0) {
            response.sendRedirect(request.getContextPath() + "category");
        } else {
            request.setAttribute("error", "Failed to update category"); //sets error message
            request.getRequestDispatcher("/views/category/category-update.jsp").forward(request, response); //goes back to update form to retry
        }
    }

    //call service to do delete operation
    public void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeId = request.getParameter("typeId");
        int success = categoryDAO.delete(typeId);

        if (success > 0) {
            response.sendRedirect(request.getContextPath() + "/category");
        } else {
            request.setAttribute("error", "Failed to delete category");
            request.getRequestDispatcher("category").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
