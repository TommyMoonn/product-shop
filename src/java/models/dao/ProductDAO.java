package models.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.entity.Account;
import models.entity.Category;
import models.entity.Product;
import utilities.DBConnection;

public class ProductDAO implements Accessible<Product> {

    public ProductDAO() {
    }

    private Connection getConnection()
            throws ClassNotFoundException, SQLException {
        return new DBConnection().getConnection();
    }

    @Override
    public int insert(Product obj) {
        int result = 0;
        String sql = "INSERT INTO products(productId, productName, productImage,"
                + " brief, postedDate, type, account, unit, price, discount)"
                + " VALUES(?,?,?,?,?,?,?,?,?,?)";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getProductId());
            ps.setString(2, obj.getProductName());
            ps.setString(3, obj.getProductImage());
            ps.setString(4, obj.getBrief());
            ps.setDate(5, obj.getPostedDate());
            ps.setInt(6, obj.getType().getTypeId());
            ps.setObject(7, obj.getAccount());
            ps.setString(8, obj.getUnit());
            ps.setInt(9, obj.getPrice());
            ps.setInt(10, obj.getDiscount());

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public int update(Product obj) {
        int result = 0;
        String sql = "UPDATE products SET productName = ?, productImage = ?,"
                + " brief = ?, postedDate = ?, typeId = ?, account = ?, unit = ?,"
                + " price = ?, discount = ?"
                + " WHERE productId = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getProductName());
            ps.setString(2, obj.getProductImage());
            ps.setString(3, obj.getBrief());
            ps.setDate(4, obj.getPostedDate());
            ps.setObject(5, obj.getType());
            ps.setObject(6, obj.getAccount());
            ps.setString(7, obj.getUnit());
            ps.setInt(8, obj.getPrice());
            ps.setInt(9, obj.getDiscount());
            ps.setString(10, obj.getProductId());

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;

    }

    @Override
    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM products WHERE productId = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public Product getById(String id) {
        Product result = null;
        String sql = "SELECT FROM products WHERE productId = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next() && result == null) {
                result = new Product(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getDate(5), (Category) rs.getObject(6),
                        (Account) rs.getObject(7), rs.getString(8), rs.getInt(9), rs.getInt(9));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    // needs to implement join logic in sql 
    public List<Product> listByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT productId, productName, productImage,"
                + " brief, postedDate, typeId, account, unit, price, discount"
                + " FROM products ";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                list.add(product);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    @Override
    public List<Product> getAll() {
        
        List<Product> list = new ArrayList<>();
        String sql = "SELECT productId, productName, productImage,"
                + " brief, postedDate, typeId, account, unit, price, discount"
                + " FROM products ";
        try ( Connection cn = getConnection()) {
            
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("Connected DB OK");
        System.out.println("FOUND PRODUCT: " + rs.getString(1));
                Product product = new Product();

                product.setProductId(rs.getString(1));
                product.setProductName(rs.getString(2));
                product.setProductImage(rs.getString(3));
                product.setBrief(rs.getString(4));
                product.setPostedDate(rs.getDate(5));
                product.setUnit(rs.getString(8));
                product.setPrice(rs.getInt(9));
                product.setDiscount(rs.getInt(10));

                // FK values
                int typeId = rs.getInt(6);
                String accountId = rs.getString(7);

                // Load objects properly
                Category c = null;
                Account a = null;

                product.setType(c);
                product.setAccount(a);

                list.add(product);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
