/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import conexionBD.conexion;
import java.awt.Image;
import java.sql.*;
import java.text.SimpleDateFormat;
import javax.swing.ImageIcon;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import view.jdlRealizarPago;

/**
 *
 * @author User
 */
public class ClienteDAO {

    conexion cn = new conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Cliente cl = new Cliente();

    public boolean registrarCliente(Cliente cl) {
        String sqlCallProcedure = "{call InsertarCliente1(?, ?, ?, ?, ?, ?, ?, ?, ?,?)}";

        Connection con = null;
        CallableStatement csInsertCliente = null;

        try {
            con = cn.getConexion();

            csInsertCliente = con.prepareCall(sqlCallProcedure);

            // Establecer los parámetros del procedimiento almacenado
            csInsertCliente.setInt(1, cl.getDni());
            csInsertCliente.setString(2, cl.getNombres());
            csInsertCliente.setString(3, cl.getApellidos());
            csInsertCliente.setInt(4, cl.getTelefono());
            csInsertCliente.setDate(5, cl.getFechaNacimiento());
            csInsertCliente.setBytes(6, cl.getFoto());
            csInsertCliente.setDouble(7, cl.getPrecioMembresia());
            csInsertCliente.setDouble(8, cl.getMontoPagado());
            csInsertCliente.setDate(9, cl.getFechaInicio());
            csInsertCliente.setDate(10, cl.getFechaFin());

            // Ejecutar el procedimiento almacenado
            csInsertCliente.execute();

            return true;
        } catch (SQLException e) {
            System.out.println("Error al registrar el cliente: " + e.getMessage());
            return false;
        } finally {
            try {
                if (csInsertCliente != null) {
                    csInsertCliente.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException closeEx) {
                System.out.println("Error al cerrar la conexión: " + closeEx.getMessage());
            }
        }
    }

    public void ListarHistorialMembresias() {

    }

    public void ListarClientesBuscarNew(JTable tblBuscar, JLabel cantidad) {
        String sql = "SELECT *\n"
                + "FROM VistaUsuarios u";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            // Crear un CustomTableModel que incluye una columna para la imagen
            String[] columnNames = {"Codigo", "DNI", "Nombres", "Apellidos", "Telefono", "FechaNacimiento"};
            DefaultTableModel model = (DefaultTableModel) tblBuscar.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                int codigo = rs.getInt("Codigo");
                int dni = rs.getInt("DNI");
                String nombres = rs.getString("Nombres");
                String apellidos = rs.getString("Apellidos");
                int telefono = rs.getInt("Telefono");
                Date fechaNacimiento = rs.getDate("FechaNacimiento");

                // Utiliza los métodos setter para asignar los valores a un objeto Cliente
                Cliente cliente = new Cliente();
                cliente.setCodigo(codigo);
                cliente.setDni(dni);
                cliente.setNombres(nombres);
                cliente.setApellidos(apellidos);
                cliente.setTelefono(telefono);
                cliente.setFechaNacimiento(fechaNacimiento);
                model.addRow(new Object[]{cliente.getCodigo(), cliente.getDni(), cliente.getNombres(), cliente.getApellidos(), cliente.getTelefono(), cliente.getFechaNacimiento()});

            }
            int n = tblBuscar.getRowCount();
            cantidad.setText(String.valueOf(n));
        } catch (SQLException e) {
            // Manejar las excepciones aquí
            System.out.println(e);
        }
    }

    public void buscarClientes(Cliente cl, JTable tblBuscar, JLabel lblTotal) {
        String sql = "{call BuscarUsuariosPorApellidos(?)}";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, cl.getApellidos());
            rs = ps.executeQuery();

            // Eliminar todas las filas existentes en la tabla
            DefaultTableModel model = (DefaultTableModel) tblBuscar.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                int codigo = rs.getInt("Codigo");
                int dni = rs.getInt("DNI");
                String nombres = rs.getString("Nombres");
                String apellidos = rs.getString("Apellidos");
                int telefono = rs.getInt("Telefono");
                Date fechaNacimiento = rs.getDate("FechaNacimiento");

                // Crea un nuevo objeto Cliente y agrega los datos
                Cliente cliente = new Cliente();
                cliente.setCodigo(codigo);
                cliente.setDni(dni);
                cliente.setNombres(nombres);
                cliente.setApellidos(apellidos);
                cliente.setTelefono(telefono);
                cliente.setFechaNacimiento(fechaNacimiento);

                // Agrega el objeto Cliente como una nueva fila en la tabla
                model.addRow(new Object[]{cliente.getCodigo(), cliente.getDni(), cliente.getNombres(), cliente.getApellidos(), cliente.getTelefono(), cliente.getFechaNacimiento()});
            }

            int n = tblBuscar.getRowCount();
            lblTotal.setText(String.valueOf(n));

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }

    public void VenceHoy(JTable tblBuscar) {
        String sql = "SELECT *\n"
                + "FROM VistaHistorialSocio; ";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            // Eliminar todas las filas existentes en la tabla
            DefaultTableModel model = (DefaultTableModel) tblBuscar.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                cl.setCodigo(rs.getInt("ClienteID"));
                cl.setApellidos(rs.getString("Apellidos"));
                cl.setNombres(rs.getString("Nombres"));
                cl.setTelefono(rs.getInt("Telefono"));
                cl.setFechaInicio(rs.getDate("FechaInicio"));
                cl.setFechaFin(rs.getDate("FechaFin"));
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String[] registros = {
                    String.valueOf(cl.getCodigo()), cl.getApellidos(),
                    cl.getNombres(),
                    String.valueOf(cl.getTelefono()),
                    dateFormat.format(cl.getFechaInicio()),
                    dateFormat.format(cl.getFechaFin())
                };

                model.addRow(registros);
            }

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }

    public void VenceMañana(JTable tblBuscar) {
        String sql = "SELECT *\n"
                + "FROM VistaHistorialSocioMañana; ";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            // Eliminar todas las filas existentes en la tabla
            DefaultTableModel model = (DefaultTableModel) tblBuscar.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                cl.setCodigo(rs.getInt("ClienteID"));
                cl.setApellidos(rs.getString("Apellidos"));
                cl.setNombres(rs.getString("Nombres"));
                cl.setTelefono(rs.getInt("Telefono"));
                cl.setFechaInicio(rs.getDate("FechaInicio"));
                cl.setFechaFin(rs.getDate("FechaFin"));
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String[] registros = {
                    String.valueOf(cl.getCodigo()), cl.getApellidos(),
                    cl.getNombres(),
                    String.valueOf(cl.getTelefono()),
                    dateFormat.format(cl.getFechaInicio()),
                    dateFormat.format(cl.getFechaFin())
                };

                model.addRow(registros);
            }

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }

    public void ListarHistorial(JTable tblHistorial) {
        String sql = "SELECT * FROM HistorialSocio ";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            // Eliminar todas las filas existentes en la tabla
            DefaultTableModel model = (DefaultTableModel) tblHistorial.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                cl.setCodigo(rs.getInt("ClienteID"));
                cl.setApellidos(rs.getString("Apellidos"));
                cl.setNombres(rs.getString("Nombres"));
                cl.setTelefono(rs.getInt("Telefono"));
                cl.setFechaInicio(rs.getDate("FechaInicio"));
                cl.setFechaFin(rs.getDate("FechaFin"));
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String[] registros = {
                    String.valueOf(cl.getCodigo()), cl.getApellidos(),
                    cl.getNombres(),
                    String.valueOf(cl.getTelefono()),
                    dateFormat.format(cl.getFechaInicio()),
                    dateFormat.format(cl.getFechaFin())
                };

                model.addRow(registros);
            }

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }

    public void InsertarNuevaMembresia(Cliente cl) {

        String sql = "{call newMembresia(?, ?, ?, ?, ?)}";
        try {

            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, cl.getCodigo()); // Usar el ID del cliente
            ps.setDouble(2, cl.getPrecioMembresia());
            ps.setDouble(3, cl.getMontoPagado());
            ps.setDate(4, cl.getFechaInicio());
            ps.setDate(5, cl.getFechaFin());
            ps.executeUpdate();

            JOptionPane.showMessageDialog(null, "Se registró correctamente");
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean puedeRegistrarNuevaMembresia(int clienteID) {
        String sql = "{CALL ValidarNuevaMembresia(?)}";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, clienteID);
            ResultSet rs = ps.executeQuery();

            return rs.next(); // Si hay al menos un cliente que cumple las condiciones, devuelve true
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            // Cerrar la conexión y otros recursos aquí si es necesario
        }

        return false; // Si ocurre un error o no hay resultados, la validación falla
    }

    public void ListaPagosPendientes(JTable mostrar, JLabel lblPagosPendientes) {

        String sql = "SELECT * FROM VistaClientesConDeuda";

        DefaultTableModel model = (DefaultTableModel) mostrar.getModel();
        model.setRowCount(0);
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                cl.setCodigo(rs.getInt("Codigo"));
                cl.setNombres(rs.getString("Nombres"));
                cl.setApellidos(rs.getString("Apellidos"));
                cl.setPrecioMembresia(rs.getDouble("PrecioMembresia"));
                cl.setMontoPagado(rs.getDouble("MontoPagado"));
                cl.setMontoRestante(rs.getDouble("MontoRestante"));

                String[] registros = {
                    String.valueOf(cl.getCodigo()),
                    cl.getNombres(),
                    cl.getApellidos(),
                    String.valueOf(cl.getPrecioMembresia()),
                    String.valueOf(cl.getMontoPagado()),
                    String.valueOf(cl.getMontoRestante()),};
                model.addRow(registros);

            }
            int n = mostrar.getRowCount();
            lblPagosPendientes.setText(String.valueOf(n));

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void BuscarClientesPagos(Cliente cl, JTable tblBuscar, JLabel lblPagosPendientes) {
        String sql = "{call BuscarClientesPagos (?)}";

        DefaultTableModel model = (DefaultTableModel) tblBuscar.getModel();
        model.setRowCount(0);
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, cl.getApellidos());
            rs = ps.executeQuery();
            // Eliminar todas las filas existentes en la tabla

            while (rs.next()) {
                cl.setCodigo(rs.getInt("Codigo"));
                cl.setNombres(rs.getString("Nombres"));
                cl.setApellidos(rs.getString("Apellidos"));
                cl.setPrecioMembresia(rs.getDouble("PrecioMembresia"));
                cl.setMontoPagado(rs.getDouble("MontoPagado"));
                cl.setMontoRestante(rs.getDouble("MontoRestante"));

                String[] registros = {
                    String.valueOf(cl.getCodigo()),
                    cl.getNombres(),
                    cl.getApellidos(),
                    String.valueOf(cl.getPrecioMembresia()),
                    String.valueOf(cl.getMontoPagado()),
                    String.valueOf(cl.getMontoRestante()),};

                model.addRow(registros);
            }
            int ca = tblBuscar.getRowCount();
            lblPagosPendientes.setText(String.valueOf(ca));

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }

    public void EditarDatosCliente(Cliente cl) {
        String sql = "{call sp_UpdateUser(?, ?, ?, ?, ?, ?, ?)}";

        try {
            con = cn.getConexion();

            // Iniciar la transacción
            con.setAutoCommit(false);

            ps = con.prepareStatement(sql);
            ps.setInt(1, cl.getDni());
            ps.setString(2, cl.getNombres());
            ps.setString(3, cl.getApellidos());
            ps.setDate(4, new java.sql.Date(cl.getFechaNacimiento().getTime()));
            ps.setInt(5, cl.getTelefono());
            ps.setBytes(6, cl.getFoto());
            ps.setInt(7, cl.getCodigo());

            // Ejecutar la consulta de actualización
            ps.executeUpdate();

            // Commit para confirmar la transacción
            con.commit();

            JOptionPane.showMessageDialog(null, "Se actualizó los datos del cliente correctamente");
        } catch (SQLException e) {
            // En caso de error, hacer rollback para deshacer la transacción
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                System.out.println("Error al hacer rollback: " + ex.getMessage());
            }
            System.out.println("Error al ejecutar la consulta SQL: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                // Restaurar el modo de autocommit a true
                if (con != null) {
                    con.setAutoCommit(true);
                }
                // Cerrar PreparedStatement y Connection
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            }
        }
    }

    public void PagarDeudas(jdlRealizarPago n, JTable tblBuscarPagos, JLabel lblPagosPendientes) {

        CallableStatement cs = null;

        try {
            con = cn.getConexion(); // Reemplaza 'tuConexion()' con tu lógica para obtener la conexión a la base de datos
            con.setAutoCommit(false); // Desactivar la confirmación automática

            // Llama al procedimiento almacenado
            cs = con.prepareCall("{call MoverAPagoAHistorial1(?, ?)}");
              String PagarNew = n.txtPagarNew.getText();
            System.out.println("Nuevo monto pagado:" +PagarNew);
          
            cs.setInt(1, Integer.parseInt(n.txtCodPagar.getText())); // Reemplaza 'clienteID' con el ID del cliente que deseas mover
            cs.setDouble(2, Double.parseDouble(n.txtPagarNew.getText())); // Nuevo MontoPagado

            cs.execute();

            con.commit(); // Confirmar la transacción
          
            System.out.println("Nuevo monto pagado:" +PagarNew);
            ListaPagosPendientes(tblBuscarPagos, lblPagosPendientes);

            JOptionPane.showMessageDialog(null, "Se realizo el pago correctamente");
            n.dispose();
            // Cierre de recursos (CallableStatement y Connection)  en bloques "finally" si es necesario
            if (cs != null) {
                cs.close();
            }
            if (con != null) {
                con.close();
            }

            // Resto de la lógica después de llamar al procedimiento almacenado
        } catch (SQLException ex) {
            System.out.println(ex);; // Manejo de excepciones si es necesario
            try {
                if (con != null) {
                    con.rollback(); // Revertir la transacción en caso de excepción
                }
            } catch (SQLException rollbackEx) {
                System.out.println(rollbackEx);
            }
            // Resto de la lógica de manejo de excepciones...
        }
    }

    public boolean clienteTieneDeuda(int clienteID) {
        boolean tieneDeuda = false;

        String sql = "{call ps_ObtenerClientesDeuda(?)}";
        conexion cn = new conexion();
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, clienteID);

            ResultSet resultSet = ps.executeQuery();

            // Si hay al menos una fila en el resultado, el cliente tiene deuda
            if (resultSet.next()) {
                int rowCount = resultSet.getInt(1);
                tieneDeuda = rowCount > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Manejo del error (puedes personalizar esto según tus necesidades)
        }

        return tieneDeuda;
    }

    public void obtenerProximoCodigo(JTextField txtCodigo) {
        int proximoCodigo = 0;

        String sql = "SELECT MAX(codigo) + 1 AS ProximoCodigo FROM Usuarios";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                proximoCodigo = rs.getInt("ProximoCodigo");
                txtCodigo.setText(String.valueOf(proximoCodigo));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void eliminarUsuarioYRelacionados(Cliente cl) {
        String sql = "{call EliminarUsuarioYRelacionados(?)}";
        Connection con = null;
        CallableStatement cs = null;

        try {
            con = cn.getConexion(); // Reemplaza 'cn.getConexion()' con tu lógica para obtener la conexión a la base de datos
            cs = con.prepareCall(sql);

            // Establecer el valor del parámetro de entrada
            cs.setInt(1, cl.getCodigo());

            // Ejecutar el procedimiento almacenado
            cs.execute();

            System.out.println("Usuario y registros relacionados eliminados correctamente.");
        } catch (SQLException ex) {
            System.out.println("Error al eliminar usuario y registros relacionados: " + ex.getMessage());
            // Manejar la excepción según tus necesidades
        } finally {
            // Cerrar recursos en el bloque finally
            try {
                if (cs != null) {
                    cs.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                // Manejar excepciones al cerrar los recursos si es necesario
                ex.printStackTrace();
            }
        }
    }

    public void mostrarFotoCliente(JLabel imagen, int codigo) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conexion con = new conexion();
            cn = con.getConexion();
            String sql = "SELECT Foto FROM Usuarios WHERE codigo = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, codigo);
            rs = ps.executeQuery();

            if (rs.next()) {
                byte[] fotoBytes = rs.getBytes("Foto");

                if (fotoBytes != null && fotoBytes.length > 0) {
                    // Si hay datos en el campo de la foto, mostrar la imagen del cliente
                    ImageIcon imageIcon = new ImageIcon(fotoBytes);
                    Image image = imageIcon.getImage().getScaledInstance(imagen.getWidth(), imagen.getHeight(), Image.SCALE_SMOOTH);

                    imagen.setIcon(new ImageIcon(image));
                    imagen.setText(""); // Limpia el texto del JLabel
                } else {
                    // Si el campo de la foto está vacío, dejar el JLabel vacío
                    imagen.setIcon(null); // Limpia la imagen del JLabel
                    imagen.setText(""); // Limpia el texto del JLabel
                }

                System.out.println("Foto del cliente mostrada en el JLabel.");
            } else {
                imagen.setText("Cliente no encontrado.");
                imagen.setIcon(null); // Limpia la imagen del JLabel
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
