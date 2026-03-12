package filters;

import java.io.IOException;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.entities.Account;

@WebFilter(filterName="AdminFilter", urlPatterns={"/admin/*"}, dispatcherTypes={DispatcherType.REQUEST, DispatcherType.FORWARD})
public class AdminFilter implements Filter {

    public AdminFilter() {
    } 

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
	throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
         
        HttpSession session = req.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        Account user = (Account) session.getAttribute("user");
        
        if (user.getRoleInSystem() < 1) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }
        
        chain.doFilter(request, response);
    }
}
