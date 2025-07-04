<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Editar Cliente</title>
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
                <h1 class="title is-3 has-text-centered mb-5">Editar Cliente</h1>

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
                                        <option value="CC" ${persona.tipoDocumento == 'CC' ? 'selected' : ''}>Cédula</option>
                                        <option value="TI" ${persona.tipoDocumento == 'TI' ? 'selected' : ''}>Tarjeta Identidad</option>
                                        <option value="CE" ${persona.tipoDocumento == 'CE' ? 'selected' : ''}>Cédula Extranjería</option>
                                    </select>
                                </div>
                            </div>
                            <div class="column">
                                <label class="label">Número de Documento</label>
                                <input class="input" type="text" name="numero_documento" value ="${persona.numeroDocumento}" required>
                            </div>
                        </div>

                        <!-- Nombre y Apellido -->
                        <div class="columns">
                            <div class="column">
                                <label class="label">Nombres</label>
                                <input class="input" type="text" name="nombres" value ="${persona.nombres}" required>
                            </div>
                            <div class="column">
                                <label class="label">Apellidos</label>
                                <input class="input" type="text" name="apellidos" value ="${persona.apellidos}" required>
                            </div>
                        </div>

                        <div class="columns">
                            <div class="column">
                                <label class="label">Correo Personal</label>
                                <input class="input" type="email" name="correo_personal" value ="${persona.correo}" required>
                            </div>

                            <!-- Celular -->
                                <div class="column">
                                    <label class="label">Celular</label>
                                    <input class="input" type="tel" name="telefono" value ="${persona.telefonoCelular}" required>
                                </div>
                            </div>
                            <div class="columns">
                                <div class="column">
                                    <label class="label">Género</label>
                                    <div class="select is-fullwidth">
                                        <select name="genero" required>
                                            <option value="">Seleccione</option>
                                            <option value="M" ${persona.genero == 'M' ? 'selected' : ''}>Masculino</option>
                                            <option value="F" ${persona.tipoDocumento == 'F' ? 'selected' : ''}>Femenino</option>
                                            <option value="OTRO" ${persona.tipoDocumento == 'OTRO' ? 'selected' : ''}>Otro</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="column">
                                    <label class="label">Fecha de Nacimiento</label>
                                    <input class="input" type="date" name="fecha_nacimiento" value="${persona.fechaNacimiento}" required>
                                </div>
                                
                            </div>

                            <!-- Botones -->
                            <div class="field mt-5">
                                <button class="button is-primary is-fullwidth" type="submit">
                                    <i class="fa-solid fa-user-plus"></i>&nbsp; Guardar cambios
                                    <input type="hidden" name="rol" value="C">
                                    <input type="hidden" name="accion" value="editarCliente" />
                                    <input type="hidden" name="id_persona" value="${persona.idPersona}">
                                </button>
                                <a href="${pageContext.request.contextPath}/VendedorController?accion=listarClientes"
                                    class="button salir is-fullwidth mt-2">
                                    <i class="fa-solid fa-arrow-left"></i>&nbsp; Volver
                                </a>
                            </div>
                    </form>
                </div>
            </div>
        </section>

    </body>

    </html>

