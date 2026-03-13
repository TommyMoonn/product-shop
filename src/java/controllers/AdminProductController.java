package controllers;

import exceptions.ValidationException;
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
import models.services.AuthorizationService;
import models.services.CategoryService;
import models.services.ProductService;

@WebServlet(name = "AdminProductController", urlPatterns = {"/admin/product"})
public class AdminProductController extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        Account user = (Account) request.getSession().getAttribute("user");
        if (!AuthorizationService.hasPermission(user, "product", action)) {
            response.sendRedirect(request.getContextPath() + "/access-denied.jsp");
            return;
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
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/unsupported-feature.jsp");
        }
    }

    private void showProductList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeIdParam = request.getParameter("typeId");
        String discountedParam = request.getParameter("discounted");
        String sort = request.getParameter("sort");

        Integer typeId = null;
        Boolean discounted = null;

        if (typeIdParam != null && !typeIdParam.isEmpty()) {
            typeId = Integer.parseInt(typeIdParam);
        }

        if ("true".equals(discountedParam)) {
            discounted = true;
        }

        List<Product> list = productService.filter(null, typeId, null, null, discounted, sort);

        request.setAttribute("list", list);
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/admin/product/product-list.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        Product p = productService.findById(id);
        request.setAttribute("product", p);
        request.getRequestDispatcher("/admin/product/product-detail.jsp").forward(request, response);
    }

    private void showProductAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/admin/product/product-add.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product p = new Product();

        //set fields recieved from the request
        p.setProductId(request.getParameter("productId"));
        p.setProductName(request.getParameter("productName"));
        String image = request.getParameter("productImage");
        if (image == null || image.isEmpty()) {
            p.setProductImage("default.png");
        } else {
            p.setProductImage(image);
        }
        p.setBrief(request.getParameter("brief"));
        p.setUnit(request.getParameter("unit"));
        p.setPrice(Integer.parseInt(request.getParameter("price")));
        p.setDiscount(Integer.parseInt(request.getParameter("discount")));

        //get the current user
        Account a = (Account) request.getSession().getAttribute("user");

        //get the category
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        Category c = categoryService.findById(String.valueOf(typeId));

        p.setType(c);
        p.setAccount(a);
        try {
            productService.create(p);
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showProductAddForm(request, response);
        }
    }

    private void showProductUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product p = productService.findById(request.getParameter("productId"));
        String fullPath = p.getProductImage();

        if (fullPath != null) {
            String fileName = fullPath.substring(fullPath.lastIndexOf("/") + 1);
            request.setAttribute("imageFileName", fileName);
        }
        request.setAttribute("product", p);
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/admin/product/product-update.jsp").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        Product p = productService.findById(id);

        //update old fields
        //keep: id, posted date, image, and account
        p.setProductName(request.getParameter("productName"));
        String image = request.getParameter("productImage");
        if (image != null && !image.isEmpty()) {
            p.setProductImage(image);
        }
        p.setBrief(request.getParameter("brief"));
        p.setUnit(request.getParameter("unit"));
        p.setPrice(Integer.parseInt(request.getParameter("price")));
        p.setDiscount(Integer.parseInt(request.getParameter("discount")));

        int typeId = Integer.parseInt(request.getParameter("typeId"));
        Category c = categoryService.findById(String.valueOf(typeId));

        p.setType(c);

        try {
            productService.update(p);
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("product", p);
            request.setAttribute("categories", categoryService.findAll());
            request.getRequestDispatcher("/admin/product/product-update.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        try {
            productService.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showProductList(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
