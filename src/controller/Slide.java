/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 *
 * @author Luis Vidal
 */
public class Slide {
    
    public void jLabelXIzquierda(final int start, final int stop, final int delay, final int increment, final JLabel jLabel)
  {
    if (jLabel.getX() == start) {
      new Thread()
      {
        public void run()
        {
          while (jLabel.getX() > stop) {
            for (int i = start; i >= stop; i -= increment) {
              try
              {
                Thread.sleep(delay);
                jLabel.setLocation(i, jLabel.getY());
              }
              catch (InterruptedException e)
              {
                System.out.println("Error Thread Interrupted: " + e);
              }
            }
          }
          jLabel.setLocation(stop, jLabel.getY());
        }
      }.start();
    }
  }
  
  public void jLabelXDerecha(final int start, final int stop, final int delay, final int increment, final JLabel jLabel)
  {
    if (jLabel.getX() == start) {
      new Thread()
      {
        public void run()
        {
          while (jLabel.getX() <= start) {
            for (int i = start; i <= stop; i += increment) {
              try
              {
                Thread.sleep(delay);
                
                jLabel.setLocation(i, jLabel.getY());
              }
              catch (InterruptedException e)
              {
                System.out.println("Error Thread Interrupted: " + e);
              }
            }
          }
          jLabel.setLocation(stop, jLabel.getY());
        }
      }.start();
    }
  }
  
  public void jPanelXDerecha(final int start, final int stop, final int delay, final int increment, final JPanel JPanel) {
        if (JPanel.getX() == start) {
            new Thread() {
                public void run() {
                    while (JPanel.getX() <= start) {
                        for (int i = start; i <= stop; i += increment) {
                            try {
                                Thread.sleep(delay);

                                JPanel.setLocation(i, JPanel.getY());
                            } catch (InterruptedException e) {
                                System.out.println("Error Thread Interrupted: " + e);
                            }
                        }
                    }
                    JPanel.setLocation(stop, JPanel.getY());
                }
            }.start();
        }
    }
  
  public void jPanelXIzquierda(final int start, final int stop, final int delay, final int increment, final JPanel JPanel) {
        if (JPanel.getX() == start) {
            new Thread() {
                public void run() {
                    while (JPanel.getX() > stop) {
                        for (int i = start; i >= stop; i -= increment) {
                            try {
                                Thread.sleep(delay);
                                JPanel.setLocation(i, JPanel.getY());
                            } catch (InterruptedException e) {
                                System.out.println("Error Thread Interrupted: " + e);
                            }
                        }
                    }
                    JPanel.setLocation(stop, JPanel.getY());
                }
            }.start();
        }
    }
  
  //-----> swing arriba y abajo
  
  public void jPanelYArriba(final int start, final int stop, final int delay, final int increment, final JPanel jPabel)
  {
    if (jPabel.getY() == start) {
      new Thread()
      {
        public void run()
        {
          while (jPabel.getY() > stop) {
            for (int i = start; i >= stop; i -= increment) {
              try
              {
                Thread.sleep(delay);
                jPabel.setLocation(jPabel.getX(), i);
              }
              catch (InterruptedException e)
              {
                System.out.println("Error Thread Interrupted: " + e);
              }
            }
          }
          jPabel.setLocation(jPabel.getX(), stop);
        }
      }.start();
    }
  }
  
public void LabelAbajo(final int startY, final int stopY, final int delay, final int increment, final JLabel label) {
    new Thread(() -> {
        int y = startY;
        while (y <= stopY) {
            try {
                Thread.sleep(delay);
                label.setLocation(label.getX(), y);
                y += increment;
            } catch (InterruptedException e) {
                System.out.println("Error Thread Interrupted: " + e);
            }
        }
        label.setLocation(label.getX(), stopY); // Establecer la posición final
    }).start();
}

    
}
