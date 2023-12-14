/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JDialog.java to edit this template
 */
package view;

import java.awt.Color;

/**
 *
 * @author User
 */
public class jdlVentaPorcion extends javax.swing.JDialog {

    /**
     * Creates new form jdlAlmacenUnitarios
     */
    public jdlVentaPorcion(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        setLocationRelativeTo(null);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblProducs = new tableNew.Table();
        jLabel51 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        txtBuscarPorcProduct = new javax.swing.JTextField();
        roundPanel1 = new controller.RoundPanel();
        txtCodProductoVenta = new javax.swing.JTextField();
        jLabel5 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        txtNombreProducto = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        txtTotalVenta = new javax.swing.JTextField();
        lblImagenPor = new javax.swing.JLabel();
        btnVender = new javax.swing.JButton();
        jLabel4 = new javax.swing.JLabel();
        txtCantidadVenta = new javax.swing.JTextField();
        jLabel7 = new javax.swing.JLabel();
        txtPrecioVenta = new javax.swing.JTextField();
        lblTotal = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setResizable(false);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));
        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        tblProducs.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Codigo", "Nombre", "Descripción", "Categoria", "Precio", "Stock", "ScoopsTotal"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tblProducs.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tblProducsMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(tblProducs);

        jPanel1.add(jScrollPane1, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 360, 720, 370));

        jLabel51.setFont(new java.awt.Font("Corbel", 1, 24)); // NOI18N
        jLabel51.setForeground(new java.awt.Color(153, 153, 153));
        jLabel51.setText("VENTA DE PRODUCTOS PORCIONES");
        jPanel1.add(jLabel51, new org.netbeans.lib.awtextra.AbsoluteConstraints(150, 10, 460, 60));

        jLabel2.setText("Buscar:");
        jPanel1.add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 80, -1, -1));

        txtBuscarPorcProduct.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtBuscarPorcProductActionPerformed(evt);
            }
        });
        jPanel1.add(txtBuscarPorcProduct, new org.netbeans.lib.awtextra.AbsoluteConstraints(130, 70, 500, 40));

        roundPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        txtCodProductoVenta.setEnabled(false);
        roundPanel1.add(txtCodProductoVenta, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 50, 70, 40));

        jLabel5.setText("Codigo:");
        roundPanel1.add(jLabel5, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 60, -1, -1));

        jLabel3.setText("Nombre:");
        roundPanel1.add(jLabel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(160, 60, -1, -1));

        txtNombreProducto.setEnabled(false);
        txtNombreProducto.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtNombreProductoActionPerformed(evt);
            }
        });
        roundPanel1.add(txtNombreProducto, new org.netbeans.lib.awtextra.AbsoluteConstraints(220, 50, 170, 40));

        jLabel1.setText("Total:");
        roundPanel1.add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(150, 150, 40, -1));

        txtTotalVenta.setEnabled(false);
        txtTotalVenta.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtTotalVentaActionPerformed(evt);
            }
        });
        roundPanel1.add(txtTotalVenta, new org.netbeans.lib.awtextra.AbsoluteConstraints(190, 140, 70, 40));

        lblImagenPor.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        roundPanel1.add(lblImagenPor, new org.netbeans.lib.awtextra.AbsoluteConstraints(560, 10, 140, 150));

        btnVender.setBackground(new java.awt.Color(204, 204, 204));
        btnVender.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        btnVender.setIcon(new javax.swing.ImageIcon(getClass().getResource("/icons/carrito-de-compras (1).png"))); // NOI18N
        btnVender.setText("VENDER");
        btnVender.setBorder(null);
        btnVender.setFocusPainted(false);
        btnVender.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnVenderMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnVenderMouseExited(evt);
            }
            public void mousePressed(java.awt.event.MouseEvent evt) {
                btnVenderMousePressed(evt);
            }
        });
        btnVender.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnVenderActionPerformed(evt);
            }
        });
        roundPanel1.add(btnVender, new org.netbeans.lib.awtextra.AbsoluteConstraints(320, 140, 200, 40));

        jLabel4.setText("Precio:");
        roundPanel1.add(jLabel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 150, -1, -1));

        txtCantidadVenta.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtCantidadVentaActionPerformed(evt);
            }
        });
        roundPanel1.add(txtCantidadVenta, new org.netbeans.lib.awtextra.AbsoluteConstraints(470, 50, 50, 40));

        jLabel7.setText("Cantidad:");
        roundPanel1.add(jLabel7, new org.netbeans.lib.awtextra.AbsoluteConstraints(410, 60, -1, -1));

        txtPrecioVenta.setEnabled(false);
        txtPrecioVenta.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtPrecioVentaActionPerformed(evt);
            }
        });
        roundPanel1.add(txtPrecioVenta, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 140, 50, 40));

        jPanel1.add(roundPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 130, 720, 200));

        lblTotal.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jPanel1.add(lblTotal, new org.netbeans.lib.awtextra.AbsoluteConstraints(640, 740, 30, 30));

        jLabel6.setText("Numero de productos:");
        jPanel1.add(jLabel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(510, 746, -1, 20));

        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 760, 790));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void txtNombreProductoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtNombreProductoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtNombreProductoActionPerformed

    private void txtBuscarPorcProductActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtBuscarPorcProductActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarPorcProductActionPerformed

    private void txtTotalVentaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtTotalVentaActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtTotalVentaActionPerformed

    private void btnVenderMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnVenderMouseEntered
        btnVender.setBackground(new Color(0, 0, 0));
        btnVender.setForeground(new Color(255, 255, 255));
    }//GEN-LAST:event_btnVenderMouseEntered

    private void btnVenderMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnVenderMouseExited
        btnVender.setBackground(new Color(204, 204, 204));
        btnVender.setForeground(new Color(0, 0, 0));
    }//GEN-LAST:event_btnVenderMouseExited

    private void btnVenderMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnVenderMousePressed

    }//GEN-LAST:event_btnVenderMousePressed

    private void btnVenderActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnVenderActionPerformed

    }//GEN-LAST:event_btnVenderActionPerformed

    private void txtCantidadVentaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtCantidadVentaActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtCantidadVentaActionPerformed

    private void txtPrecioVentaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtPrecioVentaActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtPrecioVentaActionPerformed

    private void tblProducsMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tblProducsMouseClicked

    }//GEN-LAST:event_tblProducsMouseClicked

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(jdlVentaPorcion.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(jdlVentaPorcion.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(jdlVentaPorcion.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(jdlVentaPorcion.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                jdlVentaPorcion dialog = new jdlVentaPorcion(new javax.swing.JFrame(), true);
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    public javax.swing.JButton btnVender;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel51;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JPanel jPanel1;
    public javax.swing.JScrollPane jScrollPane1;
    public javax.swing.JLabel lblImagenPor;
    public javax.swing.JLabel lblTotal;
    private controller.RoundPanel roundPanel1;
    public tableNew.Table tblProducs;
    public javax.swing.JTextField txtBuscarPorcProduct;
    public javax.swing.JTextField txtCantidadVenta;
    public javax.swing.JTextField txtCodProductoVenta;
    public javax.swing.JTextField txtNombreProducto;
    public javax.swing.JTextField txtPrecioVenta;
    public javax.swing.JTextField txtTotalVenta;
    // End of variables declaration//GEN-END:variables
}