/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class StockPorcion {

    private int ProductoId;
    private int cantidadEnStock;
    private int ScoopsPorPote;

    public StockPorcion() {
    }

    public StockPorcion(int ProductoId, int cantidadEnStock, int ScoopsPorPote) {
        this.ProductoId = ProductoId;
        this.cantidadEnStock = cantidadEnStock;
        this.ScoopsPorPote = ScoopsPorPote;
    }

    public int getProductoId() {
        return ProductoId;
    }

    public void setProductoId(int ProductoId) {
        this.ProductoId = ProductoId;
    }

    public int getCantidadEnStock() {
        return cantidadEnStock;
    }

    public void setCantidadEnStock(int cantidadEnStock) {
        this.cantidadEnStock = cantidadEnStock;
    }

    public int getScoopsPorPote() {
        return ScoopsPorPote;
    }

    public void setScoopsPorPote(int ScoopsPorPote) {
        this.ScoopsPorPote = ScoopsPorPote;
    }

}
