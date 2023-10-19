/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexionBD;

import java.sql.*;
public class conexion {
    
    
    static final String conexionURL="jdbc:sqlserver://localhost:1433;"
            + "database=LucianoGym;"
            + "user=sa;"
            + "password=sa;"
            + "loguitimeout=30;"
            + "encrypt=true;trustServerCertificate=true";
    public static Connection getConexion(){
        try {
        return DriverManager.getConnection(conexionURL);
        } catch (SQLException e) {
             System.out.println("Error al conectar a la base de datos: " + e.toString());
                return null;
        }
       
    }
}
