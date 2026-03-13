package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import models.entities.Account;
import models.entities.Role;
import models.services.AccountService;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.removeAttribute("error");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String account = request.getParameter("account").trim();
        String pass = request.getParameter("pass").trim();

        HttpSession session = request.getSession();

        Integer attempts = (Integer) session.getAttribute("loginAttempts");
        Long lockTime = (Long) session.getAttribute("lockTime");

        if (attempts == null) {
            attempts = 0;
        }

        if (lockTime != null) {
            long diff = System.currentTimeMillis() - lockTime;

            if (diff < 600000) {
                request.setAttribute("error", "Too many failed attempts. Try again later.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            } else {
                session.removeAttribute("lockTime");
                session.setAttribute("loginAttempts", 0);
                attempts = 0;
            }
        }

        AccountService accountService = new AccountService();
        Account a = accountService.authenticate(account, pass);

        if (a == null) {
            attempts++;
            session.setAttribute("loginAttempts", attempts);

            if (attempts >= 3) {
                session.setAttribute("lockTime", System.currentTimeMillis());
                request.setAttribute("error", "Too many failed attempts. Login locked for 10 minutes.");
            } else {
                request.setAttribute("error", "Invalid account or password. Attempts left: " + (3 - attempts));
            }

            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (!a.getActive()) {
            request.setAttribute("error", "Account is deactivated. Please contact the administrator.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        session.setAttribute("user", a);

        ServletContext context = getServletContext();
        List<Account> onlineUsers = (List<Account>) context.getAttribute("onlineUsers");

        if (onlineUsers != null) {
            onlineUsers.removeIf(u -> u.getAccount().equals(a.getAccount()));
            onlineUsers.add(a);
        }

        session.removeAttribute("loginAttempts");
        session.removeAttribute("lockTime");

        if (Role.isCustomer(a.getRoleInSystem())) {
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/gateway.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Controller";
    }
}
