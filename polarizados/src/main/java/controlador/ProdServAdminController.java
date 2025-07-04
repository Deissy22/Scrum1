
package controlador;

import dao.ProductoServicioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.ProductoServicio;

@WebServlet("/ProdServAdminController")
public class ProdServAdminController extends HttpServlet {


     private ProductoServicioDAO productoServicioDAO = new ProductoServicioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "nuevo";

        switch (accion) {
            case "nuevo":
                // Mostrar el formulario para asignar producto a servicio
                request.getRequestDispatcher("/vistas/admin/servicios/productoServicio.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect("vistas/errores/404.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idServicio = Integer.parseInt(request.getParameter("id_servicio"));
            int idProducto = Integer.parseInt(request.getParameter("id_producto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));

            ProductoServicio ps = new ProductoServicio();
            ps.setIdServicio(idServicio);
            ps.setIdProducto(idProducto);
            ps.setCantidad(cantidad);

            boolean exito = productoServicioDAO.insertar(ps);

            if (exito) {
                // Podrías redirigir al formulario de nuevo o a un mensaje de éxito
                response.sendRedirect("ProdServAdminController?accion=nuevo");
            } else {
                request.setAttribute("error", "No se pudo registrar la relación.");
                request.getRequestDispatcher("/vistas/errores/400.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Parámetros inválidos.");
            request.getRequestDispatcher("/vistas/errores/400.jsp").forward(request, response);
        }
    }

  

}
