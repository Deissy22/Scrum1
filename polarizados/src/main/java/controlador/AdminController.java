package controlador;

import dao.PersonaDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import modelo.Persona;
import modelo.Usuario;


@WebServlet("/AdminController")
public class AdminController extends HttpServlet {

    PersonaDAO personaDAO = new PersonaDAO();
    UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "dashboard";
        }

        switch (accion) {
            case "nuevoUsuario":
                request.getRequestDispatcher("/vistas/admin/usuarios/crearU.jsp").forward(request, response);
                break;
            case "nuevoCliente":
                request.getRequestDispatcher("/vistas/admin/clientes/crearC.jsp").forward(request, response);
                break;
            case "editar":

                int id = Integer.parseInt(request.getParameter("id_persona"));
                Persona persona = personaDAO.buscarPorId(id);
                Usuario usuario = usuarioDAO.buscarIdPersona(id);

                request.setAttribute("persona", persona);
                request.setAttribute("usuario", usuario);

                if ("C".equals(usuario.getRol())) {
                    request.getRequestDispatcher("/vistas/admin/clientes/editarC.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/vistas/admin/usuarios/editarU.jsp").forward(request, response);
                }

                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id_persona"));
                Usuario usuarioEliminar = usuarioDAO.buscarIdPersona(idEliminar);

                if (usuarioEliminar != null) {
                    String rol = usuarioEliminar.getRol();

                    usuarioDAO.eliminar(idEliminar);
                    personaDAO.eliminarPersona(idEliminar);

                    if ("C".equals(rol)) {
                        response.sendRedirect("AdminController?accion=listarClientes");
                    } else {
                        response.sendRedirect("AdminController?accion=listarUsuarios");
                    }
                } else {
                    //Si no se encontro el usuario
                    response.sendRedirect("vistas/errores/404.jsp");
                }
                break;
            case "listarClientes":
                List<Usuario> clientes = usuarioDAO.listarClientes();
                Map<Integer, Usuario> clienteMap = new HashMap<>();
                List<Persona> personasClientes = new ArrayList<>();
                for (Usuario u : clientes) {
                    clienteMap.put(u.getIdPersona(), u);
                    personasClientes.add(personaDAO.buscarPorId(u.getIdPersona()));
                }
                request.setAttribute("personas", personasClientes);
                request.setAttribute("usuarioMap", clienteMap);
                request.getRequestDispatcher("/vistas/admin/clientes/clientes.jsp").forward(request, response);
                break;
            case "listarUsuarios":
                List<Usuario> usuarios = usuarioDAO.listar();
                Map<Integer, Usuario> usuarioMap = new HashMap<>();
                List<Persona> personasUsuarios = new ArrayList<>();
                for (Usuario u : usuarios) {
                    if (!u.getRol().equals("C")) {
                        usuarioMap.put(u.getIdPersona(), u);
                        personasUsuarios.add(personaDAO.buscarPorId(u.getIdPersona()));
                    }
                }
                System.out.println(personasUsuarios.get(0));
                request.setAttribute("personas", personasUsuarios);
                request.setAttribute("usuarioMap", usuarioMap);
                request.getRequestDispatcher("/vistas/admin/usuarios/usuarios.jsp").forward(request, response);
                break;
            case "buscarUsuarios":
                String apellidos = request.getParameter("apellidos");
                String rol = request.getParameter("rol");

                List<Usuario> usuariosFiltrados = usuarioDAO.buscarUsuariosMulticriterio(apellidos, rol);
                request.setAttribute("usuarios", usuariosFiltrados);
                request.getRequestDispatcher("/vistas/admin/usuarios/reporteUsuarios.jsp").forward(request, response);
                break;
            default:
                request.getRequestDispatcher("/vistas/admin/admin.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id_persona");
        String accion = request.getParameter("accion"); // viene desde el formulario hidden o el path
        String rolForm = request.getParameter("rol");   // puede ser null si no se envía desde el form

        Persona persona = new Persona();
        persona.setTipoDocumento(request.getParameter("tipo_documento"));
        persona.setNumeroDocumento(request.getParameter("numero_documento"));
        persona.setNombres(request.getParameter("nombres"));
        persona.setApellidos(request.getParameter("apellidos"));
        persona.setCorreoPersonal(request.getParameter("correo_personal"));
        persona.setTelefonoCelular(request.getParameter("telefono"));
        persona.setGenero(request.getParameter("genero"));
        persona.setFechaNacimiento(request.getParameter("fecha_nacimiento"));

        boolean exito;

        if (idParam != null && !idParam.isEmpty()) {
            // ACTUALIZACIÓN
            int id = Integer.parseInt(idParam);
            persona.setIdPersona(id);
            exito = personaDAO.actualizarPersona(persona);

            Usuario usuario = usuarioDAO.buscarIdPersona(id);
            if (usuario != null) {
                usuario.setRol(rolForm); // siempre se puede cambiar el rol

                if (!"C".equals(rolForm)) {
                    // Si no es cliente, actualiza credenciales
                    usuario.setCorreo(request.getParameter("correo_acceso"));
                    usuario.setPassword(request.getParameter("password"));
                } else {
                    // Si es cliente, los campos de acceso van en null
                    usuario.setCorreo(null);
                    usuario.setPassword(null);
                }

                exito &= usuarioDAO.actualizar(usuario);
            }
        } else {
            // CREACIÓN
            int idPersona = personaDAO.registrarPersona(persona);
            Usuario usuario = new Usuario();
            usuario.setIdPersona(idPersona);

            if ("nuevoCliente".equals(accion)) {
                usuario.setRol("C");
                exito = usuarioDAO.insertarCliente(usuario); // SOLO INSERTA ROL 'C'
                rolForm = "C"; // para la redirección final
            } else if (rolForm != null && !rolForm.isEmpty()) {
                usuario.setRol(rolForm);
                usuario.setCorreo(request.getParameter("correo_acceso"));
                usuario.setPassword(request.getParameter("password"));
                exito = usuarioDAO.insertarUsuario(usuario); //  PARA USUARIOS NORMALES
            } else {
                request.setAttribute("error", "Debe seleccionar un rol válido.");
                request.getRequestDispatcher("/vistas/errores/404.jsp").forward(request, response);
                return;
            }

        }

        //Redirección según el rol
        if (exito) {
            if ("C".equals(rolForm) || "nuevoliente".equals(accion)) {
                response.sendRedirect("AdminController?accion=listarClientes");
            } else {
                response.sendRedirect("AdminController?accion=listarUsuarios");
            }
        } else {
            request.setAttribute("error", "Hubo un error al procesar la solicitud.");
            request.getRequestDispatcher("/vistas/errores/400.jsp").forward(request, response);
        }

    }

}
