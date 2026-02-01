package models.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;
import models.entity.Account;
import utilities.DBConnection;

public class AccountDAO implements Accessible<Account> {
    private ServletContext sc;
    private Connection connection;

    public AccountDAO() {
    }

    public AccountDAO(ServletContext sc)
            throws ClassNotFoundException, SQLException {
        this.sc = sc;
    }
    
    private Connection getConnection(ServletContext sc) 
            throws ClassNotFoundException, SQLException {
        this.connection = new DBConnection().getConnection();
        return this.connection;
    }

    @Override
    public int insert(Account obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int update(Account obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int delete(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Account getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Account> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public int updateIsUsed(String acc, boolean isUsed) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public Account authenticate(String acc, String pass) {
        Account account = null;
        return account;
    }
}