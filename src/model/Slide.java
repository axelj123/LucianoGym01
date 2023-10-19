/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.SwingUtilities;
import javax.swing.Timer;

/**
 *
 * @author Luis Vidal
 */
public class Slide {
public synchronized  void moverComponente(final Component componente, final int start, final int stop, final int delay, final int increment) {
    if (componente.getX() == start) {
        Timer timer = new Timer(delay, new ActionListener() {
            int currentX = start;

            @Override
            public void actionPerformed(ActionEvent e) {
                if (currentX != stop) {
                    currentX += increment;
                    SwingUtilities.invokeLater(() -> {
                        componente.setLocation(currentX, componente.getY());
                    });
                } else {
                    ((Timer) e.getSource()).stop();
                }
            }
        });
        timer.start();
    }

}
}