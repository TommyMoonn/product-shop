package models.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.entity.Account;
import models.entity.Category;
import models.entity.Product;
import utilities.DBConnection;

public class CategoryDAO implements Accessible<Category> {

    public CategoryDAO() {
    }

    private Connection getConnection()
            throws ClassNotFoundException, SQLException {
        return new DBConnection().getConnection();
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
        Category result = null;
        String sql = "SELECT typeId, categoryName, memo"
                + " FROM categories WHERE typeId = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next() && result == null) {
                result = new Category(rs.getInt(1), rs.getString(2), rs.getString(3));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public List<Category> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
