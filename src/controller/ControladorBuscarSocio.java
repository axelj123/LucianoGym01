/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
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
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.JOptionPane;
import model.Cliente;
import model.ClienteDAO;
import view.jdlNuevoRegisExistente;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorBuscarSocio implements ActionListener, MouseListener {

    private newprincipal np;
    private Cliente cl;
    private ClienteDAO cldao;

    public ControladorBuscarSocio(newprincipal np) {
        this.np = np;
        this.cl = new Cliente();
        this.cldao = new ClienteDAO();
        np.lblCambiarFoto.addMouseListener(this);
        np.btnActualizarDatosCliente.addActionListener(this);

        np.btnNuevoRegistroCliente.addActionListener(this);
        np.lblAtrasEnEditCliente.addMouseListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        JButton sourceButton = (JButton) e.getSource();

        if (sourceButton == np.btnActualizarDatosCliente) {
            // Crear un nuevo objeto Cliente para el cliente actual
            Cliente clienteActual = new Cliente();

            // Obtener otros datos del cliente desde los campos de texto y componentes
            clienteActual.setDni(Integer.parseInt(np.txtDniEdit.getText()));
            clienteActual.setNombres(np.txtNombreEdit.getText());
            clienteActual.setApellidos(np.txtApellidoEdit.getText());
            clienteActual.setTelefono(Integer.parseInt(np.txtTelefonoEdit.getText()));
            clienteActual.setFechaNacimiento(new java.sql.Date(np.jdteFNedit.getDate().getTime()));
            clienteActual.setCodigo(Integer.parseInt(np.txtCodEdit.getText()));

            javax.swing.Icon icono = np.lblFotoEditarCliente.getIcon();
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
                    clienteActual.setFoto(imagenBytes);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }

            // Llamar al método de la base de datos para editar el cliente actual
            cldao.EditarDatosCliente(clienteActual);
        }
        if (sourceButton == np.btnNuevoRegistroCliente) {
            int clienteID = Integer.parseInt(np.txtCodEdit.getText()); // Obtener el ID del cliente desde algún campo de entrada
            cl.setCodigo(clienteID);
            System.out.println("ID del Cliente: " + cl.getCodigo());

            if (cldao.puedeRegistrarNuevaMembresia(clienteID)) {
                // Resto del código para crear la nueva membresía
                jdlNuevoRegisExistente nm = new jdlNuevoRegisExistente(null, true, cl);
                nm.txtCodEdit1.setText(String.valueOf(cl.getCodigo()));
                nm.txtsaldoNew.addKeyListener(new KeyAdapter() {
                    @Override
                    public void keyReleased(KeyEvent e) {
                        actualizarMontoRestante(nm);
                    }
                });
                nm.txtCodEdit1.setEnabled(false);
                nm.txtRestaNew.setEnabled(false);
                nm.setLocationRelativeTo(null);
                nm.setVisible(true);
            } else {
                JOptionPane.showMessageDialog(null, "El cliente no cumple con las condiciones para registrar una nueva membresía.", "Registro", JOptionPane.WARNING_MESSAGE);
            }
        }

    }

    @Override
    public void mouseClicked(MouseEvent e) {
        if (e.getSource() == np.lblCambiarFoto) {
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
                    // Muestra la imagen en el componente lblImageSocio
                    ImageIcon icon = new ImageIcon(imagenBuffered.getScaledInstance(np.lblFotoEditarCliente.getWidth(), np.lblFotoEditarCliente.getHeight(), Image.SCALE_SMOOTH));
                    np.lblFotoEditarCliente.setIcon(icon);
                } catch (IOException ex) {
                    System.out.println(ex);
                    // Maneja la excepción aquí, por ejemplo, mostrando un mensaje de error.
                }
            }
        }
        if (e.getSource() == np.lblAtrasEnEditCliente) {
            np.jTabbedPane1.setSelectedIndex(2);
            cldao.ListarClientesBuscarNew(np.tblBuscarClientes, np.lblTotal);
        }

    }

    private void actualizarMontoRestante(jdlNuevoRegisExistente jd) {
        try {
            double precioMembresia = Double.parseDouble(jd.txtMembresiaNew.getText());
            double saldo = Double.parseDouble(jd.txtsaldoNew.getText());

            if (saldo > precioMembresia) {
                // El saldo no puede ser mayor que la membresía
                JOptionPane.showMessageDialog(null, "El saldo no puede ser mayor que la membresía.", "Error", JOptionPane.ERROR_MESSAGE);
                jd.txtsaldoNew.setText(""); // Limpiar el campo de saldo
                jd.txtRestaNew.setText(""); // Limpiar el campo de monto restante
            } else {
                double montoRestante = precioMembresia - saldo;
                jd.txtRestaNew.setText(String.valueOf(montoRestante));
            }
        } catch (NumberFormatException ex) {
            // Manejar errores de conversión numérica aquí
            jd.txtRestaNew.setText(""); // Limpiar el campo si hay un error
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
