/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;


import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import java.util.Calendar;
import java.util.Date;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;


import model.Cliente;
import model.ClienteDAO;
import model.Productos;
import model.ProductosDao;
import view.JdlTipoAlmacen;
import view.JdlTipoVenta;
import view.jdlRealizarPago;
import view.jdlTipoProducto;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorButtonsInterfaces implements ActionListener, MouseListener, KeyListener {

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
            np.jdateInicio.setDate(fechaActual);
            cldAO.obtenerProximoCodigo(np.txtCodigo);
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

            configurarValidacionTexto(np.txtTelefono, 9, true);
            configurarValidacionTexto(np.txtDni, 8, true);
            configurarLongitudMinima(np.txtTelefono, 9, "Debe ingresar 9 dígitos para el Teléfono.");
            configurarLongitudMinima(np.txtDni, 8, "Debe ingresar 8 dígitos para el DNI.");
            configurarValidacionTexto(np.txtNombres, 200, false);
            configurarValidacionTexto(np.txtApellidos, 200, false);
        }
        if (sourceButton == np.btnBuscarSocio) {

            cldAO.ListarClientesBuscarNew(np.tblBuscarClientes, np.lblTotal);
            this.np.tblBuscarClientes.addMouseListener(this);
            this.np.txtBuscarText.addKeyListener(this);
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

                    cldAO.mostrarFotoCliente(np.lblFotoEditarCliente, cl.getCodigo());

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

            JdlTipoVenta tp = new JdlTipoVenta(np, true);
            tp.setVisible(true);
        }
        if (sourceButton == np.btnAlmacen) {

            JdlTipoAlmacen jd = new JdlTipoAlmacen(np, true);
            jd.setVisible(true);

        }
        if (sourceButton == np.btnInterfazRegistrarProducto) {
            jdlTipoProducto tipo = new jdlTipoProducto(np, true);
            tipo.setVisible(true);
        }
        if (sourceButton == np.btnVerHistorialMembre) {
            np.tblHistorial.fixTable(np.jScrollPane2);
            np.tbHistoriaCliente.fixTable(np.jScrollPane1);

            cldAO.ListarHistorialMembresias(np.tblHistorial);
            ControladorHistorialCliente cp = new ControladorHistorialCliente(np);
            np.jTabbedPane1.setSelectedIndex(7);

        }
      

        if (sourceButton == np.btnVerPagosPendiente) {
            np.jTabbedPane1.setSelectedIndex(6);
//            ConfigurarTabla(np.tblBuscarPagos1);
            cldAO.ListaPagosPendientes(np.tblBuscarPagos2, np.lblPagosPendientes);
            this.np.txtBuscarPagosPen.addKeyListener(this);

            TableActionEventPagos event4 = new TableActionEventPagos() {

                @Override

                public void onEdit(int row) {
                    if (np.tblBuscarPagos2.isEditing()) {
                        np.tblBuscarPagos2.getCellEditor().stopCellEditing();
                        cl.setCodigo(Integer.parseInt(np.tblBuscarPagos2.getValueAt(row, 0).toString()));
                        cl.setNombres(np.tblBuscarPagos2.getValueAt(row, 1).toString());
                        cl.setApellidos(np.tblBuscarPagos2.getValueAt(row, 2).toString());
                        cl.setPrecioMembresia(Double.parseDouble(np.tblBuscarPagos2.getValueAt(row, 3).toString()));
                        cl.setMontoPagado(Double.parseDouble(np.tblBuscarPagos2.getValueAt(row, 4).toString()));
                        cl.setMontoRestante(Double.parseDouble(np.tblBuscarPagos2.getValueAt(row, 5).toString()));

                        np.txtCodEdit.setText(String.valueOf(cl.getCodigo()));

                        jdlRealizarPago jdE = new jdlRealizarPago(np, true, cl);

                        jdE.txtCodPagar.setText(String.valueOf(cl.getCodigo()));
                        System.out.println(String.valueOf(cl.getCodigo()));

                        jdE.txtCodPagar.setEditable(false);
                        jdE.txtFaltaPagar.setEditable(false);
                        jdE.txtSaldoNew.setEditable(false);

                        jdE.txtMembrePago.setText(String.valueOf(cl.getPrecioMembresia()));
                        jdE.txtFaltaPagar.setText(String.valueOf(cl.getMontoRestante()));
                        jdE.txtSaldoNew.setText(String.valueOf(cl.getMontoPagado()));
                        jdE.txtPagarNew.requestFocus();

                        double restante = cl.getMontoRestante(); // Obtener el valor de cl.getMontoRestante()
                        jdE.settRestanteNow(restante); // Llamar al método setRestanteNow() en jdlRealizarPago para asignar el valor

                        double pagadoActual = cl.getMontoPagado();
                        jdE.setgetPagadoActual(pagadoActual);
                        jdE.txtMembrePago.setEditable(false);
                        jdE.txtPagarNew.addKeyListener(new KeyAdapter() {
                            @Override
                            public void keyReleased(KeyEvent e) {
                                try {
                                    String texto = jdE.txtPagarNew.getText();

                                    if (!texto.isEmpty()) {
                                        double montoPagar = Double.parseDouble(texto);

                                        if (montoPagar <= jdE.getRestanteNow()) {
                                            double nuevoMontoPagado = pagadoActual + montoPagar;
                                            double nuevoMontoRestante = jdE.getRestanteNow() - montoPagar;

                                            jdE.txtFaltaPagar.setText(String.valueOf(nuevoMontoRestante));
                                            String faltaPagar = jdE.txtFaltaPagar.getText();
                                            System.out.println("FALTA PAGAR EN BUTTONS INTERFACE: " + faltaPagar);
                                            String nuevomontopago = jdE.txtPagarNew.getText();
                                            System.out.println("NuevoMonto EN BUTTONS INTERFACE: " + nuevomontopago);
                                            jdE.txtSaldoNew.setText(String.valueOf(nuevoMontoPagado));
                                        } else {
                                            // Aquí puedes mostrar un mensaje de error o tomar otra acción.
                                            // Por ejemplo, puedes mostrar un JOptionPane con un mensaje de error.
                                            JOptionPane.showMessageDialog(jdE, "El valor ingresado es mayor que el restante.", "Pagos", JOptionPane.ERROR_MESSAGE);
                                            // También puedes restaurar los valores originales si lo deseas.
                                            jdE.txtPagarNew.setText("");
                                            jdE.txtFaltaPagar.setText(String.valueOf(jdE.getRestanteNow()));
                                            jdE.txtSaldoNew.setText(String.valueOf(pagadoActual));
                                        }
                                    } else {
                                        // Cuando el campo está vacío, restaura los valores originales
                                        jdE.txtFaltaPagar.setText(String.valueOf(jdE.getRestanteNow()));
                                        jdE.txtSaldoNew.setText(String.valueOf(pagadoActual));
                                    }
                                } catch (NumberFormatException ex) {
                                    ex.printStackTrace(); // Manejo de excepciones si es necesario
                                    // Resto de la lógica de manejo de excepciones...
                                }
                            }
                        });
                        jdE.setVisible(true);

                    }
                }

            };
            np.tblBuscarPagos2.getColumnModel().getColumn(6).setCellRenderer(new TableActionCellRenderPagar());
            np.tblBuscarPagos2.getColumnModel().getColumn(6).setCellEditor(new TableActionCellEditorPagar(event4));
            np.tblBuscarPagos2.fixTable(np.jScrollPane7);

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
                    cldAO.mostrarFotoCliente(np.imagen1, cl.getCodigo());

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

    @Override
    public void keyTyped(KeyEvent e) {

    }

    @Override
    public void keyPressed(KeyEvent e) {

    }

    @Override
    public void keyReleased(KeyEvent e) {
        JTextField keyRelese = (JTextField) e.getSource();
        if (keyRelese == np.txtBuscarText) {
            String valorBusqueda = np.txtBuscarText.getText();
            cl.setApellidos(valorBusqueda);

            cldAO.buscarClientes(cl, np.tblBuscarClientes, np.lblTotal);
        }
        if (keyRelese == np.txtBuscarPagosPen) {
            String valorBusqueda = np.txtBuscarPagosPen.getText();
            cl.setApellidos(valorBusqueda);
            cldAO.BuscarClientesPagos(cl, np.tblBuscarPagos2, np.lblPagosPendientes);
        }
    }
}
