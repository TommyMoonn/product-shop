package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.entities.Category;
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showProductList(request, response);
                break;
            case "add":
                showProductAddForm(request, response);
                break;
            case "update":
                showProductUpdateForm(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
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
        request.getRequestDispatcher("/views/product/product-list.jsp").forward(request, response);
    }

    public void showProductAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/views/product/product-add.jsp").forward(request, response);
    }

    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product p = new Product();

        //set fields recieved from the request
        p.setProductId(request.getParameter("productId"));
        p.setProductName(request.getParameter("productName"));
        p.setProductImage("");
        p.setBrief(request.getParameter("brief"));
        p.setUnit(request.getParameter("unit"));
        p.setPrice(Integer.parseInt(request.getParameter("price")));
        p.setDiscount(Integer.parseInt(request.getParameter("discount")));

        //get the current user
        Account a = (Account) request.getSession().getAttribute("user");

        Category c = new Category();
        c.setTypeId(Integer.parseInt(request.getParameter("typeId")));

        p.setType(c);
        p.setAccount(a);

        productService.create(p);
        response.sendRedirect(request.getContextPath() + "/product");
    }

    public void showProductUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product p = productService.findById(request.getParameter("productId"));

        request.setAttribute("product", p);
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/views/product/product-update.jsp").forward(request, response);
    }

    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        Product p = productService.findById(id);

        //update old fields
        //keep: id, posted date, image, and account
        p.setProductName(request.getParameter("productName"));
        p.setBrief(request.getParameter("brief"));
        p.setUnit(request.getParameter("unit"));
        p.setPrice(Integer.parseInt(request.getParameter("price")));
        p.setDiscount(Integer.parseInt(request.getParameter("discount")));

        productService.update(p);
        response.sendRedirect(request.getContextPath() + "/product");
    }

    public void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        productService.delete(id);
        response.sendRedirect(request.getContextPath() + "/product");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
