/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import model.ClienteDAO;
import view.jdlRealizarPago;
import view.newprincipal;

/**
 *
 * @author User
 */
public class controladorPagos implements ActionListener {

    private newprincipal np;
    jdlRealizarPago jd;
    ClienteDAO cldAO = new ClienteDAO();

    public controladorPagos(newprincipal np, jdlRealizarPago jd) {
        this.np = np;
        this.jd = jd;
        this.jd.btnActualizarPago.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton SourceBoton = (JButton) e.getSource();
        if (SourceBoton == jd.btnActualizarPago) {

                       String PagarNew = jd.txtPagarNew.getText();
            System.out.println("Nuevo monto pagado en controlador pagos:" +PagarNew);   
            
            cldAO.PagarDeudas(jd, np.tblBuscarPagos2, np.lblPagosPendientes);
           
            
        }
    }

}
