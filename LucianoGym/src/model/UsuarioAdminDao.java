package model;

import conexionBD.conexion;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

public class UsuarioAdminDao {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private conexion cn = new conexion();

    private byte[] generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return salt;
    }

    private String hashSHA256(String input, byte[] salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hash = md.digest(input.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = String.format("%02x", b);
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            throw new RuntimeException("Error al hashear la contraseña.");
        }
    }

    public boolean registrarUsuario(String usuario, String contraseña) {
        try {
            // Genera un salt único para este usuario
            byte[] salt = generateSalt();

            // Combina la contraseña con la sal y hashea la contraseña
            String contraseñaHash = hashSHA256(contraseña, salt);

            // Inserta el usuario en la base de datos
            String sql = "INSERT INTO UsuarioAdmin (Usuario, ContraseñaHash, Sal) VALUES (?, ?, ?)";
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, contraseñaHash);
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
            rs = ps.executeQuery();

            if (rs.next()) {
                byte[] contraseñaAlmacenada = rs.getBytes("ContraseñaHash");
                byte[] salt = rs.getBytes("Sal");

                // Combina la contraseña ingresada con la sal almacenada y hashea la contraseña
                String contraseñaIngresadaHash = hashSHA256(contraseña, salt);

                // Convierte los hashes a bytes para comparación segura
                byte[] hashContraseñaIngresada = contraseñaIngresadaHash.getBytes();
                byte[] hashContraseñaAlmacenada = Arrays.copyOf(contraseñaAlmacenada, contraseñaAlmacenada.length);

                // Compara los hashes de forma segura
                return MessageDigest.isEqual(hashContraseñaIngresada, hashContraseñaAlmacenada);
            } else {
                return false; // Usuario no encontrado
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error al iniciar sesión.");
        }

    }

    public boolean iniciarSesionNormal(String usuario, String pass) {
        try {
            String sql = "SELECT contraseña FROM login WHERE usuario=? ";
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                String password = rs.getString("contraseña");
                return password.equals(pass);

            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error al iniciar sesión");
        }

    }
}
