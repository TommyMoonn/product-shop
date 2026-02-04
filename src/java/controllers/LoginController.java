package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.entity.Account;
import service.AccountService;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.removeAttribute("error");
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String account = request.getParameter("account");
        String pass = request.getParameter("pass");

        AccountService accountService = new AccountService();
        Account a = accountService.auth(account, pass);

        if (a == null) {
            request.setAttribute("error", "Invalid account or password");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        //get the current active session
        //if it exists -> invalidate it
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        //create a new session
        HttpSession newSession = request.getSession();
        newSession.setAttribute("user", a);

        response.sendRedirect(request.getContextPath());
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
