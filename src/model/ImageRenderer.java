/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.awt.Component;
import java.awt.Image;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;

/**
 *
 * @author User
 */

public class ImageRenderer extends DefaultTableCellRenderer implements TableCellRenderer  {
  @Override
    public Component getTableCellRendererComponent(JTable table, Object value,
            boolean isSelected, boolean hasFocus, int row, int column) {

        if (value instanceof ImageIcon) {
            // Si el valor es una imagen, crea un JLabel para mostrarla
            JLabel label = new JLabel((ImageIcon) value);
            label.setHorizontalAlignment(JLabel.CENTER);
            return label;
        }

        // De lo contrario, utiliza el renderizador predeterminado
        return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
    }
}
