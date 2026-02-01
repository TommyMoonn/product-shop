package models.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;
import models.entity.Category;
import utilities.DBConnection;

public class CategoryDAO implements Accessible<Category> {

    private ServletContext sc;
    private Connection connection;

    public CategoryDAO() {
    }

    public CategoryDAO(ServletContext sc)
            throws ClassNotFoundException, SQLException {
        this.sc = sc;
    }

    private Connection getConnection(ServletContext sc) 
            throws ClassNotFoundException, SQLException {
        this.connection = new DBConnection().getConnection();
        return this.connection;
    }

    @Override
    public int insert(Category obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int update(Category obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int delete(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Category getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Category> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
