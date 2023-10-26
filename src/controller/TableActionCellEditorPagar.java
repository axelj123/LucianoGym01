/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.awt.Component;
import javax.swing.DefaultCellEditor;
import javax.swing.JCheckBox;
import javax.swing.JTable;

/**
 *
 * @author User
 */
public class TableActionCellEditorPagar extends DefaultCellEditor {

    private TableActionEventPagos event;
    
    public TableActionCellEditorPagar(TableActionEventPagos event) {
        super(new JCheckBox());
        this.event=event;
    }

    @Override
    public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected, int row, int column) {
        PanelActionPagar action = new PanelActionPagar();
        action.iniEvent(event, row);
        action.setBackground(table.getSelectionBackground());
        return action;
    }

}
