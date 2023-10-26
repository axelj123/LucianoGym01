/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package view;

import conexionBD.conexion;
import java.nio.ByteBuffer;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Base64;
import model.UsuarioAdmin;
import model.UsuarioAdminDao;

public class prueba {

    conexion cn = new conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

 private byte[] generateSalt() {
        // Genera un salt simple basado en el tiempo actual
        long currentTimeMillis = System.currentTimeMillis();
        byte[] salt = new byte[8];
        for (int i = 0; i < 8; i++) {
            salt[i] = (byte) (currentTimeMillis >>> (i * 8));
        }
        return salt;
    }
    public boolean registrarUsuario(String usuario, String contraseña) {
        try {
            // Genera un salt único para este usuario
            byte[] salt = generateSalt();

            // Combina la contraseña con la sal
            String contraseñaConSal = contraseña + new String(salt);

            // Hashea la contraseña con hashCode()
            int contraseñaHash = contraseñaConSal.hashCode();

            // Inserta el usuario en la base de datos
            String sql = "INSERT INTO UsuarioAdmin (Usuario, ContraseñaHash, Sal) VALUES (?, ?, ?)";
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setInt(2, contraseñaHash);
            ps.setBytes(3, salt);

            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error al registrar el usuario.");
        }
    }

    public boolean iniciarSesion(String usuario, String contraseña) {
    try {
        // Busca al usuario por nombre de usuario
        String sql = "SELECT ContraseñaHash, Sal FROM UsuarioAdmin WHERE Usuario = ?";
        con = cn.getConexion();
        ps = con.prepareStatement(sql);
        ps.setString(1, usuario);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            byte[] contraseñaAlmacenada = rs.getBytes("ContraseñaHash");
            byte[] salt = rs.getBytes("Sal");

            // Combina la contraseña ingresada con la sal almacenada
            String contraseñaConSalIngresada = contraseña + new String(salt);

            // Hashea la contraseña ingresada con hashCode() y compara
            int contraseñaIngresadaHash = contraseñaConSalIngresada.hashCode();
            
            // Convierte el valor de hash almacenado en bytes
            byte[] contraseñaAlmacenadaBytes = ByteBuffer.allocate(4).putInt(contraseñaIngresadaHash).array();

            // Compara los valores de hash en forma de bytes
            return Arrays.equals(contraseñaAlmacenadaBytes, contraseñaAlmacenada);
        } else {
            return false; // Usuario no encontrado
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw new RuntimeException("Error al iniciar sesión.");
    }
}






   public static void main(String[] args) {
    prueba registro = new prueba();
       UsuarioAdminDao u=new UsuarioAdminDao();
    // Registra un nuevo usuario (comentado después del primer registro)
    // registro.registrarUsuario("usuario1", "password123");

    // Inicia sesión con un usuario existente
    if (u.iniciarSesion("usuario1", "password1232")) {
        System.out.println("Inicio de sesión exitoso");
    } else {
        System.out.println("Inicio de sesión fallido");
    }
}
}


