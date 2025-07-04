<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Agregar Cliente</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
        <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/crud.css" />
    </head>

    <body>

        <!-- Navbar -->
        <nav class="navbar is-fixed-top" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="${pageContext.request.contextPath}/VendedorController?accion=dashboard">
                    <img src="${pageContext.request.contextPath}/vistas/img/path1.png" alt="JJ Polarizados">
                </a>
            </div>
        </nav>

        <!-- Formulario -->
        <section class="section">
            <div class="container">
                <h1 class="title is-3 has-text-centered mb-5">Agregar Cliente</h1>

                <div class="box">
                    <!--SERVLET OLA-->
                    <form method="post" action="${pageContext.request.contextPath}/VendedorController">
                        <!-- Documento -->
                        <div class="columns">
                            <div class="column">
                                <label class="label">Tipo de Documento</label>
                                <div class="select is-fullwidth">
                                    <select name="tipo_documento" required>
                                        <option value="">Seleccione</option>
                                        <option value="CC">Cédula</option>
                                        <option value="TI">Tarjeta Identidad</option>
                                        <option value="CE">Cédula Extranjería</option>
                                    </select>
                                </div>
                            </div>
                            <div class="column">
                                <label class="label">Número de Documento</label>
                                <input class="input" type="text" name="numero_documento" required>
                            </div>
                        </div>

                        <!-- Nombre y Apellido -->
                        <div class="columns">
                            <div class="column">
                                <label class="label">Nombres</label>
                                <input class="input" type="text" name="nombres" required>
                            </div>
                            <div class="column">
                                <label class="label">Apellidos</label>
                                <input class="input" type="text" name="apellidos" required>
                            </div>
                        </div>

                        <div class="columns">
                            <div class="column">
                                <label class="label">Correo Personal</label>
                                <input class="input" type="email" name="correo_personal" required>
                            </div>

                            <!-- Celular -->
                                <div class="column">
                                    <label class="label">Celular</label>
                                    <input class="input" type="tel" name="telefono" required>
                                </div>
                            </div>
                            <div class="columns">
                                <div class="column">
                                    <label class="label">Género</label>
                                    <div class="select is-fullwidth">
                                        <select name="genero" required>
                                            <option value="">Seleccione</option>
                                            <option value="M">Masculino</option>
                                            <option value="F">Femenino</option>
                                            <option value="OTRO">Otro</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="column">
                                    <label class="label">Fecha de Nacimiento</label>
                                    <input class="input" type="date" name="fecha_nacimiento" required>
                                </div>
                                <input type="hidden" name="accion" value="nuevoCliente" />
                            </div>

                            <!-- Botones -->
                            <div class="field mt-5">
                                <button class="button is-danger is-fullwidth" type="submit">
                                    <i class="fa-solid fa-user-plus"></i>&nbsp; Registrar Cliente
                                </button>
                                <a href="${pageContext.request.contextPath}/VendedorController?accion=listarClientes" class="button salir is-fullwidth mt-2">
                                    <i class="fa-solid fa-arrow-left"></i>&nbsp; Volver
                                </a>
                            </div>
                    </form>
                </div>
            </div>
        </section>

    </body>

</html>

