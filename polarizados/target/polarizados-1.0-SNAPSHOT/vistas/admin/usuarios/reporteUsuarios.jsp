<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Reporte de Usuarios</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
        <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/crud.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">
    </head>

    <body>

        <nav class="navbar is-fixed-top has-background-black" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="${pageContext.request.contextPath}/AdminController?accion=dashboard">
                    <img src="${pageContext.request.contextPath}/vistas/img/path1.png" alt="JJ Polarizados">
                </a>
            </div>
            <div class="navbar-end">
                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link has-text-white has-background-black">
                        <i class="fas fa-user-circle"></i>&nbsp; Usuario
                    </a>
                    <div class="navbar-dropdown is-right has-background-black">
                        <a class="navbar-item has-background-black has-text-white"
                           href="configuracion.html">Configuración</a>
                        <hr class="navbar-divider">
                        <a class="navbar-item has-background-black has-text-white" href="${pageContext.request.contextPath}/LogoutController">Cerrar
                            sesión</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <section class="section">
            <div class="container">
                <h1 class="title is-3">Reporte de Usuarios</h1>
                <div class="field mt-5">
                    <a href="${pageContext.request.contextPath}/AdminController?accion=listarUsuarios" class="button salir is-half mt-2">
                        <i class="fa-solid fa-arrow-left"></i>&nbsp; Volver
                    </a>
                </div>

                <!-- Formulario de filtros -->
                <form method="get" action="${pageContext.request.contextPath}/AdminController">
                    <input type="hidden" name="accion" value="buscarUsuarios" />

                    <div class="columns">
                        <div class="column">
                            <label class="label">Apellidos</label>
                            <input class="input" type="text" name="apellidos" placeholder="Ej: Pérez">
                        </div>
                        <div class="column">
                            <label class="label">Rol</label>
                            <div class="select is-fullwidth">
                                <select name="rol">
                                    <option value="">-- Todos --</option>
                                    <option value="A">Administrador</option>
                                    <option value="T">Técnico</option>
                                    <option value="V">Vendedor</option>
                                    <option value="C">Cliente</option>
                                </select>
                            </div>
                        </div>
                        <div class="column is-2 is-flex is-align-items-end">
                            <button class="button is-fullwidth" type="submit">
                                <i class="fas fa-search"></i>&nbsp; Buscar
                            </button>
                        </div>
                    </div>
                </form>

                <hr>

                <!-- Resultados -->
                <div class="box mt-4 ">
                    <table class="table is-fullwidth">
                        <thead>
                            <tr class="has-text-centered has-text-white">
                                <th>ID Usuario</th>
                                <th>Apellidos</th>
                                <th>Nombres</th>
                                <th>Correo personal</th>
                                <th>Rol</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty usuarios}">
                                    <c:forEach var="u" items="${usuarios}">
                                        <tr>
                                            <td class="has-text-centered">${u.idUsuario}</td>
                                            <td>${u.persona.apellidos}</td>
                                            <td>${u.persona.nombres}</td>
                                            <td>${u.persona.correoPersonal}</td>
                                            <td>${u.rol}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="has-text-centered has-text-danger">No se encontraron
                                            resultados</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
    </section>

</body>

</html>