<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Actualizar Secvicio</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
        <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
        <link rel="shortcut icon" href="favi.png" type="image/x-icon">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/crud.css" />
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">
    </head>

    <body>

        <nav class="navbar is-fixed-top" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="${pageContext.request.contextPath}/AdminController?accion=dashboard">
                    <img src="${pageContext.request.contextPath}/vistas/img/path1.png" alt="JJ Polarizados">
                </a>
            </div>
        </nav>

        <section class="section">
            <div class="container">
                <h1 class="title is-3 has-text-centered mb-5">Editar Servicio</h1>

                <div class="box">
                    <!--SERVLET OLA-->
                    <form method="post" action="${pageContext.request.contextPath}/ServAdminController">

                        <div class="columns">
                            <div class="column">
                                <label class="label">Nombre del Servicio</label>
                                <input class="input" type="text" name="nombre_servicio" value="${servicio.nombreServicio}" required>
                            </div>
                            <div class="column">
                                <label class="label">Precio del Servicio</label>
                                <input class="input" type="number" name="precio" value="${servicio.precio}" required>
                            </div>
                        </div>
                        <div class="columns">
                            <div class="column">
                                <label class="label">Descripción del Servicio</label>
                                <textarea class="textarea input has-text-light" name="descripcion"
                                          placeholder="Ej: Lote nuevo, proveedor, etc.">${servicio.descripcion}</textarea>
                            </div>
                        </div>
                        <div class="field mt-5">
                            <button class="button is-primary is-fullwidth">
                                <i class="fa-solid fa-pen-to-square"></i>&nbsp; Guardar Cambios
                                <input type="hidden" name="accion" value="editar" />
                                <input type="hidden" name="id_servicio" value="${servicio.idServicio}">
                            </button>
                            <a href="${pageContext.request.contextPath}/ServAdminController?accion=listar" class="button salir is-fullwidth mt-2">
                                <i class="fa-solid fa-arrow-left"></i>&nbsp; Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </section>



    </body>

</html>
