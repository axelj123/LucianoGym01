package controller;

import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.SwingUtilities;
import view.jdlRegistrarProductoUnitario;
import view.jdlTipoProducto;
import view.newprincipal;

public class ControladorRegisTipoProducto implements ActionListener {

    private newprincipal np;
    private jdlTipoProducto ti;

    public ControladorRegisTipoProducto(newprincipal np, jdlTipoProducto ti) {
        this.np = np;
        this.ti = ti;

        ti.btnUnidad.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourceButton = (JButton) e.getSource();

        if (sourceButton == ti.btnUnidad) {


            // Crea una instancia de jdlRegistrarProducto con el Frame como padre
            jdlRegistrarProductoUnitario regisProduct = new jdlRegistrarProductoUnitario(np, true);
         
            ControladorRegistrarProductoUnit cr = new ControladorRegistrarProductoUnit(np, regisProduct);
 // Muestra el segundo JDialog
            regisProduct.setVisible(true);
           

            ti.dispose();

        }
    }
}
