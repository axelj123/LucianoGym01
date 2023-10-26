/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileNameExtensionFilter;
import model.Cliente;
import model.ClienteDAO;
import view.newprincipal;

public class ControladorRegistro implements ActionListener, MouseListener {

    newprincipal np = new newprincipal();
    Cliente cl = new Cliente();
    ClienteDAO cldao = new ClienteDAO();
//    private static final Color COLOR_FONDO_MOUSE_ENTERED = new Color(0, 0, 0);
//    private static final Color COLOR_TEXTO_MOUSE_ENTERED = new Color(255, 255, 255);
//    private static final Color COLOR_FONDO_NORMAL = new Color(0, 0, 47);
//    private static final Color COLOR_TEXTO_NORMAL = new Color(255, 255, 255);

    public ControladorRegistro(newprincipal np) {
        this.np = np;
        this.np.btnRegistrar.addActionListener(this);
        np.lblRegisFoto.addMouseListener(this);
        this.np.btnCancelar.addActionListener(this);
        this.np.btnNewRegistro.addActionListener(this);

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourceButton = (JButton) e.getSource();

        if (sourceButton == np.btnRegistrar) {
            registrarCliente();
        } else if (sourceButton == np.btnCancelar) {
            bloquear();
            LimpiarCasillasRegistrar();
            np.btnNewRegistro.setEnabled(true);
            np.btnRegistrar.setEnabled(false);
        } else if (sourceButton == np.btnNewRegistro) {
            desbloquear();
            np.btnNewRegistro.setEnabled(false);
            np.txtDni.setEnabled(false);
            np.btnRegistrar.setEnabled(true);
            np.btnRegistrarDNI.setEnabled(true);

        }
    }

    private void registrarCliente() {
        if (!np.txtNombres.getText().isEmpty() && !np.txtApellidos.getText().isEmpty()
                && !np.txtTelefono.getText().isEmpty() && np.jdateFin.getDate() != null
                && !np.txtPrecioMembresia.getText().isEmpty()
                && np.jdateInicio.getDate() != null && np.jdateFin.getDate() != null
                && !np.txtSaldo.getText().isEmpty()) {
            cl.setCodigo(Integer.parseInt(np.txtCodigo.getText()));
            cl.setNombres(np.txtNombres.getText());
            cl.setApellidos(np.txtApellidos.getText());
            cl.setTelefono(Integer.parseInt(np.txtTelefono.getText()));
            cl.setFechaNacimiento(new java.sql.Date(np.jdteFN.getDate().getTime()));
            
            javax.swing.Icon icono = np.lblImageSocio.getIcon();
            if (icono instanceof ImageIcon) {
                ImageIcon imagenIcon = (ImageIcon) icono;
                Image imagen = imagenIcon.getImage();

                // Convierte la imagen a BufferedImage
                BufferedImage bufferedImage = new BufferedImage(
                        imagen.getWidth(null),
                        imagen.getHeight(null),
                        BufferedImage.TYPE_INT_RGB
                );

                // Dibuja la imagen en el BufferedImage
                Graphics2D g = bufferedImage.createGraphics();
                g.drawImage(imagen, 0, 0, null);
                g.dispose();

                // Convierte el BufferedImage a bytes (byte[])
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                try {
                    ImageIO.write(bufferedImage, "jpg", baos);
                    byte[] imagenBytes = baos.toByteArray();
                    cl.setFoto(imagenBytes);
                } catch (IOException e) {
                    System.out.println(e);;
                }
            }
            cl.setPrecioMembresia(Double.parseDouble(np.txtPrecioMembresia.getText()));
            cl.setFechaInicio(new java.sql.Date(np.jdateInicio.getDate().getTime()));

            if (np.txtDni.isEnabled() && !np.txtDni.getText().isEmpty()) {
                cl.setDni(Integer.parseInt(np.txtDni.getText()));
            } else {
                cl.setDni(000000000); // Establecer DNI como null cuando está deshabilitado o vacío
            }
            cl.setFechaFin(new java.sql.Date(np.jdateFin.getDate().getTime()));

            cl.setMontoPagado(Double.parseDouble(np.txtSaldo.getText()));
            cl.setMontoRestante(cl.calcularMontoRestante());

            np.txtResta.setText(String.valueOf(cl.getMontoRestante()));
            cldao.registrarCliente(cl);

            JOptionPane.showMessageDialog(null, "Registrado correctamente");
            np.btnNewRegistro.setEnabled(true);
            LimpiarCasillasRegistrar();
        } else {
            JOptionPane.showMessageDialog(null, "Faltan campos");
        }
    }

