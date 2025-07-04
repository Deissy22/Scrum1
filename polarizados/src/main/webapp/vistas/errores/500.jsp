<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Error 500 - Error Interno</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
  <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/crud.css">
</head>

<body>

  <section class="section has-text-centered">
    <div class="container">
      <h1 class="title is-1 has-text-danger">
        <i class="fa-solid fa-bug-slash"></i>
      </h1>

      <h2 class="title is-2 has-text-white">500</h2>
      <p class="subtitle is-4 has-text-white">Error interno del servidor</p>
      <p class="has-text-white mb-5">Algo salió mal en nuestro sistema... estamos trabajando en ello.</p>

      <a href="${pageContext.request.contextPath}/LogoutController" class="button is-danger is-medium">
        <i class="fa-solid fa-arrow-left"></i>&nbsp; Volver al inicio
      </a>
    </div>
  </section>

</body>

</html>
