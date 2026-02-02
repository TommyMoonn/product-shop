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
                + " brief, postedDate, typeId, account, unit, price, discount)"
                + " VALUES(?,?,?,?,?,?,?,?,?,?)";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getProductId());
            ps.setString(2, obj.getProductName());
            ps.setString(3, obj.getProductImage());
            ps.setString(4, obj.getBrief());
            ps.setDate(5, obj.getPostedDate());
            ps.setInt(6, obj.getType().getTypeId());
            ps.setString(7, obj.getAccount().getAccount());
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
        try ( Connection cn = getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, obj.getProductName());
            ps.setString(2, obj.getProductImage());
            ps.setString(3, obj.getBrief());
            ps.setDate(4, obj.getPostedDate());
            ps.setInt(5, obj.getType().getTypeId());
            ps.setString(6, obj.getAccount().getAccount());
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
        try ( Connection cn = getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
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
        String sql
                = "SELECT "
                + " p.productId, p.productName, p.productImage, p.brief,"
                + " p.postedDate, p.unit, p.price, p.discount,"
                + " c.typeId, c.categoryName, c.memo,"
                + " a.account, a.lastName, a.firstName, a.phone, a.roleInSystem, a.isUse"
                + " FROM products p"
                + " JOIN categories c ON p.typeId = c.typeId"
                + " JOIN accounts a ON p.account = a.account"
                + " WHERE p.productId = ?";

        try ( Connection cn = getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && result == null) {
                Category c = new Category();
                c.setTypeId(rs.getInt(9));        
                c.setCategoryName(rs.getString(10));        
                c.setMemo(rs.getString(11));    

                Account a = new Account();
                a.setAccount(rs.getString(12));
                a.setLastName(rs.getString(13));
                a.setFirstName(rs.getString(14));
                a.setPhone(rs.getString(15));
                a.setRoleInSystem(rs.getInt(16));
                a.setIsUse(rs.getBoolean(17));

                Product p = new Product();
                p.setProductId(rs.getString(1));
                p.setProductName(rs.getString(2));
                p.setProductImage(rs.getString(3));
                p.setBrief(rs.getString(4));
                p.setPostedDate(rs.getDate(5));
                p.setUnit(rs.getString(6));
                p.setPrice(rs.getInt(7));
                p.setDiscount(rs.getInt(8));
                p.setType(c);
                p.setAccount(a);

                result = p;
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public List<Product> listByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql
                = "SELECT "
                + " p.productId, p.productName, p.productImage, p.brief,"
                + " p.postedDate, p.unit, p.price, p.discount,"
                + " c.typeId, c.categoryName, c.memo,"
                + " a.account, a.lastName, a.firstName, a.phone, a.roleInSystem, a.isUse"
                + " FROM products p"
                + " JOIN categories c ON p.typeId = c.typeId"
                + " JOIN accounts a ON p.account = a.account"
                + " WHERE c.typeId = ?";

        try ( Connection cn = getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setTypeId(rs.getInt(9));        
                c.setCategoryName(rs.getString(10));        
                c.setMemo(rs.getString(11));        

                Account a = new Account();
                a.setAccount(rs.getString(12));
                a.setLastName(rs.getString(13));
                a.setFirstName(rs.getString(14));
                a.setPhone(rs.getString(15));
                a.setRoleInSystem(rs.getInt(16));
                a.setIsUse(rs.getBoolean(17));

                Product p = new Product();
                p.setProductId(rs.getString(1));
                p.setProductName(rs.getString(2));
                p.setProductImage(rs.getString(3));
                p.setBrief(rs.getString(4));
                p.setPostedDate(rs.getDate(5));
                p.setUnit(rs.getString(6));
                p.setPrice(rs.getInt(7));
                p.setDiscount(rs.getInt(8));
                p.setType(c);
                p.setAccount(a);

                list.add(p);
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
        String sql
                = "SELECT "
                + " p.productId, p.productName, p.productImage, p.brief,"
                + " p.postedDate, p.unit, p.price, p.discount,"
                + " c.typeId, c.categoryName, c.memo,"
                + " a.account, a.lastName, a.firstName, a.phone, a.roleInSystem, a.isUse"
                + " FROM products p"
                + " JOIN categories c ON p.typeId = c.typeId"
                + " JOIN accounts a ON p.account = a.account";

        try ( Connection cn = getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setTypeId(rs.getInt(9));        
                c.setCategoryName(rs.getString(10));        
                c.setMemo(rs.getString(11));    

                Account a = new Account();
                a.setAccount(rs.getString(12));
                a.setLastName(rs.getString(13));
                a.setFirstName(rs.getString(14));
                a.setPhone(rs.getString(15));
                a.setRoleInSystem(rs.getInt(16));
                a.setIsUse(rs.getBoolean(17));

                Product p = new Product();
                p.setProductId(rs.getString(1));
                p.setProductName(rs.getString(2));
                p.setProductImage(rs.getString(3));
                p.setBrief(rs.getString(4));
                p.setPostedDate(rs.getDate(5));
                p.setUnit(rs.getString(6));
                p.setPrice(rs.getInt(7));
                p.setDiscount(rs.getInt(8));
                p.setType(c);
                p.setAccount(a);

                list.add(p);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
