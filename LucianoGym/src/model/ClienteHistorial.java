/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author User
 */
public class ClienteHistorial {
       private int idCliente;
    private double precioMembresia;
    private double montoPagado;
    private Date fechaInicio;
    private Date fechaFin;

    public ClienteHistorial() {
    }

    public ClienteHistorial(int idCliente, double precioMembresia, double montoPagado, Date fechaInicio, Date fechaFin) {
        this.idCliente = idCliente;
        this.precioMembresia = precioMembresia;
        this.montoPagado = montoPagado;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public double getPrecioMembresia() {
        return precioMembresia;
    }

    public void setPrecioMembresia(double precioMembresia) {
        this.precioMembresia = precioMembresia;
    }

    public double getMontoPagado() {
        return montoPagado;
    }

    public void setMontoPagado(double montoPagado) {
        this.montoPagado = montoPagado;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    
}
