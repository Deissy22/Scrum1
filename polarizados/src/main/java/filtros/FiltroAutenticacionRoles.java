package filtros;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo.Usuario;


@WebFilter("/*")
public class FiltroAutenticacionRoles implements Filter {
     
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String url = req.getRequestURI();
        HttpSession session = req.getSession(false);

        // Archivos estáticos y login siempre permitidos
        if (url.contains("/vistas/landing/") || url.contains("/vistas/login/") || url.contains("LoginController") || url.contains("vistas/estilos") || url.contains("img") || url.endsWith(".css") || url.endsWith(".js")) {
            chain.doFilter(request, response);
            return;
        }

        // Validar sesión
        if (session == null || session.getAttribute("usuario") == null) {
            res.sendRedirect(req.getContextPath() + "/vistas/landing/landing.jsp");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String rol = usuario.getRol();

        // Validar acceso según rol y ruta
        if (url.contains("AdminController") || url.contains("ProdAdminController") || url.contains("ServAdminController") || url.contains("ProdServAdminController")) {
            if (!rol.equals("A")) {
                res.sendRedirect(req.getContextPath() + "/vistas/errores/403.jsp");
                return;
            }
        } else if (url.contains("VendedorController")) {
            if (!rol.equals("V")) {
                res.sendRedirect(req.getContextPath() + "/vistas/errores/403.jsp");
                return;
            }
        } else if (url.contains("TecnicoController") || url.contains("ServTecnicoController")) {
            if (!rol.equals("T")) {
                res.sendRedirect(req.getContextPath() + "/vistas/errores/403.jsp");
                return;
            }
        }

        // Todo bien, continuar
        chain.doFilter(request, response);
    }
    
}
