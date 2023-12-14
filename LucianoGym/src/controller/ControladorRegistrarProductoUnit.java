/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
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
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileNameExtensionFilter;
import model.ProductoUnitario;
import model.ProductosDao;
import model.RegistroProductos;
import view.jdlRegistrarProductoUnitario;
import view.newprincipal;

/**
 *
 * @author User
 */
public class ControladorRegistrarProductoUnit implements ActionListener, MouseListener {

    jdlRegistrarProductoUnitario ru;
    newprincipal np;
    RegistroProductos pr = new RegistroProductos();
    ProductosDao pd = new ProductosDao();

    public ControladorRegistrarProductoUnit(newprincipal np, jdlRegistrarProductoUnitario ru) {
        this.np = np;
        this.ru = ru;
        ru.btnRegistrarProd.addActionListener(this);
        ru.jLabel2.addMouseListener(this);
        
 ru.addWindowListener(new WindowAdapter() {
            @Override
            public void windowOpened(WindowEvent e) {
                // Llena la tabla después de que el diálogo se haya abierto completamente
                pd.obtenerProximoCodigo(ru.txtCodProduct);
                pd.llenarComboBoxCategorias(ru.cbxCategorias);

            }
        });
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JButton sourceboton = (JButton) e.getSource();

        if (sourceboton == ru.btnRegistrarProd) {
            RegistrarProducto();
        }
    }

   private void RegistrarProducto() {
    if (!ru.txtNombreProduct.getText().isEmpty() && !ru.txtDescripcionProduct.getText().isEmpty()
            && !ru.txtPrecioProduct.getText().isEmpty() && !ru.txtStockProduc.getText().isEmpty() && !ru.cbxCategorias.getSelectedItem().equals("")) {
        ProductoUnitario pr = new ProductoUnitario();

        pr.setNombre(ru.txtNombreProduct.getText());
        pr.setDescripcion(ru.txtDescripcionProduct.getText());
        pr.setPrecio(Double.parseDouble(ru.txtPrecioProduct.getText()));
        pr.setStock(Integer.parseInt(ru.txtStockProduc.getText()));
        pr.setProductoID(Integer.parseInt(ru.txtCodProduct.getText()));
        String nombreCategoria = (String) ru.cbxCategorias.getSelectedItem();

        // Asume que tienes una forma de mapear nombres de categorías a IDs de categorías
        int idCategoria = pd.obtenerIdCategoriaPorNombre(nombreCategoria);
        pr.setCategoriaID(String.valueOf(idCategoria));

        javax.swing.Icon icono = ru.lblImage.getIcon();

        // Verifica si el ícono es nulo o no es una instancia de ImageIcon
        if (icono == null || !(icono instanceof ImageIcon)) {
            // Obtén el ícono predeterminado escalado al tamaño del JLabel
            ImageIcon iconoPredeterminado = obtenerIconoPredeterminado(ru.lblImage.getWidth(), ru.lblImage.getHeight());

            // Convierte el ícono predeterminado a bytes (byte[])
            BufferedImage imagenPredeterminada = new BufferedImage(iconoPredeterminado.getIconWidth(), iconoPredeterminado.getIconHeight(), BufferedImage.TYPE_INT_ARGB);
            Graphics g = imagenPredeterminada.getGraphics();
            iconoPredeterminado.paintIcon(null, g, 0, 0);
            g.dispose();

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            try {
                ImageIO.write(imagenPredeterminada, "png", baos);
                byte[] imagenBytes = baos.toByteArray();
                pr.setFotoProducto(imagenBytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            // Si hay un ícono en el JLabel, conviértelo a bytes y guárdalo en el producto
            ImageIcon imagenIcon = (ImageIcon) icono;
            Image imagen = imagenIcon.getImage();

            // Convierte la imagen a BufferedImage
            BufferedImage bufferedImage = new BufferedImage(imagen.getWidth(null), imagen.getHeight(null), BufferedImage.TYPE_INT_ARGB);
            Graphics2D g = bufferedImage.createGraphics();
            g.drawImage(imagen, 0, 0, null);
            g.dispose();

            // Convierte el BufferedImage a bytes (byte[])
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            try {
                ImageIO.write(bufferedImage, "png", baos);
                byte[] imagenBytes = baos.toByteArray();
                pr.setFotoProducto(imagenBytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Registra el producto
        pd.RegistrarProductoUnit(pr);
        ru.dispose();
    } else {
        JOptionPane.showMessageDialog(null, "Rellene todos los campos!", "VALIDACIÓN", JOptionPane.WARNING_MESSAGE);
    }
}

    private ImageIcon obtenerIconoPredeterminado(int anchoLabel, int altoLabel) {
 
    ImageIcon iconoPredeterminado = new ImageIcon(getClass().getResource("/icons/default.png"));

    Image imagen = iconoPredeterminado.getImage().getScaledInstance(anchoLabel, altoLabel, Image.SCALE_SMOOTH);
    
    return new ImageIcon(imagen);
}

    @Override
    public void mouseClicked(MouseEvent e) {
        if (e.getSource() == ru.jLabel2) {
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
                    pr.setImagenProducto(imagenBytes);

                    // Muestra la imagen en el componente lblImageSocio
                    ImageIcon icon = new ImageIcon(imagenBuffered.getScaledInstance(ru.lblImage.getWidth(), ru.lblImage.getHeight(), Image.SCALE_SMOOTH));
                    ru.lblImage.setIcon(icon);
                } catch (IOException ex) {
                    System.out.println(ex);
                    // Maneja la excepción aquí, por ejemplo, mostrando un mensaje de error.
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

}
