package dao;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.ProductoServicio;

public class ProductoServicioDAO {
    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    // Insertar relación producto-servicio
    public boolean insertar(ProductoServicio psr) {
        String sql = "INSERT INTO producto_servicio (id_servicio, id_producto, cantidad) VALUES (?, ?, ?)";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, psr.getIdServicio());
            ps.setInt(2, psr.getIdProducto());
            ps.setInt(3, psr.getCantidad());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar producto-servicio: " + e.getMessage());
            return false;
        }
    }

    // Listar todas las relaciones
    public List<ProductoServicio> listar() {
        List<ProductoServicio> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto_servicio";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductoServicio psr = new ProductoServicio();
                psr.setIdProdServ(rs.getInt("id_prod_serv"));
                psr.setIdServicio(rs.getInt("id_servicio"));
                psr.setIdProducto(rs.getInt("id_producto"));
                psr.setCantidad(rs.getInt("cantidad"));
                lista.add(psr);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar producto-servicio: " + e.getMessage());
        }
        return lista;
    }

    // Buscar por ID
    public ProductoServicio buscarPorId(int id) {
        String sql = "SELECT * FROM producto_servicio WHERE id_prod_serv = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductoServicio(
                    rs.getInt("id_prod_serv"),
                    rs.getInt("id_servicio"),
                    rs.getInt("id_producto"),
                    rs.getInt("cantidad")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar producto-servicio: " + e.getMessage());
        }
        return null;
    }

    // Actualizar
    public boolean actualizar(ProductoServicio psr) {
        String sql = "UPDATE producto_servicio SET id_servicio = ?, id_producto = ?, cantidad = ? WHERE id_prod_serv = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, psr.getIdServicio());
            ps.setInt(2, psr.getIdProducto());
            ps.setInt(3, psr.getCantidad());
            ps.setInt(4, psr.getIdProdServ());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar producto-servicio: " + e.getMessage());
            return false;
        }
    }

    // Eliminar
    public boolean eliminar(int id) {
        String sql = "DELETE FROM producto_servicio WHERE id_prod_serv = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar producto-servicio: " + e.getMessage());
            return false;
        }
    }
    
}
