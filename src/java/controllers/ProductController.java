package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Product;
import models.services.CategoryService;
import models.services.ProductService;

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {
    
    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showProductList(request, response);
                break;
            case "detail":
                showProductDetail(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/unsupported-feature.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
    public void showProductList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> list;
        String typeId = request.getParameter("typeId");

        //check if filter by category is used 
        if (typeId != null && !typeId.isEmpty()) {
            //filter is used -> get list filtered by category
            int id = Integer.parseInt(typeId);
            list = productService.findByCategory(id);
        } else {
            //filter is not used -> normal list
            list = productService.findAll();
        }

        request.setAttribute("list", list);
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }

    public void showProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        Product p = productService.findById(id);
        request.setAttribute("product", p);
        request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
