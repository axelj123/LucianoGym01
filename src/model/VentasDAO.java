/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import conexionBD.conexion;
import java.sql.*;
import javax.swing.JOptionPane;

/**
 *
 * @author User
 */
public class VentasDAO {

    conexion cn = new conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    Venta ven = new Venta();
    DetalleVenta dv = new DetalleVenta();

 public void GeneraVenta(DetalleVenta dv) {
    Connection con = null;
    CallableStatement cs = null;

    try {
        con = cn.getConexion();
        con.setAutoCommit(false); // Deshabilitar la confirmación automática

        // Llamar al procedimiento almacenado con los parámetros necesarios
        String sql = "{CALL InsertarVentaConDetalle (?, ?, ?, ?, ?)}";
        cs = con.prepareCall(sql);
        cs.setDouble(1, dv.getSubTotal());
        cs.setInt(2, dv.getProductoId());
        cs.setInt(3, dv.getCantidadVenta());
        cs.setDouble(4, dv.getPrecioUnitario());
        cs.setDouble(5, dv.getSubTotal());

        cs.executeUpdate();

        con.commit(); // Confirmar la transacción

        JOptionPane.showMessageDialog(null, "Venta registrada con éxito");

    } catch (SQLException e) {
        System.out.println(e.toString());
        try {
            if (con != null) {
                con.rollback(); // Revertir la transacción en caso de error
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    } finally {
        // Cerrar recursos
        try {
            if (cs != null) {
                cs.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}


}
