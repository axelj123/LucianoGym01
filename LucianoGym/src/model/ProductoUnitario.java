/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


public class ProductoUnitario {
    private int productoID;

  
    private String nombre;
private String descripcion;
private String CategoriaID;
private double precio;
private int stock;
private byte [] fotoProducto;

    public ProductoUnitario() {
    }

    public int getProductoID() {
        return productoID;
    }

    public void setProductoID(int productoID) {
        this.productoID = productoID;
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

    public String getCategoriaID() {
        return CategoriaID;
    }

    public void setCategoriaID(String CategoriaID) {
        this.CategoriaID = CategoriaID;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public byte[] getFotoProducto() {
        return fotoProducto;
    }

    public void setFotoProducto(byte[] fotoProducto) {
        this.fotoProducto = fotoProducto;
    }

    public ProductoUnitario(int productoID, String nombre, String descripcion, String CategoriaID, double precio, int stock, byte[] fotoProducto) {
        this.productoID = productoID;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.CategoriaID = CategoriaID;
        this.precio = precio;
        this.stock = stock;
        this.fotoProducto = fotoProducto;
    }

   

}