    public void LimpiarCasillasRegistrar() {
        np.txtNombres.setText("");
        np.txtApellidos.setText("");
        np.txtTelefono.setText("");
        np.jdteFN.setDate(null); // Establece la fecha en null para limpiar el JDateChooser
        np.txtDni.setText("");
        np.txtPrecioMembresia.setText("");
        np.jdateInicio.setDate(null); // Asegúrate de limpiar jdateInicio también
        np.jdateFin.setDate(null); // Establece la fecha en null para limpiar el JDateChooser
        np.txtSaldo.setText("");
        np.lblImageSocio.setIcon(null);
        np.txtResta.setText("");
    }

    public void desbloquear() {
        System.out.println("desbloquear");
        np.txtNombres.setEnabled(true);
        np.txtApellidos.setEnabled(true);
        np.txtTelefono.setEnabled(true);
        np.jdteFN.setEnabled(true);

        np.txtDni.setEnabled(true);
        np.txtPrecioMembresia.setEnabled(true);
        np.jdateInicio.setEnabled(true);
        np.jdateFin.setEnabled(true);
        np.txtSaldo.setEnabled(true);
    }

    public void bloquear() {
        System.out.println("bloquear");
        np.txtNombres.setEnabled(false);
        np.txtApellidos.setEnabled(false);
        np.txtTelefono.setEnabled(false);
        np.txtCodigo.setEnabled(false);
        np.jdteFN.setEnabled(false);
        np.txtResta.setEnabled(false);

        np.txtDni.setEnabled(false);
        np.txtPrecioMembresia.setEnabled(false);
        np.jdateInicio.setEnabled(false);
        np.jdateFin.setEnabled(false);
        np.txtSaldo.setEnabled(false);
        np.txtResta.setEnabled(false);
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
    public void mouseClicked(MouseEvent e) {
        if (e.getSource() == np.lblRegisFoto) {
            JFileChooser jFileChooser = new JFileChooser();
            FileNameExtensionFilter filter = new FileNameExtensionFilter("JPG,JPEG PNG, GIF", "jpg", "jpeg", "png", "gif");
            jFileChooser.setFileFilter(filter);
            int respuesta = jFileChooser.showOpenDialog(np);

            if (respuesta == JFileChooser.APPROVE_OPTION) {
                String Ruta = jFileChooser.getSelectedFile().getPath();

                try {
                    BufferedImage imagenBuffered = ImageIO.read(new File(Ruta));

                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    ImageIO.write(imagenBuffered, "jpg", baos);
                    byte[] imagenBytes = baos.toByteArray();

                    // Asigna los bytes de la imagen al campo imagenProducto del objeto Productos
                    // Suponiendo que 'cl' es un objeto de la clase Productos
                    cl.setFoto(imagenBytes);

                    // Muestra la imagen en el componente lblImageSocio
                    ImageIcon icon = new ImageIcon(imagenBuffered.getScaledInstance(np.lblImageSocio.getWidth(), np.lblImageSocio.getHeight(), Image.SCALE_SMOOTH));
                    np.lblImageSocio.setIcon(icon);
                } catch (IOException ex) {
                    System.out.println(ex);
                    // Maneja la excepción aquí, por ejemplo, mostrando un mensaje de error.
                }
            }
        }

    }

}
