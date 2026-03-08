package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.entities.Account;
import models.entities.Role;
import models.services.AccountService;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        request.removeAttribute("error");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String account = request.getParameter("account").trim();
        String pass = request.getParameter("pass").trim();

        AccountService accountService = new AccountService();
        Account a = accountService.authenticate(account, pass);

        if (a == null) {
            request.setAttribute("error", "Invalid account or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        //check if the account is deactivated
        if (!a.getActive()) {
            request.setAttribute("error", "Account is deactivated. Please contact the administrator for more information.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        //get the current active session
        //if it exists -> invalidate it
        //the false parameter passed in: if there is an active session then return it else return null
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        //create a new session
        HttpSession newSession = request.getSession();
        newSession.setAttribute("user", a);

        if (Role.isCustomer(a.getRoleInSystem())) {
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            return;
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
