<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Gestión de Clientes - JJ Polarizados</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/crud.css" />
    </head>

    <body>
        <nav class="navbar is-fixed-top has-background-black" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="${pageContext.request.contextPath}/VendedorController?accion=dashboard">
                    <img src="${pageContext.request.contextPath}/vistas/img/path1.png" alt="JJ Polarizados">
                </a>
            </div>


            <div id="mainNavbar" class="navbar-menu is-active">
                <div class="navbar-end">
                    <a class="navbar-item has-text-white" href="${pageContext.request.contextPath}/VendedorController?accion=dashboard">
                        <i class="fas fa-home"></i>&nbsp; Inicio
                    </a>
                    <a class="navbar-item has-text-white" href="${pageContext.request.contextPath}/vistas/errores/404.jsp">
                        <i class="fas fa-boxes"></i>&nbsp; Inventario
                    </a>
                    <a class="navbar-item has-text-white" href="${pageContext.request.contextPath}/vistas/errores/404.jsp">
                        <i class="fas fa-cash-register"></i>&nbsp; Ventas
                    </a>
                    <a class="navbar-item has-text-white" href="${pageContext.request.contextPath}/vistas/errores/404.jsp">
                        <i class="fa-solid fa-box"></i>&nbsp; Productos
                    </a>
                </div>

                <div class="navbar-end">
                    <div class="navbar-item has-dropdown is-hoverable">
                        <a class="navbar-link has-text-white has-background-black">
                            <i class="fas fa-user-circle"></i>&nbsp; Usuario
                        </a>
                        <div class="navbar-dropdown is-right has-background-black">
                            <a class="navbar-item has-background-black has-text-white" href="${pageContext.request.contextPath}/vistas/errores/404.jsp">Configuración</a>
                            <hr class="navbar-divider">
                            <a class="navbar-item has-background-black has-text-white" href="${pageContext.request.contextPath}/LogoutController">Cerrar sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <section class="section">
            <div class="container">
                <div class="level mb-5">
                    <div class="level-left">
                        <h1 class="title is-3">Clientes Registrados</h1>
                    </div>
                    <div class="level-right">
                        <a href="${pageContext.request.contextPath}/VendedorController?accion=nuevoCliente" class="button">
                            <i class="fas fa-user-plus"></i>&nbsp; Agregar Cliente
                        </a>
                    </div>
                </div>

                <!-- BÚSQUEDA -->
                <div class="field mb-4">
                    <div class="control has-icons-left">
                        <input id="buscador" class="input" type="text" placeholder="Buscar por nombre o numero de documento...">
                        <span class="icon is-left">
                            <i class="fas fa-search"></i>
                        </span>
                    </div>
                </div>
                <div class="box">
                    <table id="tablaClientes" class="table is-fullwidth">
                        <thead>
                            <tr class="has-text-centered has-text-light">
                                <th>ID</th>
                                <th>Tipo Doc</th>
                                <th>Documento</th>
                                <th>Nombre Completo</th>
                                <th>Correo</th>
                                <th>Celular</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="persona" items="${personas}">
                                <tr>
                                    <td>${persona.idPersona}</td>
                                    <td>${persona.tipoDocumento}</td>
                                    <td>${persona.numeroDocumento}</td>
                                    <td>${persona.nombres} ${persona.apellidos}</td>
                                    <td>${persona.correoPersonal}</td>
                                    <td>${persona.telefonoCelular}</td>
                                    <td>
                                        <div class="buttons are-small">
                                            <a href="${pageContext.request.contextPath}/VendedorController?accion=editarCliente&id_persona=${persona.idPersona}" class="button is-light">
                                                <i class="fas fa-pen"></i>
                                            </a>
                                            <form method="GET" action="${pageContext.request.contextPath}/VendedorController?accion=eliminarCliente" style="display:inline;">
                                                <input type="hidden" name="id_persona" value="${persona.idPersona}">
                                                <input type="hidden" name="accion" value="eliminarCliente">
                                                <button class="button is-light" type="submit" onclick="return confirm('¿Estás seguro de eliminar este cliente?');">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <p id="no-result" class="has-text-centered has-text-danger mt-3" style="display: none;">
                        No se encontraron coincidencias.
                    </p>
                </div>
            </div>
        </section>

        <script>
            document.getElementById("buscador").addEventListener("keyup", function () {
                const filtro = this.value.toLowerCase().trim();
                const filas = document.querySelectorAll("tbody tr");
                let coincidencias = 0;

                filas.forEach(fila => {
                    const nombre = fila.querySelector("td:nth-child(4)")?.textContent.toLowerCase().trim(); // nombres
                    const documento = fila.querySelector("td:nth-child(3)")?.textContent.toLowerCase().trim(); // documento

                    const coincideNombre = nombre.startsWith(filtro);
                    const coincideDocumento = documento.startsWith(filtro);

                    if (filtro === "" || coincideNombre || coincideDocumento) {
                        fila.style.display = "";
                        coincidencias++;
                    } else {
                        fila.style.display = "none";
                    }
                });

                // Mostrar u ocultar el mensaje
                const mensaje = document.getElementById("no-result");
                if (coincidencias === 0) {
                    mensaje.style.display = "block";
                } else {
                    mensaje.style.display = "none";
                }
            });
        </script>
    </body>

</html>
