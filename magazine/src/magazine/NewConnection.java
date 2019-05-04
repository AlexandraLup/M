/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package magazine;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Alexandra
 */
public class NewConnection {

    public Connection getConnection() {
        Connection connection = null;

        try {
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "proiect", "proiect");
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex);
        }

        return connection;
    }

    public ResultSet executeStatement(Connection connection, String sql) {

        Statement stmt = null;
        ResultSet rs = null;

        try {
            stmt = connection.createStatement();
            rs = stmt.executeQuery(sql);

        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex);
        }

        return rs;
    }

    public void closeConnection(Connection connection) {
        try {
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(NewConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
