
package controlador;

import dao.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.Producto;


@WebServlet("/ProdAdminController")
public class ProdAdminController extends HttpServlet {

  
   private ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Producto> productos = productoDAO.listar();
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("/vistas/admin/productos/productos.jsp").forward(request, response);
                break;
            case "nuevo":
                request.getRequestDispatcher("/vistas/admin/productos/crearP.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id_producto"));
                Producto producto = productoDAO.buscarPorId(idEditar);
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("/vistas/admin/productos/editarP.jsp").forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id_producto"));
                productoDAO.eliminar(idEliminar);
                response.sendRedirect("ProdAdminController?accion=listar");
                break;
            default:
                response.sendRedirect("vistas/errores/404.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id_producto");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        Producto producto = new Producto();
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);

        boolean exito;

        if (idParam != null && !idParam.isEmpty()) {
            producto.setIdProducto(Integer.parseInt(idParam));
            exito = productoDAO.actualizar(producto);
        } else {
            exito = productoDAO.insertar(producto);
        }

        if (exito) {
            response.sendRedirect("ProdAdminController?accion=listar");
        } else {
            request.setAttribute("error", "No se pudo procesar la solicitud.");
            request.getRequestDispatcher("/vistas/errores/400.jsp").forward(request, response);
        }
    }

   

}
