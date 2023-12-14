/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */
public class RegistroProductos {

    private int codigo;
    private String nombre;
    private String descripcion;
    private int categoria;
    private byte[] imagenProducto;
    private int stock;
    private double precio;
    private int stockTotalScoops;

    public RegistroProductos() {
    }

    public RegistroProductos(int codigo, String nombre, String descripcion, int categoria, byte[] imagenProducto, int stock, double precio, int stockTotalScoops) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.imagenProducto = imagenProducto;
        this.stock = stock;
        this.precio = precio;
        this.stockTotalScoops = stockTotalScoops;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public byte[] getImagenProducto() {
        return imagenProducto;
    }

    public void setImagenProducto(byte[] imagenProducto) {
        this.imagenProducto = imagenProducto;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStockTotalScoops() {
        return stockTotalScoops;
    }

    public void setStockTotalScoops(int stockTotalScoops) {
        this.stockTotalScoops = stockTotalScoops;
    }

    

}
