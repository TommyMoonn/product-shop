package models.services;

import models.entities.Account;
import models.entities.Role;

public class AuthorizationService {
    
    public static boolean hasPermission(Account user, String type, String action) {
        int role = user.getRoleInSystem();
        
        if (Role.isAdmin(role)) {
            return true;
        }

        switch (type) {
            case "product":
                if (Role.isManager(role)) {
                    return "list".equals(action)
                            || "detail".equals(action)
                            || "update".equals(action)
                            || "delete".equals(action);
                }
                if (Role.isStaff(role)) {
                    return "list".equals(action)
                            || "detail".equals(action)
                            || "add".equals(action)
                            || "update".equals(action);
                }
                return false;
            case "category":
                if (Role.isManager(role)) {
                    return "list".equals(action)
                            || "add".equals(action)
                            || "update".equals(action);
                }
                if (Role.isStaff(role)) {
                    return "list".equals(action);   
                }
                return false;
            case "account":
                return false;
        }

        return false;
    }
}
