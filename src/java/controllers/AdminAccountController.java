package controllers;

import exceptions.ValidationException;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.services.AccountService;

@WebServlet(name = "AccountController", urlPatterns = {"/admin/account"})
public class AdminAccountController extends HttpServlet {

    private AccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showAccountList(request, response);
                break;
            case "add":
                showAccountAddForm(request, response);
                break;
            case "update":
                showAccountUpdateForm(request, response);
                break;
            case "activate":
                updateAccountStatus(request, response, true);
                break;
            case "deactivate":
                updateAccountStatus(request, response, false);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/unsupported-feature.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addAccount(request, response);
                break;
            case "update":
                updateAccount(request, response);
                break;
            case "delete":
                deleteAccount(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/unsupported-feature.jsp");
        }
    }

    public void showAccountList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", accountService.findAll());
        request.getRequestDispatcher("/admin/account/account-list.jsp").forward(request, response);
    }

    public void showAccountAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("today", LocalDate.now());
        request.getRequestDispatcher("/admin/account/account-add.jsp").forward(request, response);
    }

    public void addAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        a.setRoleInSystem(Integer.parseInt(request.getParameter("role")));

        try {
            accountService.create(a);
            response.sendRedirect(request.getContextPath() + "/admin/account?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showAccountAddForm(request, response);
        }
    }

    public void showAccountUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        Account a = accountService.findById(account);

        request.setAttribute("account", a);
        request.setAttribute("today", LocalDate.now());
        request.getRequestDispatcher("/admin/account/account-update.jsp").forward(request, response);
    }

    public void updateAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        Account a = accountService.findById(account);
        if (a == null) {
            throw new ServletException("Account does not exist.");
        }

        a.setPass(request.getParameter("pass"));
        a.setFirstName(request.getParameter("firstName"));
        a.setLastName(request.getParameter("lastName"));
        Date birthday;
        try {
            birthday = new SimpleDateFormat("yyyy-MM-dd")
                    .parse(request.getParameter("birthday"));
            a.setBirthday(birthday);
        } catch (ParseException ex) {
            throw new ServletException("Invalid birthday format", ex);
        }
        a.setGender(Boolean.valueOf(request.getParameter("gender")));
        a.setPhone(request.getParameter("phone"));
        a.setRoleInSystem(Integer.parseInt(request.getParameter("role")));

        try {
            accountService.update(a);
            response.sendRedirect(request.getContextPath() + "/admin/account?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("account", a);
            request.setAttribute("today", LocalDate.now());
            request.getRequestDispatcher("/admin/account/account-update.jsp").forward(request, response);
        }
    }

    public void updateAccountStatus(HttpServletRequest request, HttpServletResponse response, boolean status) throws ServletException, IOException {
        String account = request.getParameter("account");
        try {
            accountService.updateIsUsed(account, status);
            response.sendRedirect(request.getContextPath() + "/admin/account?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showAccountList(request, response);
        }
    }

    public void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        try {
            accountService.delete(account);
            response.sendRedirect(request.getContextPath() + "/admin/account?action=list");
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            showAccountList(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
