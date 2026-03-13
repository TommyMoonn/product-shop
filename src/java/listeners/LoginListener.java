package listeners;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import models.entities.Account;

@WebListener
public class LoginListener implements HttpSessionAttributeListener {

    private static final Map<String, HttpSession> loggedUsers = new HashMap<>();

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {

        if ("user".equals(event.getName())) {

            Account acc = (Account) event.getValue();
            String a = acc.getAccount();

            HttpSession newSession = event.getSession();
            HttpSession oldSession = loggedUsers.get(a);

            if (oldSession != null && oldSession != newSession) {
                oldSession.invalidate(); 
            }

            loggedUsers.put(a, newSession);
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {

        if ("user".equals(event.getName())) {
            Account acc = (Account) event.getValue();
            loggedUsers.remove(acc.getAccount());
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent se) {
    }
}
