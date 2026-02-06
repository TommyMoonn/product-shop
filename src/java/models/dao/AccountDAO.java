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
import utilities.DBConnection;

public class AccountDAO implements Accessible<Account> {

    public AccountDAO() {
    }

    private Connection getConnection()
            throws ClassNotFoundException, SQLException {
        return new DBConnection().getConnection();
    }

    @Override
    public int insert(Account obj) {
        int result = 0;
        String sql = "INSERT INTO accounts(account, pass, lastName, firstName,"
                + " birthday, gender, phone, isUse, roleInSystem)"
                + " VALUES(?,?,?,?,?,?,?,?,?)";
        try (Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getAccount());
            ps.setString(2, obj.getPass());
            ps.setString(3, obj.getLastName());
            ps.setString(4, obj.getFirstName());
            ps.setDate(5, obj.getBirthday());
            ps.setBoolean(6, obj.isGender());
            ps.setString(7, obj.getPhone());
            ps.setBoolean(8, obj.isIsUse());
            ps.setInt(9, obj.getRoleInSystem());
            
            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public int update(Account obj) {
        int result = 0;
        String sql = "UPDATE accounts SET pass = ?, lastName = ?, firstName = ?,"
                + " birthday = ?, gender = ?, phone = ?, isUse = ?, roleInSystem = ?"
                + " WHERE account = ?";
        try (Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, obj.getPass());
            ps.setString(2, obj.getLastName());
            ps.setString(3, obj.getFirstName());
            ps.setDate(4, obj.getBirthday());
            ps.setBoolean(5, obj.isGender());
            ps.setString(6, obj.getPhone());
            ps.setBoolean(7, obj.isIsUse());
            ps.setInt(8, obj.getRoleInSystem());
            ps.setString(9, obj.getAccount());
            
            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM accounts WHERE account = ?";
        try (Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, id);
            
            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public Account getById(String id) {
        Account result = null;
        String sql = "SELECT account, pass, lastName, firstName,"
                + " birthday, gender, phone, isUse, roleInSystem"
                + " FROM accounts"
                + " WHERE account = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            while (rs.next() && result == null) {
                result = new Account(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getDate(5), rs.getBoolean(6), rs.getString(7), rs.getBoolean(8), rs.getInt(9));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    @Override
    public List<Account> getAll() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT account, pass, lastName, firstName,"
                + " birthday, gender, phone, isUse, roleInSystem"
                + " FROM accounts";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Account acc = new Account();

                acc.setAccount(rs.getString(1));
                acc.setPass(rs.getString(2));
                acc.setLastName(rs.getString(3));
                acc.setFirstName(rs.getString(4));
                acc.setBirthday(rs.getDate(5));
                acc.setGender(rs.getBoolean(6));
                acc.setPhone(rs.getString(7));
                acc.setIsUse(rs.getBoolean(8));
                acc.setRoleInSystem(rs.getInt(9));

                list.add(acc);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int updateIsUsed(String acc, boolean isUsed) {
        int result = 0;
        String sql = "UPDATE accounts"
                + " SET isUse = ?"
                + " WHERE account = ?";
        try ( Connection cn = getConnection()) {
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setBoolean(1, isUsed);
            ps.setString(2, acc);

            result = ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public Account authenticate(String account, String pass) {
        Account a = getById(account);
        if (a == null) {
            return null;
        }
        if (a.getPass().equals(pass)) {
            return a;
        }
        return null;
    }
}
