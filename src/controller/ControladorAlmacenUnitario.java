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
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.filechooser.FileNameExtensionFilter;
import model.Cliente;
import model.ProductoUnitario;
import model.Productos;
import model.ProductosDao;
import view.jdlAlmacenUnitarios;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorAlmacenUnitario implements ActionListener, MouseListener, KeyListener {

    private newprincipal np;
    jdlAlmacenUnitarios jd;
    ProductosDao pdao = new ProductosDao();
    ProductoUnitario pr = new ProductoUnitario();

    public ControladorAlmacenUnitario(newprincipal np, jdlAlmacenUnitarios jd) {
        this.np = np;
        this.jd = jd;
        jd.addWindowListener(new WindowAdapter() {
            @Override
            public void windowOpened(WindowEvent e) {
                // Llena la tabla después de que el diálogo se haya abierto completamente
                pdao.listarProductosUnitaros(jd.tblProducsUnit,jd.lblTotal);

            }
        });
        jd.btnGuardarCambios.addActionListener(this);
        jd.btnCambiarFoto.addActionListener(this);
        jd.tblProducsUnit.addMouseListener(this);
        jd.btnEliminarProducto.addActionListener(this);
        jd.txtBuscarUnitProduct.addKeyListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourceboton = (JButton) e.getSource();
        if (sourceboton == jd.btnGuardarCambios) {

            pr.setStock(Integer.parseInt(jd.txtStockUnit.getText()));
            pr.setPrecio(Double.parseDouble(jd.txtPrecioUnit.getText()));
            pr.setProductoID(Integer.parseInt(jd.txtCodProductoUni.getText()));

            javax.swing.Icon icono = jd.lblImagenUnit.getIcon();
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
                    pr.setFotoProducto(imagenBytes);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }

            pdao.actualizarProductUnit(pr);
            jd.lblImagenUnit.setIcon(null);
            jd.txtCodProductoUni.setText("");
            jd.txtPrecioUnit.setText("");
            jd.txtStockUnit.setText("");
            pdao.listarProductosUnitaros(jd.tblProducsUnit, jd.lblTotal);

        }
        if (sourceboton == jd.btnEliminarProducto) {
            pr.setProductoID(Integer.parseInt(jd.txtCodProductoUni.getText()));
            jd.lblImagenUnit.setIcon(null);
            jd.txtCodProductoUni.setText("");
            jd.txtPrecioUnit.setText("");
            jd.txtStockUnit.setText("");
            pdao.EliminarProductoUnitario(jd.tblProducsUnit, pr);
            pdao.listarProductosUnitaros(jd.tblProducsUnit, jd.lblTotal);

        }
        if (sourceboton == jd.btnCambiarFoto) {
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
                    ImageIcon icon = new ImageIcon(imagenBuffered.getScaledInstance(jd.lblImagenUnit.getWidth(), jd.lblImagenUnit.getHeight(), Image.SCALE_SMOOTH));
                    jd.lblImagenUnit.setIcon(icon);
                } catch (IOException ex) {
                    System.out.println(ex);
                    // Maneja la excepción aquí, por ejemplo, mostrando un mensaje de error.
                }
            }

        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        JTable sourcetable = (JTable) e.getSource();
        if (sourcetable == jd.tblProducsUnit) {
            if (e.getButton() == MouseEvent.BUTTON1 && e.getClickCount() == 1) {
                jd.txtCodProductoUni.setText("");
                int fila = jd.tblProducsUnit.rowAtPoint(e.getPoint());
                int columna = jd.tblProducsUnit.columnAtPoint(e.getPoint());
                if ((fila > -1) && (columna > -1)) {
                    pr.setProductoID(Integer.parseInt(jd.tblProducsUnit.getValueAt(fila, 0).toString()));
                    pr.setPrecio(Double.parseDouble(jd.tblProducsUnit.getValueAt(fila, 4).toString()));
                    pr.setStock((Integer.parseInt(jd.tblProducsUnit.getValueAt(fila, 5).toString())));

                    jd.txtCodProductoUni.setText(String.valueOf(pr.getProductoID()));
                    jd.txtPrecioUnit.setText(String.valueOf(pr.getPrecio()));
                    jd.txtStockUnit.setText(String.valueOf(pr.getStock()));

                    mostrarFotoProducto(jd.lblImagenUnit, pr.getProductoID());

                }

            }
        }
    }

    public void mostrarFotoProducto(JLabel imagen, int codigo) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conexion con = new conexion();
            cn = con.getConexion();
            String sql = "SELECT ImagenProducto FROM Productos WHERE ID = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, codigo);
            rs = ps.executeQuery();

            if (rs.next()) {
                byte[] fotoBytes = rs.getBytes("ImagenProducto");

                if (fotoBytes != null && fotoBytes.length > 0) {
                    // Si hay datos en el campo de la foto, mostrar la imagen del cliente
                    ImageIcon imageIcon = new ImageIcon(fotoBytes);
                    Image image = imageIcon.getImage().getScaledInstance(imagen.getWidth(), imagen.getHeight(), Image.SCALE_SMOOTH);

                    imagen.setIcon(new ImageIcon(image));
                    imagen.setText(""); // Limpia el texto del JLabel
                } else {
                    // Si el campo de la foto está vacío, dejar el JLabel vacío
                    imagen.setIcon(null); // Limpia la imagen del JLabel
                    imagen.setText(""); // Limpia el texto del JLabel
                }

                System.out.println("Foto del Producto mostrada en el JLabel.");
            } else {
                imagen.setText("Producto no encontrado.");
                imagen.setIcon(null); // Limpia la imagen del JLabel
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
        System.out.println("Key Released"); // Agrega este mensaje de consola

        JTextField txtKey = (JTextField) e.getSource();
        if (txtKey == jd.txtBuscarUnitProduct) {
            String valor = jd.txtBuscarUnitProduct.getText();
            pr.setNombre(valor);
            pdao.buscarProductosPorNombre(pr, jd.tblProducsUnit, jd.lblTotal);
        }
    }
}
