package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.services.OrderService;
import models.services.ProductViewService;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {

    private OrderService orderService = new OrderService();
    private ProductViewService viewService = new ProductViewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("totalOrders", orderService.getOrderCount());
        request.setAttribute("totalRevenue", orderService.getTotalRevenue());
        request.setAttribute("recentOrders", orderService.getRecentOrders(5));
        request.setAttribute("ordersToday", orderService.getOrderCountToday());
        request.setAttribute("topSellingProducts", orderService.getTopSellingProducts(5));
        request.setAttribute("topViewedProducts", viewService.getTopViewedProducts(5));
        
        
        List<Account> onlineUsers = (List<Account>) getServletContext().getAttribute("onlineUsers");
        long onlineStaff = onlineUsers.stream().filter(a -> a.getRoleInSystem() > 0).count();
        request.setAttribute("onlineStaffCount", onlineStaff);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
