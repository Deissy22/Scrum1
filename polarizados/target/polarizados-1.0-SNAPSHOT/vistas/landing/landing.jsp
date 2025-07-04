
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang ="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>JJ POLARIZADOS - Inicio</title>
    <meta name="description" content="JJ POLARIZADOS - Inicio">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
    <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/style.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">

</head>

<body>

    <nav class="navbar has-background-black" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="">
                <img class="nav-img" src="${pageContext.request.contextPath}/vistas/img/path1.png" width="135" height="28">
            </a>
        </div>
        <div id="navbarBasicExample" class="navbar-menu">
            <div class="navbar-end">
                <div class="navbar-item">
                    <div class="buttons">
                        <a class="button is-light btn-login" href="${pageContext.request.contextPath}/vistas/login/login.jsp">
                            Iniciar Sesión
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <section class="hero is-fullheight-with-navbar hero-bg">
        <div class="hero-body">
            <style>
                .hero-bg {
                background-image: url("${pageContext.request.contextPath}/vistas/img/hero-bg.jpg");
                background-size: cover;
                background-position: center;
                }
            </style>
            <div class="container has-text-centered">
                <p class="title is-1 has-text-light">JJ POLARIZADOS</p>
                <p class="subtitle is-4 has-text-light">La mejor gestión de inventario</p>
            </div>
        </div>
    </section>

    <section class="section has-background-black">
        <div class="container">
            <div class="columns is-centered">
                <div class="column is-half has-text-centered">

                    <!-- Tarjeta 1 -->
                    <div class="card mb-4 custom-card  has-background-light">
                        <header class="card-header">
                            <p class="card-header-title has-text-white is-size-4">
                                Gestion de Inventario
                            </p>
                            <span class="card-header-icon has-text-white">
                                <i class="fa-solid fa-list"></i>
                            </span>
                        </header>
                        <div class="card-content">
                            <div class="content has-text-black">
                                Controla entradas y salidas de productos de forma eficiente.
                            </div>
                        </div>
                    </div>

                    <!-- Tarjeta 2 -->
                    <div class="card mb-4 custom-card has-background-light">
                        <header class="card-header">
                            <p class="card-header-title has-text-white is-size-4">
                                Multiusuario con Roles
                            </p>
                            <span class="card-header-icon has-text-white">
                                <i class="fa-solid fa-user-plus"></i>
                            </span>
                        </header>
                        <div class="card-content">
                            <div class="content has-text-black"">
                                Crea cuentas para empleados y asigna permisos facilmente.
                            </div>
                        </div>
                    </div>

                    <!-- Tarjeta 3 -->
                    <div class=" card mb-4 custom-card has-background-light">
                                <header class="card-header">
                                    <p class="card-header-title has-text-white is-size-4">
                                        Historial de Cambios
                                    </p>
                                    <span class="card-header-icon has-text-white">
                                        <i class="fa-solid fa-clock-rotate-left"></i>
                                    </span>
                                </header>
                                <div class="card-content">
                                    <div class="content has-text-black"">
                                Revisa cada modificación realizada en el inventario.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section has-background-light" id="soporte">
        <div class="container">
            <h2 class="title is-3 has-text-centered" style="color: var(--primary-dark);">
                ¿Necesitas Ayuda?
            </h2>
            <p class="subtitle is-5 has-text-centered" style="color: var(--secondary);">
                Nuestro equipo está listo para asistirte.
            </p>

            <div class="columns is-multiline is-centered mt-5">
                <!-- Email -->
                <div class="column is-4-desktop is-6-tablet">
                    <div class="box has-text-centered">
                        <span class="icon is-large is-size-3">
                            <i class="fa-solid fa-envelope"></i>
                        </span>
                        <h3 class="title is-4 mt-3">Correo Electrónico</h3>
                        <p><a href="mailto:info@jjpolarizados.com" class="has-text-link">info@jjpolarizados.com</a></p>
                    </div>
                </div>

                <!-- Teléfono -->
                <div class="column is-4-desktop is-6-tablet">
                    <div class="box has-text-centered">
                        <span class="icon is-large is-size-3">
                            <i class="fa-solid fa-phone"></i>
                        </span>
                        <h3 class="title is-4 mt-3">Teléfono</h3>
                        <p><a href="tel:+571234567890" class="has-text-link">(+57) 123 456 7890</a></p>
                    </div>
                </div>

                <!-- WhatsApp -->
                <div class="column is-4-desktop is-6-tablet">
                    <div class="box has-text-centered">
                        <span class="icon is-large is-size-3">
                            <i class="fa-brands fa-whatsapp"></i>
                        </span>
                        <h3 class="title is-4 mt-3">WhatsApp</h3>
                        <p><a href="https://wa.me/573001112222" class="has-text-link">+57 300 111 2222</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <footer class="footer has-background-black">
        <div class="content has-text-centered">
            <p>&copy; 2025 JJ Polarizados. Todos los derechos reservados.</p>
        </div>
    </footer>
</body>

</html>
