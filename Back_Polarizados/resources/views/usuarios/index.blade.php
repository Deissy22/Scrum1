@extends('layouts.app')
@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<h2 class="text-success">Gestión de Usuarios</h2>
			<a href="{{route('usuarios.create')}}" class="btn btn-primary mb-2">Agregar</a>
		</div>
		<div class="col-md-20">
			<table class="table table-bordered">
				<thead >
					<tr class="text-center">
						<th>Código Usuario</th>
						<th>Nombre</th>
						<th>Documento</th>
						<th>Correo</th>
						<th>Rol de Usuario</th>
						<th>Opciones</th>
					</tr>
				</thead>
				<tbody>
					@foreach ($usuarios as $usuario)
					<tr class="text-center">
						<td>{{$usuario->cod_usr}}</td>
						<td>{{$usuario->nombre}}</td>
						<td>{{$usuario->documento}}</td>
						<td>{{$usuario->correo}}</td>
						<td>
							@switch($usuario->rol)
							@case('A')
								Administrador
								@break
							@case('T')
								Tecnico
								@break
							@case('V')
								Vendedor
								@break
							@default
								Cliente
								@break
							@endswitch
						</td>
						<td>
							<a href="{{route('usuarios.edit', $usuario)}}" class="btn btn-success">Editar</a>
							<form action="{{route('usuarios.destroy', $usuario)}}" method="POST" class="d-inline-block">
								@csrf
								@method('DELETE')
								<button class="btn btn-danger"
								onclick="return confirm('¿Está seguro de eliminar el Usuario?')">Eliminar</button>
							</form>
						</td>
					</tr>
					@endforeach
				</tbody>
			</table>
		</div>
	</div>
</div>

@endsection