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
public class jdlEditarCliente extends javax.swing.JDialog {

    /**
     * Creates new form Registrar
     */
    public jdlEditarCliente(java.awt.Frame parent, boolean modal) {
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
        jPanel2 = new javax.swing.JPanel();
        btnSalirEdicionCliente = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jLabel32 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jTextField1 = new javax.swing.JTextField();
        jTextField2 = new javax.swing.JTextField();
        jTextField3 = new javax.swing.JTextField();
        jTextField4 = new javax.swing.JTextField();
        jTextField5 = new javax.swing.JTextField();
        jDateChooser1 = new com.toedter.calendar.JDateChooser();
        jDateChooser2 = new com.toedter.calendar.JDateChooser();
        jLabel7 = new javax.swing.JLabel();
        jTextField6 = new javax.swing.JTextField();
        jLabel8 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        jTextField7 = new javax.swing.JTextField();
        jTextField8 = new javax.swing.JTextField();
        btnActualizarDatosCliente = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));
        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel2.setBackground(new java.awt.Color(0, 0, 80));
        jPanel2.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());
        jPanel1.add(jPanel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 450, 830, 60));

        btnSalirEdicionCliente.setBackground(new java.awt.Color(204, 204, 204));
        btnSalirEdicionCliente.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        btnSalirEdicionCliente.setIcon(new javax.swing.ImageIcon(getClass().getResource("/icons/cerrar.png"))); // NOI18N
        btnSalirEdicionCliente.setText("SALIR");
        btnSalirEdicionCliente.setBorder(null);
        btnSalirEdicionCliente.setFocusPainted(false);
        btnSalirEdicionCliente.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnSalirEdicionClienteMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnSalirEdicionClienteMouseExited(evt);
            }
            public void mousePressed(java.awt.event.MouseEvent evt) {
                btnSalirEdicionClienteMousePressed(evt);
            }
        });
        btnSalirEdicionCliente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSalirEdicionClienteActionPerformed(evt);
            }
        });
        jPanel1.add(btnSalirEdicionCliente, new org.netbeans.lib.awtextra.AbsoluteConstraints(600, 360, 170, 40));

        jLabel1.setText("FECHA DE FIN:");
        jPanel1.add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(540, 140, -1, 20));

        jLabel32.setFont(new java.awt.Font("Corbel", 0, 36)); // NOI18N
        jLabel32.setForeground(new java.awt.Color(153, 153, 153));
        jLabel32.setText("EDITAR DATOS DEL CLIENTE");
        jPanel1.add(jLabel32, new org.netbeans.lib.awtextra.AbsoluteConstraints(170, 20, 510, 40));

        jLabel2.setText("DNI:");
        jPanel1.add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(30, 80, -1, -1));

        jLabel3.setText("NOMBRES:");
        jPanel1.add(jLabel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(220, 80, -1, -1));

        jLabel4.setText("APELLIDOS:");
        jPanel1.add(jLabel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(490, 80, -1, 20));

        jLabel6.setText("FECHA DE INICIO:");
        jPanel1.add(jLabel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(260, 140, -1, 20));
        jPanel1.add(jTextField1, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 70, 140, 40));
        jPanel1.add(jTextField2, new org.netbeans.lib.awtextra.AbsoluteConstraints(340, 230, 140, 40));
        jPanel1.add(jTextField3, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 70, 140, 40));
        jPanel1.add(jTextField4, new org.netbeans.lib.awtextra.AbsoluteConstraints(60, 70, 140, 40));
        jPanel1.add(jTextField5, new org.netbeans.lib.awtextra.AbsoluteConstraints(60, 70, 140, 40));
        jPanel1.add(jDateChooser1, new org.netbeans.lib.awtextra.AbsoluteConstraints(640, 130, 160, 40));
        jPanel1.add(jDateChooser2, new org.netbeans.lib.awtextra.AbsoluteConstraints(360, 130, 160, 40));

        jLabel7.setText("RESTA:");
        jPanel1.add(jLabel7, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 240, -1, 20));
        jPanel1.add(jTextField6, new org.netbeans.lib.awtextra.AbsoluteConstraints(100, 130, 140, 40));

        jLabel8.setText("TELEFONO:");
        jPanel1.add(jLabel8, new org.netbeans.lib.awtextra.AbsoluteConstraints(30, 140, -1, 20));

        jLabel9.setText("AGREGAR PAGO:");
        jPanel1.add(jLabel9, new org.netbeans.lib.awtextra.AbsoluteConstraints(30, 240, -1, 20));
        jPanel1.add(jTextField7, new org.netbeans.lib.awtextra.AbsoluteConstraints(130, 230, 140, 40));
        jPanel1.add(jTextField8, new org.netbeans.lib.awtextra.AbsoluteConstraints(130, 230, 140, 40));

        btnActualizarDatosCliente.setBackground(new java.awt.Color(204, 204, 204));
        btnActualizarDatosCliente.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        btnActualizarDatosCliente.setIcon(new javax.swing.ImageIcon(getClass().getResource("/icons/sincronizar.png"))); // NOI18N
        btnActualizarDatosCliente.setText("ACTUALIZAR");
        btnActualizarDatosCliente.setBorder(null);
        btnActualizarDatosCliente.setFocusPainted(false);
        btnActualizarDatosCliente.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnActualizarDatosClienteMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnActualizarDatosClienteMouseExited(evt);
            }
            public void mousePressed(java.awt.event.MouseEvent evt) {
                btnActualizarDatosClienteMousePressed(evt);
            }
        });
        btnActualizarDatosCliente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnActualizarDatosClienteActionPerformed(evt);
            }
        });
        jPanel1.add(btnActualizarDatosCliente, new org.netbeans.lib.awtextra.AbsoluteConstraints(100, 330, 170, 40));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 824, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 510, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnSalirEdicionClienteMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnSalirEdicionClienteMouseEntered
 btnSalirEdicionCliente.setBackground(new Color(0, 0,0));
        btnSalirEdicionCliente.setForeground(new Color(255, 255, 255));
    }//GEN-LAST:event_btnSalirEdicionClienteMouseEntered

    private void btnSalirEdicionClienteMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnSalirEdicionClienteMouseExited
       btnSalirEdicionCliente.setBackground(new Color(204, 204,204));
        btnSalirEdicionCliente.setForeground(new Color(0, 0, 0));
    }//GEN-LAST:event_btnSalirEdicionClienteMouseExited

    private void btnSalirEdicionClienteMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnSalirEdicionClienteMousePressed

    }//GEN-LAST:event_btnSalirEdicionClienteMousePressed

    private void btnSalirEdicionClienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSalirEdicionClienteActionPerformed
       
    
    }//GEN-LAST:event_btnSalirEdicionClienteActionPerformed

    private void btnActualizarDatosClienteMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnActualizarDatosClienteMouseEntered
   btnActualizarDatosCliente.setBackground(new Color(0, 0,0));
        btnActualizarDatosCliente.setForeground(new Color(255, 255, 255));
    }//GEN-LAST:event_btnActualizarDatosClienteMouseEntered

    private void btnActualizarDatosClienteMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnActualizarDatosClienteMouseExited
 btnActualizarDatosCliente.setBackground(new Color(204, 204,204));
        btnActualizarDatosCliente.setForeground(new Color(0, 0, 0));
    }//GEN-LAST:event_btnActualizarDatosClienteMouseExited

    private void btnActualizarDatosClienteMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnActualizarDatosClienteMousePressed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnActualizarDatosClienteMousePressed

    private void btnActualizarDatosClienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnActualizarDatosClienteActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnActualizarDatosClienteActionPerformed

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
            java.util.logging.Logger.getLogger(jdlEditarCliente.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(jdlEditarCliente.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(jdlEditarCliente.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(jdlEditarCliente.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                jdlEditarCliente dialog = new jdlEditarCliente(new javax.swing.JFrame(), true);
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
    private javax.swing.JButton btnActualizarDatosCliente;
    private javax.swing.JButton btnSalirEdicionCliente;
    private com.toedter.calendar.JDateChooser jDateChooser1;
    private com.toedter.calendar.JDateChooser jDateChooser2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel32;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JTextField jTextField4;
    private javax.swing.JTextField jTextField5;
    private javax.swing.JTextField jTextField6;
    private javax.swing.JTextField jTextField7;
    private javax.swing.JTextField jTextField8;
    // End of variables declaration//GEN-END:variables
}
