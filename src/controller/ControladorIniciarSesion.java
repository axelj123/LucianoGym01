package controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import model.ClienteDAO;
import model.UsuarioAdminDao;
import view.LoginApp;
import view.newprincipal;

public class ControladorIniciarSesion implements ActionListener {

    LoginApp ap;
    ClienteDAO cldao=new ClienteDAO();

    public ControladorIniciarSesion(LoginApp ap) {
        this.ap = ap;
        ap.btnIniciarSesion.addActionListener(this);

        // Agregar KeyListener al campo de texto de la contraseña
        ap.txtPass.addKeyListener(new KeyListener() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_ENTER) {
                    iniciarSesion();
                }
            }

            @Override
            public void keyTyped(KeyEvent e) {
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }
        });
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourcebutton = (JButton) e.getSource();
        if (sourcebutton == ap.btnIniciarSesion) {
            iniciarSesion();
        }
    }

    private void iniciarSesion() {
        UsuarioAdminDao us = new UsuarioAdminDao();

        if (!ap.txtUser.getText().isEmpty() && ap.txtPass.getPassword().length > 0) {
            String usuario = ap.txtUser.getText();
            String contraseña = new String(ap.txtPass.getPassword());
            if (us.iniciarSesion(usuario, contraseña)) {
                // Inicio de sesión exitoso, abre la nueva ventana
                JOptionPane.showMessageDialog(null, "Inicio de sesion exitoso ", "Inicio Sesion",
                        JOptionPane.INFORMATION_MESSAGE);
                newprincipal np = new newprincipal();
                
                cldao.VenceHoy(np.tblVencen);
                ControladorMenuBar con = new ControladorMenuBar(np);
                np.setVisible(true);
                ControladorButtonsInterfaces controladorInterfaz = new ControladorButtonsInterfaces(np);

                ap.dispose();
            } else {
                // Inicio de sesión fallido, muestra un mensaje de error
                JOptionPane.showMessageDialog(null, "Usuario o contraseña incorrectos", "Inicio de Sesión Fallido",
                        JOptionPane.ERROR_MESSAGE);
                ap.txtPass.setText("");
                ap.txtUser.setText("");
                ap.txtUser.requestFocus();
            }
        } else {
            JOptionPane.showMessageDialog(null, "Complete todos los campos ", "Inicio Sesion",
                    JOptionPane.INFORMATION_MESSAGE);
        }
    }

}
