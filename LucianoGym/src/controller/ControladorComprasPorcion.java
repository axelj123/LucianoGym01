/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;


import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import model.DetalleVenta;
import model.ProductoPorcion;
import model.ProductosDao;
import model.VentasDAO;
import view.jdlVentaPorcion;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorComprasPorcion implements ActionListener, MouseListener, KeyListener {

    newprincipal np;
    ProductosDao prdao = new ProductosDao();
    VentasDAO vdao = new VentasDAO();
    DetalleVenta dt = new DetalleVenta();
    jdlVentaPorcion jd;
    ProductoPorcion pr = new ProductoPorcion();

    public ControladorComprasPorcion(newprincipal np, jdlVentaPorcion jd) {
        this.np = np;
        this.jd = jd;
        jd.addWindowListener(new WindowAdapter() {
            @Override
            public void windowOpened(WindowEvent e) {
                prdao.listarProductosPorcion(jd.tblProducs, jd.lblTotal);
            }
        });
        jd.btnVender.addActionListener(this);
        jd.tblProducs.addMouseListener(this);
        jd.txtCantidadVenta.addKeyListener(this);
        jd.txtBuscarPorcProduct.addKeyListener(this);

    }

    @Override
    public void actionPerformed(ActionEvent e) {

        JButton sourceboton = (JButton) e.getSource();
        if (sourceboton == jd.btnVender) {
            
            if (!jd.txtCodProductoVenta.getText().isEmpty() && !jd.txtNombreProducto.getText().isEmpty()
                    && !jd.txtCantidadVenta.getText().isEmpty() && !jd.txtPrecioVenta.getText().isEmpty() && !jd.txtTotalVenta.getText().isEmpty()) {

                dt.setProductoId(Integer.parseInt(jd.txtCodProductoVenta.getText()));
                dt.setCantidadVenta(Integer.parseInt(jd.txtCantidadVenta.getText()));
                dt.setPrecioUnitario(Double.parseDouble(jd.txtPrecioVenta.getText()));
                dt.setSubTotal(Double.parseDouble(jd.txtTotalVenta.getText()));

                vdao.GeneraVenta(dt);
                prdao.listarProductosPorcion(jd.tblProducs, jd.lblTotal);

                jd.txtCantidadVenta.requestFocus();
                jd.tblProducs.clearSelection();

                jd.txtCantidadVenta.setText("");
                jd.txtCodProductoVenta.setText("");
                jd.txtNombreProducto.setText("");
                jd.txtPrecioVenta.setText("");
                jd.txtTotalVenta.setText("");

            } else {
                JOptionPane.showMessageDialog(null, "faltan campos", "Venta", JOptionPane.WARNING_MESSAGE);
            }
        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        JTable tableclick = (JTable) e.getSource();
        if (tableclick == jd.tblProducs) {
            if (e.getButton() == MouseEvent.BUTTON1 && e.getClickCount() == 1) {
                            jd.txtCantidadVenta.requestFocus();

                jd.txtCodProductoVenta.setText("");
                jd.txtCantidadVenta.setText("");
                        jd.txtTotalVenta.setText("");
                int fila = jd.tblProducs.rowAtPoint(e.getPoint());
                int columna = jd.tblProducs.columnAtPoint(e.getPoint());
                if ((fila > -1) && (columna > -1)) {
                    pr.setProductoID(Integer.parseInt(jd.tblProducs.getValueAt(fila, 0).toString()));
                    pr.setNombre(jd.tblProducs.getValueAt(fila, 1).toString());
                    pr.setPrecio(Double.parseDouble(jd.tblProducs.getValueAt(fila, 4).toString()));

                    jd.txtCodProductoVenta.setText(String.valueOf(pr.getProductoID()));
                    jd.txtNombreProducto.setText(String.valueOf(pr.getNombre()));
                    jd.txtPrecioVenta.setText(String.valueOf(pr.getPrecio()));

                    prdao.mostrarFotoProducto(jd.lblImagenPor, pr.getProductoID());

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
        JTextField text = (JTextField) e.getSource();
        if (text == jd.txtCantidadVenta) {
               
            try {
                 
                int cantidad = Integer.parseInt(jd.txtCantidadVenta.getText());
                double precio = Double.parseDouble(jd.txtPrecioVenta.getText());

                // Obtiene la fila seleccionada del modelo de la tabla
                int fila = jd.tblProducs.getSelectedRow();

                if (fila >= 0) {
                    // Obtiene el valor de la columna 6 (considerando que las columnas se indexan desde 0)
                    int stock = Integer.parseInt(jd.tblProducs.getValueAt(fila, 6).toString());

                    if (cantidad > stock) {
                        JOptionPane.showMessageDialog(null, "La cantidad Excede al stock del producto", "VENTA", JOptionPane.WARNING_MESSAGE);
                        jd.txtCantidadVenta.setText("");
                        jd.txtTotalVenta.setText("");
                    } else {
                        double total = cantidad * precio;
                        jd.txtTotalVenta.setText(String.valueOf(total));

                    }
                } else {
                    // Manejar el caso en el que no se selecciona ninguna fila de la tabla
                    // Puedes mostrar un mensaje de error, realizar alguna otra acción o simplemente salir del método.
                }
            } catch (NumberFormatException ex) {
                jd.txtTotalVenta.setText("");
            }
        }
        if (text == jd.txtBuscarPorcProduct) {
            String valor = jd.txtBuscarPorcProduct.getText();
            pr.setNombre(valor);
            prdao.buscarProductosPorNombrePorcion(pr, jd.tblProducs, jd.lblTotal);
        }
    }

}
