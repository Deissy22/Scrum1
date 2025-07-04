
package dao;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import modelo.Persona;

public class PersonaDAO {
    
    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    
    //Insertar persona
    public int registrarPersona(Persona persona){
        int idGenerado = -1;
        String sql = "INSERT INTO persona (tipo_documento, numero_documento, nombres, apellidos, "
                + "correo_personal, telefono_celular, genero, fecha_nacimiento) VALUES (?,?,?,?,?,?,?,?)";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, persona.getTipoDocumento());
            ps.setString(2, persona.getNumeroDocumento());
            ps.setString(3, persona.getNombres());
            ps.setString(4, persona.getApellidos());
            ps.setString(5, persona.getCorreoPersonal());
            ps.setString(6, persona.getTelefonoCelular());
            ps.setString(7, persona.getGenero());
            ps.setString(8, persona.getFechaNacimiento());
            
            int filasAfectadas = ps.executeUpdate();
            if(filasAfectadas > 0){
                rs = ps.getGeneratedKeys();
                if (rs.next()){
                    idGenerado = rs.getInt(1);
                }
            }
        }catch(SQLException e){
            System.out.println("Error al registrar persona: " + e.getMessage());  
            }
        return idGenerado; 
    }
  
    //Listar personas
    public List<Persona> listarPersonas(){
        List<Persona> lista = new ArrayList<>();
        String sql = "SELECT * FROM persona";
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                Persona p = new Persona(
                        rs.getInt("id_persona"),
                        rs.getString("tipo_documento"),
                        rs.getString("numero_documento"),
                        rs.getString("nombres"),
                        rs.getString("apellidos"),
                        rs.getString("correo_personal"),
                        rs.getString("telefono_celular"),
                        rs.getString("genero"),
                        rs.getString("fecha_nacimiento")
                );
                lista.add(p);
            }
            
        }catch(SQLException e){
            System.out.println("Error al listar personas: " + e.getMessage());
        }
        return lista;
    }
    
    //Buscar persona por id
    public Persona buscarPorId(int id){
        Persona persona = null;
        String sql = "SELECT * FROM persona WHERE id_persona = ?";
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if(rs.next()){
                persona = new Persona(
                    rs.getInt("id_persona"),
                    rs.getString("tipo_documento"),
                    rs.getString("numero_documento"),
                    rs.getString("nombres"),
                    rs.getString("apellidos"),
                    rs.getString("correo_personal"),
                    rs.getString("telefono_celular"),
                    rs.getString("genero"),
                    rs.getString("fecha_nacimiento")
                        );
            }   
        }catch(SQLException e){
            System.out.println("Error al buscar persona por ID: " + e.getMessage());
        }
        return persona;
    }
        
    //Actuliazar persona
    public boolean actualizarPersona(Persona persona){
        String sql = "UPDATE persona SET tipo_documento=?,numero_documento=?, nombres=?, "
                + "apellidos=?, correo_personal=?, telefono_celular=?, genero=?, fecha_nacimiento=? WHERE id_persona=?";
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, persona.getTipoDocumento());
            ps.setString(2, persona.getNumeroDocumento());
            ps.setString(3, persona.getNombres());
            ps.setString(4, persona.getApellidos());
            ps.setString(5, persona.getCorreoPersonal());
            ps.setString(6, persona.getTelefonoCelular());
            ps.setString(7, persona.getGenero());
            ps.setString(8, persona.getFechaNacimiento());
            ps.setInt(9, persona.getIdPersona());

            return ps.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println("Error al actualizar persona" + e.getMessage());
            return false;
        }   
    }
    
    //Eliminar persona
    public boolean eliminarPersona(int id){
        String sql = "DELETE FROM persona WHERE id_persona=?";
        try{
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println("Error al eliminar persona: " + e.getMessage());
            return false;
        }
    }  
}
    

