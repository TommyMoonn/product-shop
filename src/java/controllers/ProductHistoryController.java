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
import models.entities.ProductView;
import models.services.CategoryService;
import models.services.ProductViewService;

@WebServlet(name = "ProductHistoryController", urlPatterns = {"/user/history"})
public class ProductHistoryController extends HttpServlet {

    private final ProductViewService productViewService = new ProductViewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account a = (Account) request.getSession().getAttribute("user");
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
        
        List<ProductView> list = productViewService.filter(a.getAccount(), typeId, minPrice, maxPrice, discounted, sort);
        
        CategoryService categoryService = new CategoryService();
                
        request.setAttribute("categories", categoryService.findAll());
        request.setAttribute("viewedProducts", list);
        request.getRequestDispatcher("product-history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "remove":
                removeView(request, response);
                break;
            case "clear":
                clearHistory(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/unsupported-feature.png");
        }
    }

    public void removeView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String viewId = request.getParameter("viewId");

        try {
            if (viewId == null) {
                throw new ValidationException("Invalid view id");
            }
            productViewService.removeView(Integer.parseInt(viewId));
            response.sendRedirect(request.getContextPath() + "/user/history");
        } catch (ValidationException e) {
            request.setAttribute("error", e);
            request.getRequestDispatcher("product-history.jsp").forward(request, response);
        }
    }

    public void clearHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");
        if (a != null) {
            productViewService.clearHistory(a.getAccount());
        }
        response.sendRedirect(request.getContextPath() + "/user/history");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
