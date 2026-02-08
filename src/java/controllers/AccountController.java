

package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.entities.Account;
import models.services.AccountService;

@WebServlet(name="AccountController", urlPatterns={"/account"})
public class AccountController extends HttpServlet {
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
                showAccountList(request,response);
                break;
            case "add":
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
                break;
            case "update":
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
                break;
            case "delete":
                response.sendRedirect(request.getContextPath() + "/views/unsupported-feature.jsp");
                break;
            default: 
                response.sendRedirect(request.getContextPath() + "product");
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    public void showAccountList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<Account> list = accountService.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/views/account/account-list.jsp").forward(request, response);
    }
    
    public void showAccountAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void addAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void showAccountUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void updateAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void updateIsUse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    public void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
