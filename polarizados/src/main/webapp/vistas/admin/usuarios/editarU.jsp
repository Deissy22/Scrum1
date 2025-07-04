
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
    <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
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
            <h1 class="title is-3 has-text-centered mb-5">Editar Usuario</h1>

            <div class="box">
                  <!--SERVLET OLA-->
                <form method="post" action="${pageContext.request.contextPath}/AdminController">
                    <input type="hidden" name="id_persona" value="${persona.idPersona}">
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
                            <input class="input" type="email" name="correo_personal" value ="${persona.correoPersonal}" required>
                        </div>
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
                                    <option value="F" ${persona.genero == 'F' ? 'selected' : ''}>Femenino</option>
                                    <option value="OTRO" ${persona.genero == 'OTRO' ? 'selected' : ''}>Otro</option>
                                </select>
                            </div>
                        </div>
                        <div class="column">
                            <label class="label">Fecha de Nacimiento</label>
                            <input class="input" type="date" name="fecha_nacimiento" value="${persona.fechaNacimiento}" required>
                        </div>
                    </div>

                    <div class="columns">
                        <div class="column">
                            <label class="label">Correo de Acceso</label>
                            <input class="input" type="email" name="correo_acceso" value="${usuario.correo}" required>
                        </div>
                        <div class="column">
                            <label class="label">Contraseña</label>
                            <input class="input" type="password" name="password" value="${usuario.password}" required minlength="6">
                        </div>
                        <div class="column">
                            <label class="label">Rol</label>
                            <div class="select is-fullwidth">
                                <select name="rol" required>
                                    <option value="">Seleccione</option>
                                    <option value="A" ${usuario.rol == 'A' ? 'selected' : ''}>Administrador</option>
                                    <option value="T" ${usuario.rol == 'T' ? 'selected' : ''}>Técnico</option>
                                    <option value="V" ${usuario.rol == 'V' ? 'selected' : ''}>Vendedor</option>
                                </select>
                            </div>
                        </div>
                        
                    </div>

                    <div class="field mt-5">
                        <button class="button is-primary is-fullwidth" type="submit">
                            <i class="fa-solid fa-pen-to-square"></i>&nbsp; Guardar Cambios
                            <input type="hidden" name="accion" value="editar" />
                            <input type="hidden" name="id_persona" value="${persona.idPersona}">
                        </button>
                        <a href="${pageContext.request.contextPath}/AdminController?accion=listarUsuarios" class="button salir is-fullwidth mt-2">
                            <i class="fa-solid fa-arrow-left"></i>&nbsp; Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </section>



</body>

</html>
