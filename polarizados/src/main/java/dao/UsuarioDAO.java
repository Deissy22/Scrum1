package dao;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Persona;
import modelo.Usuario;

public class UsuarioDAO {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    //Validacion de usuario al momento de hacer login
    public Usuario validarLogin(String correo, String password) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE correo = ? AND password =?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getInt("fk_id_persona"),
                        rs.getString("correo"),
                        rs.getString("password"),
                        rs.getString("rol")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error validarLogin" + e.getMessage());

        }
        return usuario;
    }

    //Insertar Usuarios
    public boolean insertarUsuario(Usuario u) {
        String sql = "INSERT INTO usuario (fk_id_persona, correo, password, rol) VALUES (?, ?, ?, ?)";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, u.getIdPersona());
            ps.setString(2, u.getCorreo());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar usuario: " + e.getMessage());
            return false;
        }
    }

    //Insertar Clientes
    public boolean insertarCliente(Usuario u) {
        String sql = "INSERT INTO usuario (fk_id_persona, rol) VALUES (?, ?)";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, u.getIdPersona());
            ps.setString(2, "C");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar cliente: " + e.getMessage());
            return false;
        }
    }

    //Listar todos los usuarios (para rol administrador)
    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getInt("fk_id_persona"),
                        rs.getString("correo"),
                        rs.getString("password"),
                        rs.getString("rol")
                );
                lista.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error listar ususarios: " + e.getMessage());
        }
        return lista;
    }

    //Listar solo clientes (para el rol vendedor)
    public List<Usuario> listarClientes() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario WHERE rol = 'C'";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getInt("fk_id_persona"),
                        rs.getString("correo"),
                        rs.getString("password"),
                        rs.getString("rol")
                );
                lista.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error listar clientes: " + e.getMessage());
        }
        return lista;
    }

    //Buscar usuario por id_persona
    public Usuario buscarIdPersona(int idPersona) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE fk_id_persona = ?";

        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idPersona);
            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getInt("fk_id_persona"),
                        rs.getString("correo"),
                        rs.getString("password"),
                        rs.getString("rol")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar usuario por id_persona" + e.getMessage());
        }
        return usuario;
    }

    //Eliminar usuario
    public boolean eliminar(int idPersona) {
        String sql = "DELETE FROM usuario WHERE fk_id_persona=?";

        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idPersona);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error eliminar usuario: " + e.getMessage());
            return false;
        }
    }

    //Actualizar usuario
    public boolean actualizar(Usuario u) {
        String sql = "UPDATE usuario SET correo = ?, password = ?, rol = ? WHERE fk_id_persona = ?";
        try {
            con = new Conexion().getConexion();
            ps = con.prepareStatement(sql);

            if ("C".equals(u.getRol())) {
                ps.setString(1, null);
                ps.setString(2, null);
            } else {
                ps.setString(1, u.getCorreo());
                ps.setString(2, u.getPassword());
            }

            ps.setString(3, u.getRol());
            ps.setInt(4, u.getIdPersona());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error actualizar usuario: " + e.getMessage());
            return false;
        }
    }
    
    public List<Usuario> buscarUsuariosMulticriterio(String apellidos, String rol) {
    List<Usuario> lista = new ArrayList<>();
    String sql = "SELECT u.*, p.* FROM usuario u " +
                 "JOIN persona p ON u.fk_id_persona = p.id_persona " +
                 "WHERE 1=1 ";

    if (apellidos != null && !apellidos.isEmpty()) {
        sql += "AND p.apellidos LIKE ? ";
    }
    if (rol != null && !rol.isEmpty()) {
        sql += "AND u.rol = ? ";
    }

    try {
        con = new Conexion().getConexion();
        ps = con.prepareStatement(sql);

        int index = 1;
        if (apellidos != null && !apellidos.isEmpty()) {
            ps.setString(index++, "%" + apellidos + "%");
        }
        if (rol != null && !rol.isEmpty()) {
            ps.setString(index++, rol);
        }

        rs = ps.executeQuery();

        while (rs.next()) {
            Usuario u = new Usuario();
            u.setIdUsuario(rs.getInt("id_usuario"));
            u.setIdPersona(rs.getInt("fk_id_persona"));
            u.setCorreo(rs.getString("correo"));
            u.setPassword(rs.getString("password"));
            u.setRol(rs.getString("rol"));

            // Persona cargada desde el mismo ResultSet (por si deseas usarla)
            Persona p = new Persona();
            p.setIdPersona(rs.getInt("id_persona"));
            p.setTipoDocumento(rs.getString("tipo_documento"));
            p.setNumeroDocumento(rs.getString("numero_documento"));
            p.setNombres(rs.getString("nombres"));
            p.setApellidos(rs.getString("apellidos"));
            p.setCorreoPersonal(rs.getString("correo_personal"));
            p.setTelefonoCelular(rs.getString("telefono_celular"));
            p.setGenero(rs.getString("genero"));
            p.setFechaNacimiento(rs.getString("fecha_nacimiento"));

            u.setPersona(p);
            lista.add(u);
        }

    } catch (SQLException e) {
        System.out.println("Error en búsqueda multicriterio: " + e.getMessage());
    }

    return lista;
}

}
