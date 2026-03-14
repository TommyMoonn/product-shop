package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Order;
import models.services.OrderService;

@WebServlet(name = "AdminOrderController", urlPatterns = {"/admin/order"})
public class AdminOrderController extends HttpServlet {

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
                showOrderDetails(request, response);
                break;
            default:
                showOrderList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch(action) {
            case "updateStatus":
                updateOrderStatus(request, response);
                break;
        }
    }

    private void showOrderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String statusParam = request.getParameter("status");
        
        Integer status = (statusParam != null) ? Integer.parseInt(statusParam) : null;
        
        request.setAttribute("orders", orderService.getOrdersByStatus(status));
        request.setAttribute("orderCount", orderService.getOrdersByStatus(null).size());
        request.setAttribute("pendingOrderCount", orderService.getOrdersByStatus(0).size());
        request.setAttribute("processingOrderCount", orderService.getOrdersByStatus(1).size());
        request.setAttribute("completedOrderCount", orderService.getOrdersByStatus(2).size());
        request.getRequestDispatcher("order/order-list.jsp").forward(request, response);
    }

    private void showOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        Integer orderId;
        if (orderIdParam != null) {
             orderId = Integer.parseInt(orderIdParam);
             request.setAttribute("order", orderService.getOrder(orderId));
             request.setAttribute("orderDetails", orderService.getOrderDetail(orderId));
        }
        
        request.getRequestDispatcher("order/order-detail.jsp").forward(request, response);
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        String statusParam = request.getParameter("status");
        
        Integer orderId;
        Integer status;
        if (orderIdParam != null && statusParam != null) {
            orderId = Integer.parseInt(orderIdParam);
            status = Integer.parseInt(statusParam);
            
            orderService.updateOrderStatus(orderId, status);
        }

        showOrderDetails(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
