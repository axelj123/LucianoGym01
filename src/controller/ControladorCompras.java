/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import model.DetalleVenta;
import model.ProductosDao;
import model.VentasDAO;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorCompras implements ActionListener {
    
    newprincipal np;
    ProductosDao prdao=new ProductosDao();
    public ControladorCompras(newprincipal np){
        this.np=np;
        
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        JButton sourceboton= (JButton) e.getSource();
        if (sourceboton==np.btnVender) {
                    if (!np.txtCodVentaPro.getText().isEmpty() && !np.txtNombreVentaPro.getText().isEmpty()
                && !np.txtCantidadVentaPro.getText().isEmpty() && !np.txtPrecioProVen.getText().isEmpty() && !np.txtTotalVenta.getText().isEmpty()) {

            DetalleVenta dt = new DetalleVenta();

            dt.setPrecioUnitario(Double.parseDouble(np.txtTotalVenta.getText()));
            dt.setProductoId(Integer.parseInt(np.txtCodVentaPro.getText()));
            dt.setCantidadVenta(Integer.parseInt(np.txtCantidadVentaPro.getText()));
            dt.setPrecioUnitario(Double.parseDouble(np.txtPrecioProVen.getText()));
            dt.setSubTotal(Double.parseDouble(np.txtTotalVenta.getText()));

            VentasDAO vdao = new VentasDAO();

            vdao.GeneraVenta(dt);
            np.ssss.setVisible(false);
            prdao.listarProductosPorcion(np.tblComprasPor, np.ssss);
            prdao.listarProductosUnitaros(np.tblComprasUnit, np.ssss);

        } else {
            JOptionPane.showMessageDialog(null, "faltan campos", "Venta", JOptionPane.WARNING_MESSAGE);
        }
        }
            }
    
    
    
}
