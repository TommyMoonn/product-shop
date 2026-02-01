package utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletContext;

public class DBConnection {

    private String hostName;
    private String port;
    private String dbName;
    private String user;
    private String password;

    public DBConnection() {
        this.hostName = "localhost";
        this.port = "1433";
        this.dbName = "ProductIntro";
        this.user = "sa";
        this.password = "12345";
    }

    public DBConnection(ServletContext sc) {
        this.hostName = sc.getInitParameter("hostAddress");
        this.dbName = sc.getInitParameter("dbName");
        this.port = sc.getInitParameter("dbPort");
        this.user = sc.getInitParameter("userName");
        this.password = sc.getInitParameter("usePass");
    }

    public String getURL() {
        return String.format("jdbc:sqlserver://%s:%s;DatabaseName=%s;user=%s;Password=%s;",
                this.hostName, this.port, this.dbName, this.user, this.password);
    }

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(getURL());
    }
}
