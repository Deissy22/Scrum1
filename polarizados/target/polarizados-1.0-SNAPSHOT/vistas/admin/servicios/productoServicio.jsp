<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Productos Utilizados</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
  <link href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css" rel="stylesheet">
  <link rel="shortcut icon" href="favi.png" type="image/x-icon">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/vistas/estilos/dashboard.css">
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/vistas/img/favi.png" type="image/x-icon">
</head>

<body>

  <nav class="navbar is-fixed-top" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item" href="productosUtilizados.html">
        <img src="${pageContext.request.contextPath}/vistas/img/path1.png" alt="JJ Polarizados">
      </a>
    </div>
  </nav>

  <section class="section">
    <div class="container">
      <h1 class="title is-3 has-text-centered mb-5">Productos Utilizados</h1>

      <div class="box">
        <form onsubmit="event.preventDefault(); alert('Simulación de guardado');">
          <div id="grupo-productos">
            <!-- Aquí se agregarán las filas -->
          </div>

          <!-- SOLO ABAJO: botones finales -->
          <div class="field mt-5">
            <button type="submit" class="button is-primary is-fullwidth">
              <i class="fas fa-save"></i>&nbsp; Guardar Cambios
            </button>
            <a href="${pageContext.request.contextPath}/ServAdminController?accion=listar" class="button salir is-fullwidth mt-2">
              <i class="fa-solid fa-arrow-left"></i>&nbsp; Cancelar
            </a>
          </div>
        </form>
      </div>
    </div>
  </section>

  <script>
    let filaID = 0;

    function agregarGrupo() {
      const id = filaID++;
      const container = document.getElementById('grupo-productos');

      const grupo = document.createElement('div');
      grupo.className = 'columns is-multiline is-vcentered mb-2';
      grupo.setAttribute('data-id', id);

      grupo.innerHTML = `
        <div class="column is-3">
          <label class="label">Servicio</label>
          <div class="select is-fullwidth is-small">
            <select name="servicio_${id}" required>
              <option value="">Seleccione</option>
              <option value="polarizado">Polarizado</option>
              <option value="luces">Luces</option>
            </select>
          </div>
        </div>

        <div class="column is-3">
          <label class="label">Producto</label>
          <div class="select is-fullwidth is-small">
            <select name="producto_${id}" required>
              <option value="">Seleccione</option>
              <option value="bocina">Bocina</option>
              <option value="pelicula">Película UV</option>
            </select>
          </div>
        </div>

        <div class="column is-2">
          <label class="label">Cantidad</label>
          <input class="input is-small" type="number" name="cantidad_${id}" min="1" required />
        </div>

        <div class="column is-2">
          <label class="label">Acciones</label>
          <div class="buttons">
            <button type="button" class="button is-small" onclick="eliminarGrupo(${id})">
              <i class="fas fa-trash-alt"></i>
            </button>
            <button type="button" class="button is-small" onclick="agregarGrupo()">
              <i class="fas fa-plus"></i>
            </button>
          </div>
        </div>
      `;

      container.appendChild(grupo);
    }

    function eliminarGrupo(id) {
      const grupo = document.querySelector(`[data-id="${id}"]`);
      if (grupo) grupo.remove();
    }

    // Carga al menos una fila al iniciar
    window.onload = () => agregarGrupo();
  </script>

</body>

</html>
