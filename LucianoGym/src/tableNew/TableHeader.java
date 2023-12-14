package tableNew;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JLabel;
import javax.swing.border.EmptyBorder;

public class TableHeader extends JLabel {
    private boolean mouseOver = false;

    public TableHeader(String text) {
        super(text);
        setOpaque(true);
        setBackground(new Color(21,21,21));
        setFont(new Font("sansserif", 1, 12));
        setForeground(new Color(255, 255, 255));
        setBorder(new EmptyBorder(10, 5, 10, 5));
    // Agregar un MouseListener para detectar cuando el mouse entra o sale del componente
        addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                mouseOver = true;
                repaint();
            }

            @Override
            public void mouseExited(MouseEvent e) {
                mouseOver = false;
                repaint();
            }
        });
    }
    

    @Override
    protected void paintComponent(Graphics grphcs) {
        super.paintComponent(grphcs);
        grphcs.setColor(new Color(230, 230, 230));
        grphcs.drawLine(0, getHeight() - 1, getWidth(), getHeight() - 1);
    }
}
