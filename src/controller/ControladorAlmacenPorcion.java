/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

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

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.filechooser.FileNameExtensionFilter;
import model.ProductoPorcion;
import model.ProductosDao;
import view.jdlAlmacenPorcion;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorAlmacenPorcion implements ActionListener, MouseListener, KeyListener {

    private newprincipal np;
    jdlAlmacenPorcion jd;
    ProductosDao pdao = new ProductosDao();
    ProductoPorcion pr = new ProductoPorcion();

    public ControladorAlmacenPorcion(newprincipal np, jdlAlmacenPorcion jd) {
        this.np = np;
        this.jd = jd;
        jd.addWindowListener(new WindowAdapter() {
            @Override
            public void windowOpened(WindowEvent e) {
                // Llena la tabla después de que el diálogo se haya abierto completamente
                pdao.listarProductosPorcion(jd.tblProducsPor,jd.lblTotal);
                jd.txtCodProductoPor.setEnabled(false);
           

            }
        });
        jd.btnGuardarCambios.addActionListener(this);
        jd.btnCambiarFotoPor.addActionListener(this);
        jd.tblProducsPor.addMouseListener(this);
        jd.btnEliminarProducto.addActionListener(this);
        jd.txtBuscarPorcProduct.addKeyListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourceboton = (JButton) e.getSource();
        if (sourceboton == jd.btnGuardarCambios) {

            pr.setStock(Integer.parseInt(jd.txtStockPor.getText()));
            pr.setPrecio(Double.parseDouble(jd.txtPrecioPor.getText()));
            pr.setProductoID(Integer.parseInt(jd.txtCodProductoPor.getText()));
            pr.setStockPor(Integer.parseInt(jd.txtScoopsPor.getText()));

            javax.swing.Icon icono = jd.lblImagenPor.getIcon();
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

            pdao.actualizarStockYProductoPor(pr);
            jd.lblImagenPor.setIcon(null);
            jd.txtCodProductoPor.setText("");
            jd.txtPrecioPor.setText("");
            jd.txtStockPor.setText("");
            jd.txtScoopsPor.setText("");
                pdao.listarProductosPorcion(jd.tblProducsPor,jd.lblTotal);

        }
        if (sourceboton == jd.btnEliminarProducto) {
            pr.setProductoID(Integer.parseInt(jd.txtCodProductoPor.getText()));
               jd.lblImagenPor.setIcon(null);
            jd.txtCodProductoPor.setText("");
            jd.txtPrecioPor.setText("");
            jd.txtStockPor.setText("");
            jd.txtScoopsPor.setText("");
            pdao.EliminarProductoPorcion(jd.tblProducsPor, pr);
            pdao.listarProductosPorcion(jd.tblProducsPor, jd.lblTotal);

        }
        if (sourceboton == jd.btnCambiarFotoPor) {
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
                    ImageIcon icon = new ImageIcon(imagenBuffered.getScaledInstance(jd.lblImagenPor.getWidth(), jd.lblImagenPor.getHeight(), Image.SCALE_SMOOTH));
                    jd.lblImagenPor.setIcon(icon);
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
        if (sourcetable == jd.tblProducsPor) {
            if (e.getButton() == MouseEvent.BUTTON1 && e.getClickCount() == 1) {
                jd.txtCodProductoPor.setText("");
                int fila = jd.tblProducsPor.rowAtPoint(e.getPoint());
                int columna = jd.tblProducsPor.columnAtPoint(e.getPoint());
                if ((fila > -1) && (columna > -1)) {
                    pr.setProductoID(Integer.parseInt(jd.tblProducsPor.getValueAt(fila, 0).toString()));
                    pr.setPrecio(Double.parseDouble(jd.tblProducsPor.getValueAt(fila, 4).toString()));
                    pr.setStock((Integer.parseInt(jd.tblProducsPor.getValueAt(fila, 5).toString())));
                    pr.setStockPor(Integer.parseInt(jd.tblProducsPor.getValueAt(fila, 6).toString()));

                    jd.txtCodProductoPor.setText(String.valueOf(pr.getProductoID()));
                    jd.txtPrecioPor.setText(String.valueOf(pr.getPrecio()));
                    jd.txtStockPor.setText(String.valueOf(pr.getStock()));
                    jd.txtScoopsPor.setText(String.valueOf(pr.getStockPor()));

                    pdao.mostrarFotoProducto(jd.lblImagenPor, pr.getProductoID());

                }

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
        if (txtKey == jd.txtBuscarPorcProduct) {
            String valor = jd.txtBuscarPorcProduct.getText();
            pr.setNombre(valor);
            pdao.buscarProductosPorNombrePorcion(pr, jd.tblProducsPor, jd.lblTotal);
        }
    }
}

