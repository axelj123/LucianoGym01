package model;

import conexionBD.conexion;
import java.awt.Image;
import java.sql.*;
import javax.swing.ImageIcon;
import javax.swing.JComboBox;
import javax.swing.JLabel;

import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

public class ProductosDao {

    conexion cn = new conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Productos pr = new Productos();

    public void RegistrarProductoUnit(ProductoUnitario pr) {

        String sql = "{call spInsertarProductoUnitYStockUnit(?, ?, ?, ?, ?, ?, ?)}";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);

            ps.setInt(1, pr.getProductoID());
            ps.setString(2, pr.getNombre());
            ps.setString(3, pr.getDescripcion());
            ps.setDouble(4, pr.getPrecio());
            ps.setInt(5, Integer.parseInt(pr.getCategoriaID()));
            ps.setBytes(6, pr.getFotoProducto());
            ps.setInt(7, pr.getStock());
            ps.execute();
            JOptionPane.showMessageDialog(null, "El Producto se ha registrado correctamente");

        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void RegistrarProductoPor(ProductoPorcion pr) {
        String sql = "{call spInsertarProductoPoryStockPor(?, ?, ?, ?, ?, ?, ?, ?)}";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);

            ps.setInt(1, pr.getProductoID());
            ps.setString(2, pr.getNombre());
            ps.setString(3, pr.getDescripcion());
            ps.setDouble(4, pr.getPrecio());
            ps.setInt(5, Integer.parseInt(pr.getCategoriaID()));
            ps.setBytes(6, pr.getFotoProducto());
            ps.setInt(7, pr.getStock());
            ps.setInt(8, pr.getStockPor());
            ps.execute();
            JOptionPane.showMessageDialog(null, "El Producto se ha registrado correctamente");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void buscarProductosPorNombre(ProductoUnitario pr, JTable tblResultados, JLabel lblTotal) {
        String sql = "{call BuscarProductosPorNombreUnit(?)}";

        try {
            con = cn.getConexion();
            ps = con.prepareCall(sql);
            ps.setString(1, pr.getNombre());
            rs = ps.executeQuery();

            // Eliminar todas las filas existentes en la tabla
            DefaultTableModel model = (DefaultTableModel) tblResultados.getModel();
            model.setRowCount(0);

            int contador = 0; // Contador para almacenar la cantidad de productos encontrados

            while (rs.next()) {
                int id = rs.getInt("ID");
                String nombre = rs.getString("Nombre");
                String descripcion = rs.getString("Descripcion");
                int categoriaID = rs.getInt("CategoriaID");
                double precio = rs.getDouble("Precio");
                int cantidadEnStock = rs.getInt("CantidadEnStock");

                // Agrega los datos como una nueva fila en la tabla
                model.addRow(new Object[]{id, nombre, descripcion, categoriaID, precio, cantidadEnStock});

                contador++; // Incrementa el contador de productos encontrados
            }

            // Muestra la cantidad de productos encontrados en el JLabel
            lblTotal.setText(String.valueOf(contador));

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }
    public void buscarProductosPorNombrePorcion(ProductoPorcion pr, JTable tblResultados, JLabel lblTotal) {
        String sql = "{call BuscarProductosPorNombre(?)}";

        try {
            con = cn.getConexion();
            ps = con.prepareCall(sql);
            ps.setString(1, pr.getNombre());
            rs = ps.executeQuery();

            // Eliminar todas las filas existentes en la tabla
            DefaultTableModel model = (DefaultTableModel) tblResultados.getModel();
            model.setRowCount(0);

            int contador = 0; // Contador para almacenar la cantidad de productos encontrados

            while (rs.next()) {
                int id = rs.getInt("ID");
                String nombre = rs.getString("Nombre");
                String descripcion = rs.getString("Descripcion");
                int categoriaID = rs.getInt("CategoriaID");
                double precio = rs.getDouble("Precio");
                int cantidadEnStock = rs.getInt("CantidadEnStock");
                int scoopsTotal=rs.getInt("ScoopsPorPote");

                // Agrega los datos como una nueva fila en la tabla
                model.addRow(new Object[]{id, nombre, descripcion, categoriaID, precio, cantidadEnStock,scoopsTotal});

                contador++; // Incrementa el contador de productos encontrados
            }

            // Muestra la cantidad de productos encontrados en el JLabel
            lblTotal.setText(String.valueOf(contador));

        } catch (SQLException ex) {
            System.out.print(ex);
        }
    }

    public int obtenerIdCategoriaPorNombre(String nombreCategoria) {
        int idCategoria = 0; // Valor por defecto o error

        // Realiza una consulta a la base de datos para obtener el ID de la categoría
        String sql = "SELECT ID FROM Categorias WHERE Nombre = ?";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, nombreCategoria);
            rs = ps.executeQuery();
            if (rs.next()) {
                idCategoria = rs.getInt("ID");

            }
        } catch (Exception e) {

        }

