/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

/**
 *
 * @author User
 */
public class TableActionCellRenderPagar extends DefaultTableCellRenderer{

  @Override
public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
    Component comp = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column); 
    PanelActionPagar action = new PanelActionPagar();

  if (!isSelected) {
        if (row % 2 == 0) {
                action.setBackground(new Color(255, 255, 255));
        } else {
                action.setBackground(new Color(200, 200, 200));
        }
    } else {
        action.setBackground(table.getSelectionBackground());
    }

    return action;
}

    
}
