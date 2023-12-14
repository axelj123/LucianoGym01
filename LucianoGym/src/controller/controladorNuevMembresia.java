/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import model.Cliente;
import model.ClienteDAO;
import view.jdlNuevoRegisExistente;
import view.newprincipal;

/**
 *
 * @author User
 */
public class controladorNuevMembresia implements ActionListener{
    
    private newprincipal np;
    jdlNuevoRegisExistente jd;
    Cliente cl=new Cliente();
    ClienteDAO cldao=new ClienteDAO();
    public controladorNuevMembresia(newprincipal np, jdlNuevoRegisExistente jd){
        this.np = np;
        this.jd=jd;
        this.jd.btnRegistrar.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        JButton sourceboton=(JButton) e.getSource();
        if (sourceboton==jd.btnRegistrar) {
            if (!jd.txtMembresiaNew.getText().isEmpty() && !jd.txtsaldoNew.getText().isEmpty() && jd.jdateInicioNew.getDate() != null && jd.jdateFinnew.getDate() != null) {
            cl.setCodigo(Integer.parseInt(jd.txtCodEdit1.getText()));
            cl.setPrecioMembresia(Double.parseDouble(jd.txtMembresiaNew.getText()));
           cl.setMontoPagado(Double.parseDouble(jd.txtsaldoNew.getText()));
            cl.setFechaInicio(new java.sql.Date(jd.jdateInicioNew.getDate().getTime()));
            cl.setFechaFin(new java.sql.Date(jd.jdateFinnew.getDate().getTime()));
            cldao.InsertarNuevaMembresia(cl);
            jd.dispose();
        } else {
            JOptionPane.showMessageDialog(null, "!Complete todos los campos!", "Registro", JOptionPane.WARNING_MESSAGE);
        }
        }
    }
}
