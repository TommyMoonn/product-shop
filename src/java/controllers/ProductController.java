package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.entities.Product;
import models.services.CategoryService;
import models.services.ProductService;
import models.services.ProductViewService;

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

    private void showProductList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String typeIdParam = request.getParameter("typeId");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        String discountedParam = request.getParameter("discounted");
        String sort = request.getParameter("sort");

        Integer typeId = null;
        Integer minPrice = null;
        Integer maxPrice = null;
        Boolean discounted = null;

        if (typeIdParam != null && !typeIdParam.isEmpty()) {
            typeId = Integer.parseInt(typeIdParam);
        }

        if (minPriceParam != null && !minPriceParam.isEmpty()) {
            minPrice = Integer.parseInt(minPriceParam);
        }

        if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
            maxPrice = Integer.parseInt(maxPriceParam);
        }

        if ("true".equals(discountedParam)) {
            discounted = true;
        }

        List<Product> list = productService.filter(keyword, typeId, minPrice, maxPrice, discounted, sort);

        request.setAttribute("list", list);
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        Product p = productService.findById(productId);
        Account a = (Account) request.getSession().getAttribute("user");

        if (p != null) {
            request.setAttribute("featuredProducts", productService.findByCategory(p.getType().getTypeId()));
        }
        
        ProductViewService productViewService = new ProductViewService();
        if (a != null && p != null) {
            productViewService.recordView(a.getAccount(), productId);
        }

        request.setAttribute("product", p);
        request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
