<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">

<head> 
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Iniciar Sesión - JJ Polarizados</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300..900;1,300..900&display=swap"
        rel="stylesheet">
    <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/style.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">
</head>

<body class="login-body has-background-white-ter">
    <section class="section is-flex is-justify-content-center is-align-items-center is-fullheight">
        <div class="box login-box has-background-light">
            <div class="has-text-centered mb-4">
                <img src="${pageContext.request.contextPath}/vistas/img/logoanimal.png" alt="JJ Polarizados" width="100" draggable="false" />
                <h1 class="title title-login is-3 has-text-black">INICIAR SESIÓN</h1>
            </div>

            <!-- Enviará datos al LoginServlet usando POST -->
            <form action="${pageContext.request.contextPath}/LoginController" method="POST">
                <div class="field">
                    <label class="label has-text-dark">Correo</label>
                    <div class="control has-icons-left">
                        <input class="input has-background-light has-text-dark" type="email" name="correo" required minlength="4" maxlength="50" />
                        <span class="icon is-small is-left"><i class="fa-solid fa-envelope"></i></span>
                    </div>
                </div>

                <div class="field">
                    <label class="label has-text-dark">Contraseña</label>
                    <div class="control has-icons-left">
                        <input class="input has-background-light has-text-dark"" type="password" name="password" required minlength="6" />
                        <span class="icon is-small is-left"><i class="fas fa-lock"></i></span>
                    </div>
                </div>

                <div class="field">
                    <div class="control">
                        <!-- Botón que ahora sí envía el formulario -->
                        <button type="submit" class="button is-fullwidth login-btn mt-3">Iniciar Sesión</button>
			<% if (request.getParameter("error") != null) {%>
            		<p style="color:red;">Correo o contraseña invalidos</p>
            		<%}%>
                    </div>
                </div>
            </form>

            <div class="back">
                <a href="${pageContext.request.contextPath}/vistas/landing/landing.jsp" class="button is-fullwidth login-btn mt-3 mb-3">
                    <i class="fas fa-arrow-left"></i> Volver al inicio
                </a>
            </div>

            <a href="#">¿Olvidaste tu contraseña? Recupérala aquí</a>
        </div>
    </section>
</body>

</html>