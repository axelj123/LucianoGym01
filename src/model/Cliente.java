/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

public class Cliente {

    int codigo;
    String Nombres;
    String Apellidos;
    int telefono;
    int dni;
    Date FechaNacimiento;
    double PrecioMembresia;
    double MontoPagado;
    double MontoRestante;
    Date FechaInicio;
    Date FechaFin;
    byte [] foto;

    public Cliente() {
    }

    public Cliente(int codigo, String Nombres, String Apellidos, int telefono, int dni,
            Date FechaNacimiento, double PrecioMembresia, double MontoPagado,
            double MontoRestante, Date FechaInicio, Date FechaFin, byte [] foto) {
        this.codigo = codigo;
        this.Nombres = Nombres;
        this.Apellidos = Apellidos;
        this.telefono = telefono;
        this.dni = dni;
        this.FechaNacimiento = FechaNacimiento;
        this.PrecioMembresia = PrecioMembresia;
        this.MontoPagado = MontoPagado;
        this.MontoRestante = MontoRestante;
        this.FechaInicio = FechaInicio;
        this.FechaFin = FechaFin;
        this.foto=foto;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String Nombres) {
        this.Nombres = Nombres;
    }

    public String getApellidos() {
        return Apellidos;
    }

    public void setApellidos(String Apellidos) {
        this.Apellidos = Apellidos;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public Date getFechaNacimiento() {
        return FechaNacimiento;
    }

    public void setFechaNacimiento(Date FechaNacimiento) {
        this.FechaNacimiento = FechaNacimiento;
    }

    public double getPrecioMembresia() {
        return PrecioMembresia;
    }

    public void setPrecioMembresia(double PrecioMembresia) {
        this.PrecioMembresia = PrecioMembresia;
    }

    public double getMontoPagado() {
        return MontoPagado;
    }

    public void setMontoPagado(double MontoPagado) {
        this.MontoPagado = MontoPagado;
    }

    public double getMontoRestante() {
        return MontoRestante;
    }

    public void setMontoRestante(double MontoRestante) {
        this.MontoRestante = MontoRestante;
    }

    public Date getFechaInicio() {
        return FechaInicio;
    }

    public void setFechaInicio(Date FechaInicio) {
        this.FechaInicio = FechaInicio;
    }

    public Date getFechaFin() {
        return FechaFin;
    }

    public void setFechaFin(Date FechaFin) {
        this.FechaFin = FechaFin;
    }
  public double calcularMontoRestante() {
    return getPrecioMembresia() - getMontoPagado();
}
    
}