        return idCategoria;
    }

    public void obtenerProximoCodigo(JTextField txtCodProduct) {
        int proximoCodigo = 0;
     
     
        String sql = "SELECT MAX(ID) + 1 AS ProximoCodigo FROM Productos";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                proximoCodigo = rs.getInt("ProximoCodigo");
                txtCodProduct.setText(String.valueOf(proximoCodigo));

            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void llenarComboBoxCategorias(JComboBox<String> comboBox) {
        String sql = "SELECT Nombre FROM Categorias";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            comboBox.removeAllItems();

            while (rs.next()) {
                String nombreCategoria = rs.getString("Nombre");

                // Agrega el nombre de la categoría al ComboBox
                comboBox.addItem(nombreCategoria);

                // Verifica si esta categoría es la seleccionada por defecto (puedes ajustar esta lógica)
                
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void listarProductosUnitaros(JTable tabla, JLabel total) {
        String sql = "SELECT * FROM VistaProductosConStock";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            // Crear un CustomTableModel que incluye una columna para la imagen
            DefaultTableModel model = (DefaultTableModel) tabla.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                // Obtener los datos de la fila
                int productoID = rs.getInt("ProductoID");
                String nombreProducto = rs.getString("NombreProducto");
                String descripcionProducto = rs.getString("DescripcionProducto");
                String nombreCategoria = rs.getString("NombreCategoria");
                double precioProducto = rs.getDouble("PrecioProducto");
                int stockUnidad = rs.getInt("StockUnidad");

                ProductoUnitario pr = new ProductoUnitario();
                pr.setProductoID(productoID);
                pr.setNombre(nombreProducto);
                pr.setDescripcion(descripcionProducto);
                pr.setCategoriaID(nombreCategoria);
                pr.setPrecio(precioProducto);
                pr.setStock(stockUnidad);

                model.addRow(new Object[]{productoID, nombreProducto, descripcionProducto, nombreCategoria, precioProducto, stockUnidad});
                int n = tabla.getRowCount();
                total.setText(String.valueOf(n));

            }

        } catch (SQLException e) {
            // Manejar las excepciones aquí
            System.out.println(e);;
        }
    }

    public void listarProductosPorcion(JTable tabla, JLabel total) {
        String sql = "SELECT * FROM VistaProductosConStockPorPorcion";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            DefaultTableModel model = (DefaultTableModel) tabla.getModel();
            model.setRowCount(0);

            while (rs.next()) {
                // Obtener los datos de la fila
                int productoID = rs.getInt("ProductoID");
                String nombreProducto = rs.getString("NombreProducto");
                String descripcionProducto = rs.getString("DescripcionProducto");
                String nombreCategoria = rs.getString("NombreCategoria");
                double precioProducto = rs.getDouble("PrecioProducto");
                int stock = rs.getInt("Stock");
                int ScoopsPorPote = rs.getInt("ScoopsPorPote");

                ProductoPorcion prp = new ProductoPorcion();
                prp.setProductoID(productoID);
                prp.setNombre(nombreProducto);
                prp.setDescripcion(descripcionProducto);
                prp.setCategoriaID(nombreCategoria);
                prp.setPrecio(precioProducto);
                prp.setStock(stock);
                prp.setStockPor(ScoopsPorPote);

                model.addRow(new Object[]{productoID, nombreProducto, descripcionProducto, nombreCategoria, precioProducto, stock, ScoopsPorPote});
                int n = tabla.getRowCount();
                total.setText(String.valueOf(n));

            }


        } catch (Exception e) {
            // Manejar las excepciones aquí
            e.printStackTrace();
        }
    }

    public void actualizarProductUnit(ProductoUnitario pr) {
        String sql = "{call ActualizarProducto(?, ?, ?, ?)}";
        Connection con = null;
        PreparedStatement cs = null;

        try {
            con = cn.getConexion();
            con.setAutoCommit(false); // Deshabilitar el modo de auto confirmación
            cs = con.prepareStatement(sql);
            cs.setDouble(1, pr.getPrecio());
            cs.setInt(2, pr.getStock());
            cs.setBytes(3, pr.getFotoProducto());

            cs.setInt(4, pr.getProductoID());
            cs.executeUpdate();

            // Confirmar los cambios
            con.commit();

            JOptionPane.showMessageDialog(null, "Los cambios se guardaron correctamente");

        } catch (SQLException e) {
            // Manejar la excepción
            try {
                if (con != null) {
                    // Deshacer los cambios en caso de error
                    con.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Cerrar recursos en un bloque finally
            try {
                if (cs != null) {
                    cs.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
        }
    }

    public void actualizarStockYProductoPor(ProductoPorcion prp) {
        String sql = "{call ActualizarStockYProductoPor (?, ?, ?, ?, ?)}";
        Connection con = null;
        CallableStatement cs = null;

        try {
            con = cn.getConexion();
            con.setAutoCommit(false); // Deshabilitar el modo de auto confirmación
            cs = con.prepareCall(sql);
            cs.setInt(1, prp.getStock());
            cs.setInt(2, prp.getStockPor());
            cs.setDouble(3, prp.getPrecio());
            cs.setBytes(4, prp.getFotoProducto());
            cs.setInt(5, prp.getProductoID());
            cs.executeUpdate();

            // Confirmar los cambios
            con.commit();

            JOptionPane.showMessageDialog(null, "Los cambios se guardaron correctamente");

        } catch (SQLException e) {
            // Manejar la excepción
            try {
                if (con != null) {
                    // Deshacer los cambios en caso de error
                    con.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Cerrar recursos en un bloque finally
            try {
                if (cs != null) {
                    cs.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
        }
    }

    public void EliminarProductoUnitario(JTable tblListaProductosUnit, ProductoUnitario pr) {

        String sqlDeleteStockPorUnidad =  "{call EliminarProductoUnit (?)}";

        conexion cn = new conexion();
        Connection con;
        PreparedStatement psDeleteStockPorUnidad;

        try {
            con = cn.getConexion();
            con.setAutoCommit(false); // Desactivar la confirmación automática

            psDeleteStockPorUnidad = con.prepareStatement(sqlDeleteStockPorUnidad);
            psDeleteStockPorUnidad.setInt(1, pr.getProductoID());
            psDeleteStockPorUnidad.executeUpdate();


            con.commit(); // Confirmar la transacción (borrado exitoso)
            JOptionPane.showMessageDialog(null, "El Producto se ha eliminado correctamente");

        } catch (SQLException e) {

            JOptionPane.showMessageDialog(null, "No se puede eliminar el producto.. ERROR:" + e, "ERROR", JOptionPane.WARNING_MESSAGE);

        }
    }

    public void EliminarProductoPorcion(JTable tblListaProductosPor, ProductoPorcion pr) {
        String sqlDeleteStockPorUnidad =  "{call EliminarProductoPor (?)}";

        conexion cn = new conexion();
        Connection con;
        PreparedStatement psDeleteStockPorPor;

        try {
            con = cn.getConexion();
            con.setAutoCommit(false); // Desactivar la confirmación automática

            psDeleteStockPorPor = con.prepareStatement(sqlDeleteStockPorUnidad);
            psDeleteStockPorPor.setInt(1, pr.getProductoID());
            psDeleteStockPorPor.executeUpdate();


            con.commit(); // Confirmar la transacción (borrado exitoso)
            JOptionPane.showMessageDialog(null, "El Producto se ha eliminado correctamente");

        } catch (SQLException e) {

            JOptionPane.showMessageDialog(null, "No se puede eliminar el producto.. ERROR:" + e, "ERROR", JOptionPane.WARNING_MESSAGE);

        }
    }
    public void mostrarFotoProducto(JLabel lblImage, int codProd) {
    try {

        String sql = "SELECT ImagenProducto FROM Productos WHERE ID = ?";
        con = cn.getConexion();
        ps = con.prepareStatement(sql);
        ps.setInt(1, codProd);
        rs = ps.executeQuery();

        if (rs.next()) {
            byte[] fotoBytes = rs.getBytes("ImagenProducto");

            // Verificar si la imagen es null y asignar una imagen de marcador de posición
            if (fotoBytes != null) {
                ImageIcon imageIcon = new ImageIcon(fotoBytes);
                Image image = imageIcon.getImage().getScaledInstance(lblImage.getWidth(), lblImage.getHeight(), Image.SCALE_SMOOTH);
                lblImage.setIcon(new ImageIcon(image));
                lblImage.setText(""); // Limpia el texto del JLabel
            } else {
                // Asignar una imagen de marcador de posición o dejar el JLabel vacío
                lblImage.setIcon(new ImageIcon("/icons/default.png"));
            }

            System.out.println("Foto del producto mostrada en el JLabel.");
        } else {
            lblImage.setText("Producto no encontrado.");
            lblImage.setIcon(null); // Limpia la imagen del JLabel
        }

        // Cierra los recursos
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
}

}
