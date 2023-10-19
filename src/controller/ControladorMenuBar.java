/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import javax.swing.JButton;
import javax.swing.JLabel;
import model.ClienteDAO;
import view.newprincipal;

public class ControladorMenuBar implements ActionListener, MouseListener {

    private static final Color COLOR_FONDO_MOUSE_ENTERED = new Color(0, 0, 0);
    private static final Color COLOR_TEXTO_MOUSE_ENTERED = new Color(255, 255, 255);
    private static final Color COLOR_FONDO_NORMAL = new Color(0, 0, 47);
    private static final Color COLOR_TEXTO_NORMAL = new Color(255, 255, 255);

    private newprincipal np;
    ClienteDAO cldAO = new ClienteDAO();

    public ControladorMenuBar(newprincipal np) {
        this.np = np;
        np.lblInicio.addMouseListener(this);
        np.lblRegistros.addMouseListener(this);
        np.lblProducts.addMouseListener(this);
        np.lblConsulta.addMouseListener(this);
        np.lblCerrar.addMouseListener(this);
        // Establecer el estilo inicial
        setComponentStyle(np.lblInicio, COLOR_FONDO_NORMAL, COLOR_TEXTO_NORMAL);
        setComponentStyle(np.lblRegistros, COLOR_FONDO_NORMAL, COLOR_TEXTO_NORMAL);
        setComponentStyle(np.lblProducts, COLOR_FONDO_NORMAL, COLOR_TEXTO_NORMAL);
        setComponentStyle(np.lblConsulta, COLOR_FONDO_NORMAL, COLOR_TEXTO_NORMAL);
        setComponentStyle(np.lblCerrar, COLOR_FONDO_NORMAL, COLOR_TEXTO_NORMAL);
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        if (e.getSource() == np.lblInicio) {
            np.jTabbedPane1.setSelectedIndex(0);

        } else if (e.getSource() == np.lblRegistros) {
            np.jTabbedPane1.setSelectedIndex(3);
        } else if (e.getSource() == np.lblProducts) {
            np.jTabbedPane1.setSelectedIndex(8);
        } else if (e.getSource() == np.lblConsulta) {
            np.jTabbedPane1.setSelectedIndex(5);
        } else if (e.getSource() == np.lblCerrar) {
            System.exit(0);
        }
       
    }

    @Override
    public void mouseEntered(MouseEvent e) {
        JLabel sourceLabel = (JLabel) e.getSource();
        setComponentStyle(sourceLabel, COLOR_FONDO_MOUSE_ENTERED, COLOR_TEXTO_MOUSE_ENTERED);
    }

    @Override
    public void mouseExited(MouseEvent e) {
        JLabel sourceLabel = (JLabel) e.getSource();
        setComponentStyle(sourceLabel, COLOR_FONDO_NORMAL, COLOR_TEXTO_NORMAL);
    }

    private void setComponentStyle(JLabel label, Color fondo, Color texto) {
        label.setBackground(fondo);
        label.setForeground(texto);
    }

    @Override
    public void mousePressed(MouseEvent e) {
    }

    @Override
    public void mouseReleased(MouseEvent e) {
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourcebuton=(JButton)e.getSource();;
       
    }
}
