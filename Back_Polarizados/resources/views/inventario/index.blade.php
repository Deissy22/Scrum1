@extends('layouts.app')
@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<h2 class="text-success">Gestión de Inventario</h2>
			<a href="{{route('inventario.create')}}" class="btn btn-primary mb-2">Agregar</a>
		</div>
		<div class="col-md-20">
			<table class="table table-bordered">
				<thead >
					<tr class="text-center">
						<th>Código Producto</th>
						<th>Nombre Producto</th>
						<th>Marca</th>
						<th>Distribuidora</th>
						<th>Cantidad Producto</th>
						<th>Precio</th>
						<th>Opciones</th>
					</tr>
				</thead>
				<tbody>
					@foreach($inventario as $inventario)
					<tr class="text-center">
						<td>{{$inventario->cod_producto}}</td>
						<td>{{$inventario->nom_prod}}</td>
						<td>{{$inventario->marca}}</td>
						<td>{{$inventario->distribuidora}}</td>
						<td>{{$inventario->cant_prod}}</td>
						<td>{{$inventario->precio}}</td>
						<td>
							<a href="{{route('inventario.edit', $inventario)}}" class="btn btn-success">Editar</a>
							<form action="{{route('inventario.destroy', $inventario)}}" method="POST" class="d-inline-block">
								@csrf
								@method('DELETE')
								<button class="btn btn-danger"
								onclick="return confirm('¿Está seguro de eliminar el Producto?')">Eliminar</button>
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