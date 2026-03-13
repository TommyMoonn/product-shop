package controllers;

import exceptions.ValidationException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.services.ShoppingCartService;

@WebServlet(name = "ShoppingCartController", urlPatterns = {"/user/cart"})
public class ShoppingCartController extends HttpServlet {

    private final ShoppingCartService shoppingCartService = new ShoppingCartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showShoppingCart(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "unsupported-feature.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addToCart(request, response);
                break;
            case "remove":
                removeFromCart(request, response);
                break;
            case "update":
                updateQuantity(request, response);
                break;
            case "clear":
                clearCart(request, response);
                break;
        }
    }

    private void showShoppingCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");

        request.setAttribute("cartItems", shoppingCartService.getItems(a.getAccount()));
        request.getRequestDispatcher("shopping-cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");
        String productId = request.getParameter("productId");

        shoppingCartService.addItem(a.getAccount(), productId, 1);

        String redirect = request.getParameter("redirect");
        if ("history".equals(redirect)) {
            response.sendRedirect(request.getContextPath() + "/user/history");
        } else if ("detail".equals(redirect)) {
            response.sendRedirect(request.getContextPath() + "/product?action=detail&productId=" + productId);
        } else {
            response.sendRedirect(request.getContextPath() + "/product");
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");
        String productId = request.getParameter("productId");

        shoppingCartService.removeItem(a.getAccount(), productId);

        showShoppingCart(request, response);
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");
        String productId = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");

        if (quantityParam != null) {
            int quantity = Integer.parseInt(quantityParam);
            try {
                shoppingCartService.updateQuantity(a.getAccount(), productId, quantity);
            } catch (ValidationException e) {
                request.setAttribute("error", e.getMessage());
                showShoppingCart(request, response);
                return;
            }
        }
        request.getSession().setAttribute("success", "Item updated");
        response.sendRedirect(request.getContextPath() + "/user/cart");
    }

    private void clearCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");

        shoppingCartService.clearCart(a.getAccount());

        request.getSession().setAttribute("success", "Shopping cart cleared");
        response.sendRedirect(request.getContextPath() + "/user/cart");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
