
package controller.Estados;

import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

public class TableActionCellRenderDeudaBackg extends DefaultTableCellRenderer {

   @Override
public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
    Component component = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);

    // Configura el color del fondo de la celda para filas pares/impares
    if (row % 2 == 0) {
        component.setBackground(new Color(255, 255, 255)); // Color de fondo para filas pares
    } else {
        component.setBackground(new Color(200, 200, 200)); // Color de fondo para filas impares
    }

    // Configura el color de fondo cuando la fila está seleccionada
    if (isSelected) {
        component.setBackground(new Color(33, 103, 150)); // Color de fondo cuando la fila está seleccionada
    }

    return component;
}

}