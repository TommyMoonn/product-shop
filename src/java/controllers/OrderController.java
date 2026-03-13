package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.entities.Cart;
import models.entities.Product;
import models.services.OrderService;
import models.services.ProductService;
import models.services.ShoppingCartService;

@WebServlet(name = "OrderController", urlPatterns = {"/user/order"})
public class OrderController extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showOrderList(request, response);
                break;
            case "detail":
                showOrderDetail(request, response);
                break;
            case "checkout":
                showCheckoutForm(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/unsupported-feature.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String customerAddress = request.getParameter("customerAddress");

        String buyNow = request.getParameter("buyNow");
        if ("true".equals(buyNow)) {
            String productId = request.getParameter("productId");
            orderService.checkoutSingleProduct(a.getAccount(), productId, customerName, customerPhone, customerAddress);

        } else {
            orderService.checkout(a.getAccount(), customerName, customerPhone, customerAddress);
        }

        response.sendRedirect(request.getContextPath() + "/user/order");
    }

    public void showOrderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");

        request.setAttribute("orders", orderService.getOrders(a.getAccount()));
        request.getRequestDispatcher("order-list.jsp").forward(request, response);
    }

    public void showOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam != null) {
            int orderId = Integer.parseInt(orderIdParam);
            request.setAttribute("details", orderService.getOrderDetail(orderId));
            request.setAttribute("order", orderService.getOrder(orderId));
        }

        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
    }

    public void showCheckoutForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("user");

        String buyNow = request.getParameter("buyNow");
        if ("true".equals(buyNow)) {

            String productId = request.getParameter("productId");

            ProductService productService = new ProductService();
            Product p = productService.findById(productId);

            request.setAttribute("buyNowProduct", p);

        } else {

            ShoppingCartService shoppingCartService = new ShoppingCartService();
            Cart cart = shoppingCartService.getOrCreate(a.getAccount());

            request.setAttribute("cart", cart);
        }

        request.getRequestDispatcher("order-checkout.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
