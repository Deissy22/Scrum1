@extends('layouts.app')
@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<a href="{{route('usuarios.index')}}" class="btn btn-secondary mb-3">Volver</a>
		</div>	
		<div class="col-md-5">
			<form action="{{route('usuarios.store')}}" method="POST">
				@csrf
				<label for="nombre" class="form-control-label">Nombre</label>
				<input type="text" name="nombre" class="form-control" id="nombre">
				@error('nombre')
				<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<label for="documento" class="form-control-label">Documento</label>
				<input type="number" name="documento" class="form-control" id="documento">
				@error('documento')
				<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<label for="correo" class="form-control-label">Correo</label>
				<input type="email" name="correo" class="form-control" id="correo">
				@error('correo')
				<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<div class="mb-3 position-relative">
					<label for="contraseña" class="form-control-label">Contraseña</label>
					<div class="input-group">
						<input type="password" name="contraseña" class="form-control" id="contraseña">
						<button type="button" class="btn btn-outline-secondary" onclick="togglePassword('contraseña', this)">
							<i class="bi bi-eye"></i>
						</button>
					</div>
				</div>

				<div class="mb-3 position-relative">
					<label for="contraseña_confirmation" class="form-control-label">Confirmar Contraseña</label>
					<div class="input-group">
						<input type="password" name="contraseña_confirmation" class="form-control" id="contraseña_confirmation">
						<button type="button" class="btn btn-outline-secondary" onclick="togglePassword('contraseña_confirmation', this)">
							<i class="bi bi-eye"></i>
						</button>
					</div>
				</div>

				@error('contraseña')
				<small class="text-danger d-block">{{ $message }}</small>
				@enderror

				<!-- Script para mostrar/ocultar contraseña -->
				<script>
					function togglePassword(id, btn) {
						const input = document.getElementById(id);
						const icon = btn.querySelector('i');
						if (input.type === "password") {
							input.type = "text";
							icon.classList.remove("bi-eye");
							icon.classList.add("bi-eye-slash");
						} else {
							input.type = "password";
							icon.classList.remove("bi-eye-slash");
							icon.classList.add("bi-eye");
						}
					}
				</script>

				<label for="rol" class="form-control-label">Rol</label>
				<select name="rol" class="form-control" id="rol">
					<option value="">Selecciona un rol</option>
					<option value="A">Administrador</option>
					<option value="T">Tecnico</option>
					<option value="V">Vendedor</option>
					<option value="C">Cliente</option>
				</select>
				@error('rol')
				<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<button type="submit" class="btn btn-primary mt-3">Guardar</button>
			</form>
			
		</div>
	</div>		
</div>
@endsection