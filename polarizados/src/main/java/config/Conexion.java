package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private Connection conexion = null;

    public Connection getConexion() {
        try {
            // Carga del driver explícita por si no se autoconecta (opcional)
            Class.forName("com.mysql.cj.jdbc.Driver");  //FUERZA A CARGAR EL DRIVER PARA LA BD

            String url = "jdbc:mysql://localhost:3306/polarizadosjava";
            String usuario = "root";
            String clave = "";

            conexion = DriverManager.getConnection(url, usuario, clave);
            System.out.println("Conexión exitosa a la base de datos");
            return conexion;

        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver de MySQL: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error de conexión SQL: " + e.getMessage());
        }
        return null;
    }
}
