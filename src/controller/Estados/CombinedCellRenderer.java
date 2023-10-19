
package controller.Estados;

import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

public class CombinedCellRenderer extends DefaultTableCellRenderer {
    private final TableActionCellRenderDeuda estadoDeudaRenderer = new TableActionCellRenderDeuda();
    private final TableActionCellRenderDeudaBackg backgroundRenderer = new TableActionCellRenderDeudaBackg();

    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        // Renderiza el estado de deuda
        Component estadoDeudaComponent = estadoDeudaRenderer.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);

        // Renderiza el fondo de la celda
        Component backgroundComponent = backgroundRenderer.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);

        // Combina ambos componentes
        estadoDeudaComponent.setBackground(backgroundComponent.getBackground());
        return estadoDeudaComponent;
    }
}
