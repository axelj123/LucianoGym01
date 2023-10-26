/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class UsuarioAdmin {
private int idUsuario;
    private String usuario;
    private byte[] contraseñaHash;
    private byte[] sal;

    public UsuarioAdmin() {
    }

    public UsuarioAdmin(int idUsuario, String usuario, byte[] contraseñaHash, byte[] sal) {
        this.idUsuario = idUsuario;
        this.usuario = usuario;
        this.contraseñaHash = contraseñaHash;
        this.sal = sal;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public byte[] getContraseñaHash() {
        return contraseñaHash;
    }

    public void setContraseñaHash(byte[] contraseñaHash) {
        this.contraseñaHash = contraseñaHash;
    }

    public byte[] getSal() {
        return sal;
    }

    public void setSal(byte[] sal) {
        this.sal = sal;
    }

    
}

