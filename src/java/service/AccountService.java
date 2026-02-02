package service;

import java.util.List;
import models.dao.AccountDAO;
import models.entity.Account;

public class AccountService {

    private AccountDAO accountDAO = new AccountDAO();

    public void add(Account account) {
        accountDAO.insert(account);
    }

    public void update(Account account) {
        accountDAO.update(account);
    }

    public void delete(String id) {
        accountDAO.delete(id);
    }
    
    public Account getById(String id) {
        return accountDAO.getById(id);
    }

    public List<Account> getAll() {
        return accountDAO.getAll();
    }
    
    public void updateIsUsed(String account, boolean isUsed) {
        accountDAO.updateIsUsed(account, isUsed);
    }
    
    public Account auth(String account, String pass) {
        return accountDAO.authenticate(account, pass);
    }
}