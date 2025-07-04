package dao;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Servicio;

public class ServicioDAO {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    // Insertar nuevo servicio
    public boolean insertar(Servicio s) {
        String sql = "INSERT INTO servicio (nombre_servicio, descripcion, precio) VALUES (?, ?, ?)";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, s.getNombreServicio());
            ps.setString(2, s.getDescripcion());
            ps.setDouble(3, s.getPrecio());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar servicio: " + e.getMessage());
            return false;
        }
    }

    // Listar todos los servicios
    public List<Servicio> listar() {
        List<Servicio> lista = new ArrayList<>();
        String sql = "SELECT * FROM servicio";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Servicio s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setNombreServicio(rs.getString("nombre_servicio"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
                lista.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar servicios: " + e.getMessage());
        }
        return lista;
    }

    // Buscar servicio por ID
    public Servicio buscarPorId(int id) {
        String sql = "SELECT * FROM servicio WHERE id_servicio = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Servicio(
                        rs.getInt("id_servicio"),
                        rs.getString("nombre_servicio"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar servicio: " + e.getMessage());
        }
        return null;
    }

    // Actualizar servicio
    public boolean actualizar(Servicio s) {
        String sql = "UPDATE servicio SET nombre_servicio = ?, descripcion = ?, precio = ? WHERE id_servicio = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, s.getNombreServicio());
            ps.setString(2, s.getDescripcion());
            ps.setDouble(3, s.getPrecio());
            ps.setInt(4, s.getIdServicio());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar servicio: " + e.getMessage());
            return false;
        }
    }

    // Eliminar servicio
    public boolean eliminar(int id) {
        String sql = "DELETE FROM servicio WHERE id_servicio = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar servicio: " + e.getMessage());
            return false;
        }
    }
}
