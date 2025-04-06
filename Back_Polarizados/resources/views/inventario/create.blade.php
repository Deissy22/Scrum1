@extends('layouts.app')
@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<a href="{{route('inventario.index')}}" class="btn btn-secondary mb-3">Volver</a>
		</div>	
		<div class="col-md-5">
			<form action="{{route('inventario.store')}}" method="POST">
				@csrf
				<label for="nom_prod" class="form-control-label">Nombre del Producto</label>
				<input type="text" name="nom_prod" class="form-control" id="nom_prod">
				@error('nom_prod')
					<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<label for="marca" class="form-control-label">Marca</label>
				<input type="text" name="marca" class="form-control" id="marca">
				@error('marca')
					<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<label for="distribuidora" class="form-control-label">Distribuidora</label>
				<input type="text" name="distribuidora" class="form-control" id="distribuidora">
				@error('distribuidora')
					<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<label for="cant_prod" class="form-control-label">Cantidad</label>
				<input type="number" name="cant_prod" class="form-control" id="cant_prod">
				@error('cant_prod')
					<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<label for="precio" class="form-control-label">Precio</label>
				<input type="number" name="precio" class="form-control" id="precio">
				@error('precio')
					<small class="text-danger d-block">{{$message}}</small>
				@enderror
				<button type="submit" class="btn btn-primary mt-3">Guardar</button>
			</form>
			
		</div>
	</div>		
</div>
@endsection