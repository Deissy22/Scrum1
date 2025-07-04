
package controlador;

import dao.ServicioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.Servicio;

@WebServlet("/ServAdminController")
public class ServAdminController extends HttpServlet {

 
   private ServicioDAO servicioDAO = new ServicioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Servicio> servicios = servicioDAO.listar();
                request.setAttribute("servicios", servicios);
                request.getRequestDispatcher("/vistas/admin/servicios/servicios.jsp").forward(request, response);
                break;

            case "nuevo":
                request.getRequestDispatcher("/vistas/admin/servicios/crearS.jsp").forward(request, response);
                break;

            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id_servicio"));
                Servicio servicio = servicioDAO.buscarPorId(idEditar);
                request.setAttribute("servicio", servicio);
                request.getRequestDispatcher("/vistas/admin/servicios/editarS.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id_servicio"));
                servicioDAO.eliminar(idEliminar);
                response.sendRedirect("ServAdminController?accion=listar");
                break;

            default:
                response.sendRedirect("vistas/errores/404.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idParam = request.getParameter("id_servicio");
        String nombreServicio = request.getParameter("nombre_servicio");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");

        Servicio servicio = new Servicio();
        servicio.setNombreServicio(nombreServicio);
        servicio.setDescripcion(descripcion);
        servicio.setPrecio(Double.parseDouble(precioStr));

        boolean exito;
        if (idParam != null && !idParam.isEmpty()) {
            servicio.setIdServicio(Integer.parseInt(idParam));
            exito = servicioDAO.actualizar(servicio);
        } else {
            exito = servicioDAO.insertar(servicio);
        }

        if (exito) {
            response.sendRedirect("ServAdminController?accion=listar");
        } else {
            request.setAttribute("error", "No se pudo procesar la solicitud.");
            request.getRequestDispatcher("/vistas/errores/400.jsp").forward(request, response);
        }
    }

  

}
