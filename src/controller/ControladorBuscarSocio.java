/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import conexionBD.conexion;
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
import java.sql.*;
import javax.swing.JOptionPane;
import model.Cliente;
import model.ClienteDAO;
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
        if (e.getSource()==np.lblAtrasEnEditCliente) {
              np.jTabbedPane1.setSelectedIndex(2);
        cldao.ListarClientesBuscarNew(np.tblBuscarClientes, np.lblTotal);
        }

    }

  

    public byte[] mostrarFotoCliente(int codigoCliente) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        byte[] fotoDelCliente = null;

        try {
            conexion con = new conexion();
            cn = con.getConexion();
            String sql = "SELECT Foto FROM Usuarios WHERE codigo = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, codigoCliente);
            rs = ps.executeQuery();

            if (rs.next()) {
                fotoDelCliente = rs.getBytes("Foto");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return fotoDelCliente;
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
