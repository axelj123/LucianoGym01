package model;

import java.awt.Component;
import java.awt.event.MouseEvent;
public class Mover {
      private int xMouse;
    private int yMouse;
      
  //formularioLogin y Inicio tienen mismo jPanel
    public void PanelMousePressed(MouseEvent evt) {
        xMouse = evt.getX();
        yMouse = evt.getY();
    }

    public void PanelMouseDragged(MouseEvent evt, Component componente) {
        int Y = evt.getYOnScreen();
        int X = evt.getXOnScreen();
        componente.setLocation(X - xMouse, Y - yMouse);
    }
    
}
       

