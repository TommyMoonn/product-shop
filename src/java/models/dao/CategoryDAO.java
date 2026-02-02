package models.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.entity.Category;
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
        int result = 0;
        String sql = "INSERT INTO categories(typeId, categoryName, memo)"
                + " VALUES(?,?,?)";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, obj.getTypeId());
            ps.setString(2, obj.getCategoryName());
            ps.setString(3, obj.getMemo());

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public int update(Category obj) {
        int result = 0;
        String sql = "UPDATE categories SET categoryName = ?, memo= ?"
                + " WHERE typeId = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getCategoryName());
            ps.setString(2, obj.getMemo());
            ps.setInt(3, obj.getTypeId());

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM categories WHERE typeId = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
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
        List<Category> list = new ArrayList<>();
        String sql = "SELECT typeId, categoryName, memo FROM categories";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();

                category.setTypeId(rs.getInt(1));
                category.setCategoryName(rs.getString(2));
                category.setMemo(rs.getString(3));

                list.add(category);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

}
