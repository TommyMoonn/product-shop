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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (getUser(request) == null) {
            //user is not logged in -> redirect to login page
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
                handleProduct(request, response);
                break;
            case "category":
                handleCategory(request, response);
                break;
            case "account":
                handleAccount(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
        }
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

    public void handleProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = getUser(request);
        String type = request.getParameter("type");
        String action = request.getParameter("action");

        String url;
        if (action.equals("list")) {
            url = resolveUrl(type, "list");
        } else if (Role.isAdmin(a.getRoleInSystem()) || Role.isManager(a.getRoleInSystem())) {
            url = resolveUrl(type, action);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    public void handleCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = getUser(request);
        String type = request.getParameter("type");
        String action = request.getParameter("action");

        String url;
        if (action.equals("list")) {
            url = resolveUrl(type, "list");
        } else if (Role.isAdmin(a.getRoleInSystem()) || Role.isManager(a.getRoleInSystem())) {
            url = resolveUrl(type, action);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    public void handleAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account a = getUser(request);
        String type = request.getParameter("type");
        String action = request.getParameter("action");

        String url;
        if (Role.isAdmin(a.getRoleInSystem())) {
            url = resolveUrl(type, action);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        request.getRequestDispatcher("/" + url).forward(request, response);
    }

    //helper class to get user 
    private Account getUser(HttpServletRequest request) {
        return (Account) request.getSession().getAttribute("user");
    }

    //returns a string url "type/action"
    private String resolveUrl(String type, String action) {
        return type + "/" + action;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
