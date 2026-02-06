package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entity.Account;
import models.entity.Category;
import models.entity.Product;
import models.dao.CategoryDAO;
import models.dao.ProductDAO;

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

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
                showProductList(request,response);
                break;
            case "add":
                showProductAddForm(request, response);
                break;
            case "update":
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
                break;
            case "delete":
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
                break;
            default: 
                response.sendRedirect(request.getContextPath() + "product");
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
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/product");
        }
    }

    public void showProductList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> list = productDAO.getAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/product/product-list.jsp").forward(request, response);
    }
    
    public void showProductAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> list = categoryDAO.getAll();
        
        request.setAttribute("categories", list);
        request.getRequestDispatcher("/views/product/product-add.jsp").forward(request,response);
    }
    
    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product p = new Product();
        p.setProductId(request.getParameter("productId"));
        p.setProductName(request.getParameter("productName"));
        p.setProductImage("");
        p.setBrief(request.getParameter("brief"));
        p.setUnit(request.getParameter("unit"));
        p.setPrice(Integer.parseInt(request.getParameter("price")));
        p.setDiscount(Integer.parseInt(request.getParameter("discount")));
        
        Account a = (Account) request.getSession().getAttribute("user");
        Category c = new Category();
        c.setTypeId(Integer.parseInt(request.getParameter("typeId")));
        
        p.setType(c);
        p.setAccount(a);
        
        int success = productDAO.insert(p);
        
        if (success > 0) {
            response.sendRedirect(request.getContextPath() + "/product");
        } else {
            request.setAttribute("error", "Failed to add product"); //sets error message
            request.getRequestDispatcher(request.getContextPath() + "product?action=add").forward(request, response); 
        }
    }
    
    public void showProductUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
