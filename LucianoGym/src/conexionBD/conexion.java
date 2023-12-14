/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexionBD;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class conexion {

    String conexionURL = "jdbc:mysql://localhost:3306/LucianoGym?user=root&password=axeljhosmell123";

    Connection cx;
    String driver = "com.mysql.cj.jdbc.Driver";

    public conexion() {

    }

    public Connection getConexion() {
        try {
            Class.forName(driver);
            cx = DriverManager.getConnection(conexionURL);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("No se conecto " + ex);
            Logger.getLogger(conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cx;
    }

}
