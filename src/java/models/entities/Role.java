package models.entities;

public final class Role {
    public static final int CUSTOMER = 0;
    public static final int ADMIN = 1;
    public static final int MANAGER = 2;
    public static final int STAFF = 3;
    
    private Role() {
    }
    
    public static boolean isValid(int role) {
        return role == ADMIN || role == MANAGER || role == STAFF || role == CUSTOMER;
    }
    
    public static boolean isCustomer(int role) {
        return role == CUSTOMER;
    }
    
    public static boolean isAdmin(int role) {
        return role == ADMIN;
    }
    
    public static boolean isManager(int role) {
        return role == MANAGER;
    }
    
    public static boolean isStaff(int role) {
        return role == STAFF;
    }
}
