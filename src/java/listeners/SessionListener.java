package listeners;

import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import models.entities.Account;

@WebListener
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        Account a = (Account) session.getAttribute("user");

        if (a != null) {
            ServletContext context = session.getServletContext();

            List<Account> onlineUsers = (List<Account>) context.getAttribute("onlineUsers");

            if (onlineUsers != null) {
                onlineUsers.removeIf(u -> u.getAccount().equals(a.getAccount()));
            }
        }
    }

}
