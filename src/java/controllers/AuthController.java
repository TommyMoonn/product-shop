package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.entities.Account;

@WebServlet(name = "AuthController", urlPatterns = {"/authentication"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");

        if (a == null) {
            response.sendRedirect("login");
        }

        String type = request.getParameter("type");

        switch (type) {
            case "products":
                handleProduct(request, response);
                break;
            case "category":
                handleCategory(request, response);
                break;
            case "accounts":
                if (a != null && a.getRoleInSystem() == 1) {
                    handleAccount(request, response);
                }
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    public void handleProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        String action = request.getParameter("action");

        if (isAdminOnlyAction(action) && a.getRoleInSystem() != 1) {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }
        
        String url = null;
        switch (action) {
            case "add":
                url = "product?action=add";
                break;
            case "delete":
                url = "product?action=delete";
                break;
            case "update":
                url = "product?action=update";
                break;
            case "list":
                url = "product?action=list";
                break;
        }
        request.getRequestDispatcher(request.getContextPath() + url).forward(request, response);
    }

    public void handleCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        String action = request.getParameter("action");

        if (isAdminOnlyAction(action) && a.getRoleInSystem() != 1) {
            response.sendRedirect("/views/access-denied.jsp");
            return;
        }

        String url = null;
        switch (action) {
            case "add":
                url = "category?action=add";
                break;
            case "delete":
                url = "category?action=delete";
                break;
            case "update":
                url = "category?action=update";
                break;
            case "list":
                url = "category?action=list";
                break;
        }
        request.getRequestDispatcher(request.getContextPath() + url).forward(request, response);
    }

    public void handleAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;
        switch (action) {
            case "add":
                url = "category?action=add";
                break;
            case "delete":
                url = "category?action=delete";
                break;
            case "update":
                url = "category?action=update";
                break;
            case "list":
                url = "category?action=list";
                break;
        }
        request.getRequestDispatcher(request.getContextPath() + url).forward(request, response);
    }

    public boolean isAdminOnlyAction(String action) {
        return "add".equalsIgnoreCase(action)
                || "update".equalsIgnoreCase(action)
                || "delete".equalsIgnoreCase(action);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
