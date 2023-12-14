/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */
public class DetalleVenta {
    
 private int idDetalleVenta;
    private int ventaId;
    private int productoId;
    private int cantidadVenta;
    private double precioUnitario;
    private String tipoStock;
    private double subTotal;

    public DetalleVenta() {
    }

    public DetalleVenta(int idDetalleVenta, int ventaId, int productoId, int cantidadVenta, double precioUnitario, String tipoStock, double subTotal) {
        this.idDetalleVenta = idDetalleVenta;
        this.ventaId = ventaId;
        this.productoId = productoId;
        this.cantidadVenta = cantidadVenta;
        this.precioUnitario = precioUnitario;
        this.tipoStock = tipoStock;
        this.subTotal = subTotal;
    }

    public int getIdDetalleVenta() {
        return idDetalleVenta;
    }

    public void setIdDetalleVenta(int idDetalleVenta) {
        this.idDetalleVenta = idDetalleVenta;
    }

    public int getVentaId() {
        return ventaId;
    }

    public void setVentaId(int ventaId) {
        this.ventaId = ventaId;
    }

    public int getProductoId() {
        return productoId;
    }

    public void setProductoId(int productoId) {
        this.productoId = productoId;
    }

    public int getCantidadVenta() {
        return cantidadVenta;
    }

    public void setCantidadVenta(int cantidadVenta) {
        this.cantidadVenta = cantidadVenta;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public String getTipoStock() {
        return tipoStock;
    }

    public void setTipoStock(String tipoStock) {
        this.tipoStock = tipoStock;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }
    
    
}
