
package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashSet;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println(">>> Entró a LoginController"); // Mensaje en consola

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarLogin(correo, password);

        if (usuario != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            sesion.setAttribute("rol", usuario.getRol());
            sesion.setAttribute("idPersona", usuario.getIdPersona());
            
            
            String contexto = request.getContextPath();
            
            switch (usuario.getRol().charAt(0)) {
                case 'A':
                    response.sendRedirect(contexto + "/AdminController?accion=dashboard");
                    break;
                case 'V':
                    response.sendRedirect(contexto + "/VendedorController?accion=dashboard");
                    break;
                case 'T':
                    request.getRequestDispatcher("/vistas/tecnico/tecnico.jsp").forward(request, response);
                    break;
                default:
                    System.out.println("Usuario Invalido");
                    break;
            }

        } else {
            response.sendRedirect("vistas/login/login.jsp?error=1");
        }
    }

}
