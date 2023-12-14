package controller.Estados;

import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import model.ClienteDAO;

public class TableActionCellRenderDeuda extends DefaultTableCellRenderer {

    ClienteDAO c = new ClienteDAO();

    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        EstadoDeuda panel = new EstadoDeuda();
        
        DefaultTableModel model = (DefaultTableModel) table.getModel();
        int rowIndex = table.convertRowIndexToModel(row);
        Object idCliente = model.getValueAt(rowIndex, 0);
        int idClienteInt = Integer.parseInt(idCliente.toString());

        boolean tieneDeuda = c.clienteTieneDeuda(idClienteInt);

        if (tieneDeuda) {
            panel.panel1.setBackground(Color.red);
            panel.jLabel1.setText("CON DEUDA");
        } else {
            panel.panel1.setBackground(Color.GREEN);
            panel.jLabel1.setText("SIN DEUDA");
        }

        // Configurar el fondo de la celda según la selección
        if (isSelected) {
            panel.setBackground(new Color(33, 103, 150));
        } else {
            if (row % 2 == 0) {
                panel.setBackground(new Color(255, 255, 255)); // Fondo para filas pares
            } else {
                panel.setBackground(new Color(200, 200, 200)); // Fondo para filas impares
            }
        }

        return panel;
    }
}

