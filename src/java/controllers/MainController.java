package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.entities.Role;

@WebServlet(name = "MainController", urlPatterns = {"/main"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        Account a = (Account) request.getSession().getAttribute("user");
        if (a == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String type = request.getParameter("type");
        String action = request.getParameter("action");
        if (type == null) {
            response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
            return;
        }

        if (action == null) {
            action = "list";
        }

        if (!isValidAction(action)) {
            response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
            return;
        }

        int role = a.getRoleInSystem();
        if (!hasPermission(role, type, action)) {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        String url = resolveUrl(type, action);
        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private String resolveUrl(String type, String action) {
        return type + "?action=" + action;
    }

    /*
    Authorization
    
    Admin -> full access
    
    Manager:
        Product -> list, detail, update and delete
        Category -> list, add and update
        Account -> no access
    Staff: 
        Product -> list, detail, add and update
        Category -> list
        Account -> no access
     */
    private boolean hasPermission(int role, String type, String action) {
        if (Role.isAdmin(role)) {
            return true;
        }

        switch (type) {
            case "product":
                if (Role.isManager(role)) {
                    return "list".equals(action)
                            || "detail".equals(action)
                            || "update".equals(action)
                            || "delete".equals(action);
                }
                if (Role.isStaff(role)) {
                    return "list".equals(action)
                            || "detail".equals(action)
                            || "add".equals(action)
                            || "update".equals(action);
                }
                return false;
            case "category":
                if (Role.isManager(role)) {
                    return "list".equals(action)
                            || "add".equals(action)
                            || "update".equals(action);
                }
                if (Role.isStaff(role)) {
                    return "list".equals(action);
                }
                return false;
            case "account":
                return false;
        }

        return false;
    }

    private boolean isValidAction(String action) {
        return "list".equals(action)
                || "detail".equals(action)
                || "add".equals(action)
                || "update".equals(action)
                || "delete".equals(action)
                || "activate".equals(action)
                || "deactivate".equals(action);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
