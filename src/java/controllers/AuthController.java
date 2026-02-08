package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.entities.Role;

@WebServlet(name = "AuthController", urlPatterns = {"/auth"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = getUser(request);

        if (!isLoggedIn(request)) {
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
            response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
            return;
        }

        switch (type) {
            case "product":
                handleProduct(request, response, type, action);
                break;
            case "category":
                handleCategory(request, response, type, action);
                break;
            case "account":
                handleAccount(request, response, type, action);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    public void handleProduct(HttpServletRequest request, HttpServletResponse response, String type, String action)
            throws ServletException, IOException {
        Account a = getUser(request);

        String url;
        if (canManageProducts(a)) {
            url = resolveUrl(type, action);
        } else if (action.equals("list")) {
            url = resolveUrl(type, "list");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    public void handleCategory(HttpServletRequest request, HttpServletResponse response, String type, String action)
            throws ServletException, IOException {
        Account a = getUser(request);

        String url;
        if (canManageCategories(a)) {
            url = resolveUrl(type, action);
        } else if (action.equals("list")) {
            url = resolveUrl(type, "list");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    public void handleAccount(HttpServletRequest request, HttpServletResponse response, String type, String action)
            throws ServletException, IOException {
        Account a = getUser(request);

        String url;
        if (canManageAccounts(a)) {
            url = resolveUrl(type, action);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    private boolean isLoggedIn(HttpServletRequest request) {
        return request.getSession().getAttribute("user") != null;
    }

    private Account getUser(HttpServletRequest request) {
        return (Account) request.getSession().getAttribute("user");
    }

    private String resolveUrl(String type, String action) {
        return type + "?action=" + action;
    }

    private boolean canManageAccounts(Account a) {
        return Role.isAdmin(a.getRoleInSystem());
    }

    private boolean canManageProducts(Account a) {
        return Role.isAdmin(a.getRoleInSystem()) || Role.isManager(a.getRoleInSystem());
    }

    private boolean canManageCategories(Account a) {
        return Role.isAdmin(a.getRoleInSystem()) || Role.isManager(a.getRoleInSystem());
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
