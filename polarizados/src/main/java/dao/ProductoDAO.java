
package dao;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import modelo.Producto;

public class ProductoDAO {
    
    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    
    //Insertar producto
    public boolean insertar(Producto p){
        String sql = "INSERT INTO producto (nombre, descripcion) VALUES (?, ?)";
        
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            return ps.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println("Error al insertar producto: " + e.getMessage());
            return false;
        }
    }
    
    //Listar todos los productos
    public List<Producto> listar(){
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto";
        
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while(rs.next()){
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                lista.add(p);   
            }     
        }catch(SQLException e){
            System.out.println("Error al listar productos: " + e.getMessage());
        }
        return lista;
    }
    
    //Buscar por ID
    public Producto buscarPorId(int id){
        String sql = "SELECT * FROM producto WHERE id_producto = ?";
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()){
                return new Producto(
                rs.getInt("id_producto"),
                rs.getString("nombre"),
                rs.getString("descripcion")
                );
            }
        }catch(SQLException e){
            System.out.println("Error al buscar producto por ID: " + e.getMessage());
        }
        return null;
    }
    
    //Actualizar prodcuto
    public boolean actualizar(Producto p){
        String sql = "UPDATE producto SET nombre = ?, descripcion = ? WHERE id_producto = ?";
        try{
           con = new Conexion().getConexion();
           ps = con.prepareStatement(sql);
           ps.setString(1, p.getNombre());
           ps.setString(2, p.getDescripcion());
           ps.setInt(3, p.getIdProducto());
           return ps.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println("Error al actualizar prodcuto: " + e.getMessage());
            return false;
        }
    }
    
    //Eliminar producto
    public boolean eliminar(int id){
        String sql = "DELETE FROM producto WHERE id_producto = ?";
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println("Error al eliminar prodcuto: " + e.getMessage());
            return false;
        }
    }
}
