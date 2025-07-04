
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - JJ Polarizados</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
    <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/dashboard.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">
</head>

<body>

    <nav class="navbar is-fixed-top has-background-black" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="#">
                <img src="${pageContext.request.contextPath}/vistas/img/path1.png" alt="JJ Polarizados">
            </a>
        </div>

        <div class="navbar-menu is-active">
            <div class="navbar-end">
                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link has-text-white has-background-black">
                        <i class="fas fa-user-circle"></i>&nbsp; Usuario
                    </a>
                    <div class="navbar-dropdown is-right has-background-black">
                        <a class="navbar-item has-background-black has-text-white" href="${pageContext.request.contextPath}/vistas/errores/404.jsp">Configuración</a><!--redireccionar a pagina de configuracion-->
                        <hr class="navbar-divider">
                        <a class="navbar-item has-background-black has-text-white" href="${pageContext.request.contextPath}/LogoutController">Cerrar sesión</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <section class="section">
        <div class="container">
            <h1 class="title is-2 has-text-centered">Bienvenido Administrador</h1>
            <p class="subtitle has-text-centered">Gestiona tus módulos y funcionalidades de forma rápida.</p>
            <div class="columns is-multiline mt-5">
                <div class="column">
                    <div class="box has-text-centered">
                        <span class="icon-text">
                            <span class="icon is-large has-text-danger">
                                <i class="fa-solid fa-table-cells fa-2x"></i>
                            </span>
                            <span class="title is-4">Inventario</span>
                        </span>
                        <p>Administra el inventario de la plataforma.</p>
                        <a href="${pageContext.request.contextPath}/vistas/errores/403.jsp" class="button is-link mt-3">Ver Inventario</a><!--redireccionar a inventario-->
                    </div>
                </div>


                <div class="column is-half">
                    <div class="box has-text-centered">
                        <span class="icon-text">
                            <span class="icon is-large has-text-danger">
                                <i class="fas fa-box fa-2x"></i>
                            </span>
                            <span class="title is-4">Productos</span>
                        </span>
                        <p>Administra tus productos fácilmente.</p>
                        <a href="${pageContext.request.contextPath}/ProdAdminController?accion=listar" class="button is-link mt-3">Ver Productos</a>
                    </div>
                </div>

                <div class="column is-half">
                    <div class="box has-text-centered">
                        <span class="icon-text">
                            <span class="icon is-large has-text-danger">
                                <i class="fas fa-shopping-cart fa-2x"></i>
                            </span>
                            <span class="title is-4">Ventas</span>
                        </span>
                        <p>Consulta tus ventas realizadas.</p>
                        <a href="${pageContext.request.contextPath}/vistas/errores/500.jsp" class="button is-link mt-3">Ver Ventas</a><!--redireccionar a ventas-->
                    </div>
                </div>

                <div class="column is-half">
                    <div class="box has-text-centered">
                        <span class="icon-text">
                            <span class="icon is-large has-text-danger">
                                <i class="fa-solid fa-circle-user fa-2x"></i>
                            </span>
                            <span class="title is-4">Usuarios</span>
                        </span>
                        <p>Administra los usuarios de la plataforma.</p>
                        <a href="${pageContext.request.contextPath}/AdminController?accion=listarUsuarios" class="button is-link mt-3">Ver Usuarios</a>
                    </div>
                </div>
                <div class="column">
                    <div class="box has-text-centered">
                        <span class="icon-text">
                            <span class="icon is-large has-text-danger">
                                <i class="fa-solid fa-bell-concierge fa-2x"></i>
                            </span>
                            <span class="title is-4">Servicios</span>
                        </span>
                        <p>Administra los servicios de la plataforma.</p>
                        <a href="${pageContext.request.contextPath}/ServAdminController?accion=listar" class="button is-link mt-3">Ver Servicios</a>
                    </div>
                </div>

                
                <div class="column">
                    <div class="box has-text-centered">
                        <span class="icon-text">
                            <span class="icon is-large has-text-danger">
                                <i class="fa-solid fa-user-plus fa-2x"></i>
                            </span>
                            <span class="title is-4">Clientes</span>
                        </span>
                        <p>Administra los clientes de la plataforma.</p>
                        <a href="${pageContext.request.contextPath}/AdminController?accion=listarClientes" class="button is-link mt-3">Ver Clientes</a><!--redireccionar a clientes-->
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="content has-text-centered">
            <p>
                <strong>JJ Polarizados</strong> &copy; 2023. Todos los derechos reservados.
            </p>
        </div>
    </footer>
</body>

</html>
