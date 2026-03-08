package controllers;

import exceptions.ValidationException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.entities.Role;
import models.services.AccountService;

@WebServlet(name="RegistrationController", urlPatterns={"/register"})
public class RegistrationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request,response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AccountService accountService = new AccountService();
        Account a = new Account();

        a.setAccount(request.getParameter("account"));
        a.setPass(request.getParameter("pass"));
        a.setFirstName(request.getParameter("firstName"));
        a.setLastName(request.getParameter("lastName"));
        Date birthday;
        try {
            //parse birthday string receieved from request
            birthday = new SimpleDateFormat("yyyy-MM-dd")
                    .parse(request.getParameter("birthday"));
            a.setBirthday(birthday);
        } catch (ParseException ex) {
            throw new ServletException("Invalid birthday format", ex);
        }
        a.setGender(Boolean.valueOf(request.getParameter("gender")));
        a.setPhone(request.getParameter("phone"));
        a.setActive(true); //active by default
        a.setRoleInSystem(Role.CUSTOMER); 

        try {
            accountService.create(a);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
