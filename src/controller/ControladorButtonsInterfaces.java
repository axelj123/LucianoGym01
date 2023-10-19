/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import conexionBD.conexion;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import model.Cliente;
import model.ClienteDAO;
import model.Productos;
import model.ProductosDao;
import view.JdlTipoAlmacen;
import view.jdlTipoProducto;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorButtonsInterfaces implements ActionListener, MouseListener {

    newprincipal np;
    ControladorRegistro cr;
    ClienteDAO cldAO = new ClienteDAO();
    ProductosDao prdao = new ProductosDao();
    Productos pr = new Productos();
    Cliente cl = new Cliente();
    ControladorBuscarSocio controladorBuscarSocio;

    public ControladorButtonsInterfaces(newprincipal np) {
        this.np = np;
        this.np.btnRegistrarSocio.addActionListener(this);
        this.np.btnBuscarSocio.addActionListener(this);
        this.np.btnVenderProducto.addActionListener(this);
        this.np.btnAlmacen.addActionListener(this);
        this.np.btnInterfazRegistrarProducto.addActionListener(this);
        this.np.btnVerHistorialMembre.addActionListener(this);
        this.np.btnVerPagosPendiente.addActionListener(this);
        this.np.tblBuscarClientes.addMouseListener(this);
        controladorBuscarSocio = new ControladorBuscarSocio(np);
        cr = new ControladorRegistro(np);
        cr.bloquear();
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        JButton sourceButton = (JButton) e.getSource();
        if (sourceButton == np.btnRegistrarSocio) {
            // Opción "Registrar Cliente" seleccionada
            np.jTabbedPane1.setSelectedIndex(1);
            Calendar calendario = Calendar.getInstance();
            Date fechaActual = calendario.getTime();
            np.jdateFin.setMinSelectableDate(new Date());
            // Establece la fecha actual en el JDateChooser
            np.jdateInicio.setDate(fechaActual);
            obtenerProximoCodigo();
            np.txtPrecioMembresia.addKeyListener(new KeyAdapter() {
                @Override
                public void keyReleased(KeyEvent e) {
                    actualizarMontoRestante();
                }
            });
            np.txtSaldo.addKeyListener(new KeyAdapter() {
                @Override
                public void keyReleased(KeyEvent e) {
                    actualizarMontoRestante();
                }
            });

            configurarValidacionTexto(np.txtPrecioMembresia, 200, true);
            configurarValidacionTexto(np.txtSaldo, 200, true);
            configurarValidacionTexto(np.txtTelefono, 9, true);
            configurarValidacionTexto(np.txtDni, 8, true);
            configurarLongitudMinima(np.txtTelefono, 9, "Debe ingresar 9 dígitos para el Teléfono.");
            configurarLongitudMinima(np.txtDni, 8, "Debe ingresar 8 dígitos para el DNI.");
            configurarValidacionTexto(np.txtNombres, 200, false);
            configurarValidacionTexto(np.txtApellidos, 200, false);
        }
        if (sourceButton == np.btnBuscarSocio) {

            cldAO.ListarClientesBuscarNew(np.tblBuscarClientes, np.lblTotal);

            np.jTabbedPane1.setSelectedIndex(2);
            TableActionEvent event = new TableActionEvent() {

                @Override

                public void onEdit(int row) {

                    cl.setCodigo(Integer.parseInt(np.tblBuscarClientes.getValueAt(row, 0).toString()));
                    cl.setDni(Integer.parseInt(np.tblBuscarClientes.getValueAt(row, 1).toString()));
                    cl.setNombres(np.tblBuscarClientes.getValueAt(row, 2).toString());
                    cl.setApellidos(np.tblBuscarClientes.getValueAt(row, 3).toString());
                    cl.setTelefono(Integer.parseInt(np.tblBuscarClientes.getValueAt(row, 4).toString()));
                    java.sql.Date fechaNacimiento = java.sql.Date.valueOf(np.tblBuscarClientes.getValueAt(row, 5).toString());

                    cl.setFechaNacimiento(fechaNacimiento);

                    np.jTabbedPane1.setSelectedIndex(4);
                    np.txtCodEdit.setText(String.valueOf(cl.getCodigo()));
                    np.txtDniEdit.setText(String.valueOf(cl.getDni()));
                    np.txtNombreEdit.setText(cl.getNombres());
                    np.txtApellidoEdit.setText(cl.getApellidos());
                    np.txtTelefonoEdit.setText(String.valueOf(cl.getTelefono()));
                    np.jdteFNedit.setDate(cl.getFechaNacimiento());

                    np.txtCodEdit.setEnabled(false);
                    np.txtApellidoEdit.setEditable(false);
                    np.txtNombreEdit.setEditable(false);
                    np.txtDniEdit.setEditable(false);
                    np.txtTelefonoEdit.setEditable(false);
                    np.jdteFNedit.setEnabled(false);
                    //VALIDACIONES DEL DNI

                    mostrarFotoCliente(np.lblFotoEditarCliente, cl.getCodigo());
//                    mostrarFotoCliente();
                    System.out.println("HOLA ME REPITO");

                    configurarValidacionTexto(np.txtTelefonoEdit, 9, true);
                    configurarValidacionTexto(np.txtDniEdit, 8, true);
                    configurarLongitudMinima(np.txtTelefonoEdit, 9, "Debe ingresar 9 dígitos para el Teléfono.");
                    configurarLongitudMinima(np.txtDniEdit, 8, "Debe ingresar 8 dígitos para el DNI.");
                    configurarValidacionTexto(np.txtNombreEdit, 200, false);
                    configurarValidacionTexto(np.txtApellidoEdit, 200, false);

                }

                @Override
                public void onDelete(int row) {
                    if (np.tblBuscarClientes.isEditing()) {
                        np.tblBuscarClientes.getCellEditor().stopCellEditing();
                        int confirmationResult = JOptionPane.showConfirmDialog(null,
                                "¿Está seguro de eliminar al cliente?", "Eliminar Cliente",
                                JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);

                        if (confirmationResult == JOptionPane.YES_OPTION) {

                          cl.setCodigo(Integer.parseInt(np.tblBuscarClientes.getValueAt(row, 0).toString()));
                          
                            System.out.println("CLIENTE ID : " + cl.getCodigo());

                            cldAO.eliminarUsuarioYRelacionados(cl);
                            cldAO.ListarClientesBuscarNew(np.tblBuscarClientes, np.lblTotal);

                        }
                    }
                }

            };
            np.tblBuscarClientes.getColumnModel().getColumn(6).setCellRenderer(new TableActionCellRender());
            np.tblBuscarClientes.getColumnModel().getColumn(6).setCellEditor(new TableActionCellEditor(event));
            np.tblBuscarClientes.fixTable(np.jScrollPane11);
        }
        if (sourceButton == np.btnVenderProducto) {
          
        }

        if (sourceButton == np.btnInterfazRegistrarProducto) {
            jdlTipoProducto tipo = new jdlTipoProducto(np, true);
            tipo.setVisible(true);
//            ControladorRegisTipoProducto re=new ControladorRegisTipoProducto(np, tipo);
        }
    }

    public void obtenerProximoCodigo() {
        int proximoCodigo = 0;
        conexion cn = new conexion();
        Connection con;
        PreparedStatement ps;
        ResultSet rs;

        String sql = "SELECT IDENT_CURRENT('Usuarios') + 1 AS ProximoCodigo";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                proximoCodigo = rs.getInt("ProximoCodigo");
                np.txtCodigo.setText(String.valueOf(proximoCodigo));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void ConfigurarTabla(JTable tabla) {
        tabla.getTableHeader().setFont(new Font("Segoe UI", Font.BOLD, 14));
        tabla.getTableHeader().setOpaque(false);
        tabla.getTableHeader().setBackground(new Color(0, 0, 47));
        tabla.getTableHeader().setForeground(new Color(255, 255, 255));
        tabla.setRowHeight(25);
        tabla.setShowVerticalLines(false);
        tabla.setShowHorizontalLines(true);
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

    public void mostrarFotoProducto(JLabel lblImage) {
        try {
            conexion con = new conexion();
            Connection cn;
            PreparedStatement ps;
            String sql = "SELECT ImagenProducto FROM Productos WHERE ID = ?";
            cn = con.getConexion();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, pr.getId());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                byte[] fotoBytes = rs.getBytes("ImagenProducto");

                // Crear una imagen a partir de los datos binarios
                ImageIcon imageIcon = new ImageIcon(fotoBytes);
                Image image = imageIcon.getImage().getScaledInstance(lblImage.getWidth(), lblImage.getHeight(), Image.SCALE_SMOOTH);

                lblImage.setIcon(new ImageIcon(image));
                lblImage.setText(""); // Limpia el texto del JLabel

                System.out.println("Foto del producto mostrada en el JLabel.");
            } else {
                lblImage.setText("Cliente no encontrado.");
                lblImage.setIcon(null); // Limpia la imagen del JLabel
            }

            rs.close();
            ps.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void configurarValidacionTexto(JTextField textField, int maxLength, boolean soloDigitos) {
        textField.addKeyListener(new KeyAdapter() {
            @Override
            public void keyTyped(KeyEvent e) {
                char c = e.getKeyChar();
                if ((soloDigitos && !Character.isDigit(c)) || (!soloDigitos && Character.isDigit(c)) || textField.getText().length() >= maxLength) {
                    e.consume();
                }
            }
        });
    }

// Método auxiliar para configurar la validación de longitud mínima de texto
    private void configurarLongitudMinima(JTextField textField, int minLength, String mensaje) {
        textField.addFocusListener(new FocusAdapter() {
            @Override
            public void focusLost(FocusEvent e) {
                if (textField.getText().length() < minLength) {
                    JOptionPane.showMessageDialog(null, mensaje, "Longitud Incorrecta", JOptionPane.WARNING_MESSAGE);
                    textField.requestFocus();
                }
            }
        });
    }

    public void actualizarMontoRestante() {
        try {
            double precioMembresia = Double.parseDouble(np.txtPrecioMembresia.getText());
            double saldo = Double.parseDouble(np.txtSaldo.getText());
            double montoRestante = precioMembresia - saldo;
            np.txtResta.setText(String.valueOf(montoRestante));
        } catch (NumberFormatException ex) {
            // Manejar errores de conversión numérica aquí
            np.txtResta.setText(""); // Limpiar el campo si hay un error
        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        JTable sourcetable = (JTable) e.getSource();

        if (sourcetable == np.tblBuscarClientes) {
            if (e.getButton() == MouseEvent.BUTTON1 && e.getClickCount() == 1) {
                np.cod1.setText("");
                int fila = np.tblBuscarClientes.rowAtPoint(e.getPoint());
                int columna = np.tblBuscarClientes.columnAtPoint(e.getPoint());
                if ((fila > -1) && (columna > -1)) {
                    cl.setCodigo(Integer.parseInt(np.tblBuscarClientes.getValueAt(fila, 0).toString()));
                    cl.setNombres(np.tblBuscarClientes.getValueAt(fila, 2).toString());
                    cl.setApellidos((np.tblBuscarClientes.getValueAt(fila, 3).toString()));

                    np.cod1.setText(String.valueOf(cl.getCodigo()));
                    np.name1.setText(cl.getNombres());
                    np.apelli1.setText(String.valueOf(cl.getApellidos()));
                    mostrarFotoCliente(np.imagen1, cl.getCodigo());

                }

            }
        }

    }

    @Override
    public void mousePressed(MouseEvent e) {

    }

    @Override
    public void mouseReleased(MouseEvent e) {

    }

    @Override
    public void mouseEntered(MouseEvent e) {

    }

    @Override
    public void mouseExited(MouseEvent e) {

    }
}
