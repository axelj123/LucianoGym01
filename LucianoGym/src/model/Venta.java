/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author User
 */
public class Venta {
    int VentaID;
    Date fecha;
  double  total ;

    public Venta() {
    }

    public Venta(int VentaID, Date fecha, double total) {
        this.VentaID = VentaID;
        this.fecha = fecha;
        this.total = total;
    }

    public int getVentaID() {
        return VentaID;
    }

    public void setVentaID(int VentaID) {
        this.VentaID = VentaID;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
  
    
}
