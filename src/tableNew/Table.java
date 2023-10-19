package tableNew;

import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

public class Table extends JTable {

    public Table() {
        setShowHorizontalLines(true);
        setGridColor(new Color(230, 230, 230));
        setRowHeight(40);
        getTableHeader().setReorderingAllowed(false);

        getTableHeader().setDefaultRenderer(new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable jtable, Object o, boolean bln, boolean bln1, int i, int i1) {
                TableHeader header = new TableHeader(o + "");
                return header;
            }
        });

        setDefaultRenderer(Object.class, new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable jtable, Object o, boolean isSelected, boolean hasFocus, int row, int column) {
                Component com = super.getTableCellRendererComponent(jtable, o, isSelected, hasFocus, row, column);

                // Configura el color de fondo y del texto para toda la fila
                if (isSelected) {
                    com.setBackground(new Color(33, 103, 150)); // Color de fondo para celdas seleccionadas
                    com.setForeground(Color.WHITE); // Color del texto para celdas seleccionadas
                } else {
                    if (row % 2 == 0) {
                        com.setBackground(new Color(255, 255, 255)); // Color de fondo para filas pares
                    } else {
                        com.setBackground(new Color(200, 200, 200)); // Color de fondo para filas impares
                    }
                    com.setForeground(new Color(0, 0, 0)); // Color del texto para celdas no seleccionadas
                }

                com.setFont(com.getFont().deriveFont(Font.BOLD, 12));
                setBorder(new EmptyBorder(0, 5, 0, 5));

                return com;
            }
        });
    }

    public void addRow(Object[] row) {
        DefaultTableModel model = (DefaultTableModel) getModel();
        model.insertRow(0, row);
    }

    public void fixTable(javax.swing.JScrollPane scroll) {
        scroll.setBorder(null);
                scroll.setVerticalScrollBar(new tableDark.ScrollBarCustom());

        scroll.getVerticalScrollBar().setBackground(new Color(0, 0, 47));
        scroll.getViewport().setBackground(new Color(0, 0, 47));
        javax.swing.JPanel p = new javax.swing.JPanel();
        p.setBackground(new Color(0, 0, 47));
        scroll.setCorner(javax.swing.JScrollPane.UPPER_RIGHT_CORNER, p);
    }
}

