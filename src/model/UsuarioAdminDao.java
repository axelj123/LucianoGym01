/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import conexionBD.conexion;
import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import javax.swing.JOptionPane;

public class UsuarioAdminDao {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private conexion cn = new conexion();

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
      public boolean autenticarUsuario(String usuario, String contraseña) {
    String sql = "SELECT * FROM LOGIN WHERE usuario = ? AND contraseña = ?";
    try (Connection con = cn.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, usuario);
        ps.setString(2, contraseña);
        try (ResultSet rs = ps.executeQuery()) {
            return rs.next(); // Devuelve true si se encontró un usuario con las credenciales proporcionadas
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return false; // Devuelve false en caso de error o si las credenciales son incorrectas
    }
}


  public boolean iniciarSesion(String usuario, String contraseña){
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
            String contraseñaConSalIngresada = contraseña + new String(salt, "UTF-8");

            // Hashea la contraseña ingresada con hashCode() y compara
            int contraseñaIngresadaHash = contraseñaConSalIngresada.hashCode();
            
            // Convierte el valor de hash almacenado en bytes
            byte[] contraseñaAlmacenadaBytes = ByteBuffer.allocate(4).putInt(contraseñaIngresadaHash).array();

            // Imprime los valores para depurar
            System.out.println("Contraseña almacenada: " + Arrays.toString(contraseñaAlmacenada));
            System.out.println("Contraseña ingresada: " + Arrays.toString(contraseñaAlmacenadaBytes));

            // Compara los valores de hash en forma de bytes
            return Arrays.equals(contraseñaAlmacenadaBytes, contraseñaAlmacenada);
        } else {
            return false; // Usuario no encontrado
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw new RuntimeException("Error al iniciar sesión.");
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
        throw new RuntimeException("Error de codificación al iniciar sesión.");
    }
}

}
