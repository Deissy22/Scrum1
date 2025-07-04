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

@WebServlet("/VendedorController")
public class VendedorController extends HttpServlet {

    private PersonaDAO personaDAO = new PersonaDAO();
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "dashboard";
        }

        switch (accion) {
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
                request.getRequestDispatcher("/vistas/vendedor/clientes/clientesV.jsp").forward(request, response);
                break;
            case "nuevoCliente":
                request.getRequestDispatcher("/vistas/vendedor/clientes/crearCV.jsp").forward(request, response);
                break;
            case "editarCliente":
                int idEditar = Integer.parseInt(request.getParameter("id_persona"));
                Persona personaEditar = personaDAO.buscarPorId(idEditar);
                Usuario usuarioEditar = usuarioDAO.buscarIdPersona(idEditar);

                if (usuarioEditar != null && "C".equals(usuarioEditar.getRol())) {
                    request.setAttribute("persona", personaEditar);
                    request.setAttribute("usuario", usuarioEditar);
                    request.getRequestDispatcher("/vistas/vendedor/clientes/editarCV.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/vistas/errores/404.jsp");
                }
                break;
            case "eliminarCliente":
                int idEliminar = Integer.parseInt(request.getParameter("id_persona"));
                Usuario usuario = usuarioDAO.buscarIdPersona(idEliminar);

                if (usuario != null && "C".equals(usuario.getRol())) {
                    usuarioDAO.eliminar(idEliminar);
                    personaDAO.eliminarPersona(idEliminar);
                    response.sendRedirect("VendedorController?accion=listarClientes");
                } else {
                    response.sendRedirect("vistas/errores/404.jsp");
                }
                break;

            default:
                request.getRequestDispatcher("/vistas/vendedor/vendedor.jsp").forward(request, response);
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        String idParam = request.getParameter("id_persona");

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
            // Actualización de cliente
            int id = Integer.parseInt(idParam);
            persona.setIdPersona(id);
            exito = personaDAO.actualizarPersona(persona);

            Usuario usuario = usuarioDAO.buscarIdPersona(id);
            if (usuario != null && "C".equals(usuario.getRol())) {
                usuario.setCorreo(null);
                usuario.setPassword(null);
                usuario.setRol("C");
                exito &= usuarioDAO.actualizar(usuario);
            }

        } else {
            // Creación de cliente
            int idPersona = personaDAO.registrarPersona(persona);
            Usuario nuevoCliente = new Usuario();
            nuevoCliente.setIdPersona(idPersona);
            nuevoCliente.setRol("C");
            exito = usuarioDAO.insertarCliente(nuevoCliente);
        }

        if (exito) {
            response.sendRedirect("VendedorController?accion=listarClientes");
        } else {
            request.setAttribute("error", "Error al procesar la solicitud.");
            request.getRequestDispatcher("/vistas/errores/error.jsp").forward(request, response);
        }

    }

}
