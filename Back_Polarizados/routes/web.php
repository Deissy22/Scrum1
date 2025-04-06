<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\InventarioController;
use App\Http\Controllers\UsuariosController;


Route::get('/', function () {
    return redirect('inventario');
});

Route::get('/', function () {
    return redirect('usuarios');
});

/*Route::get('/', [InventarioController::class,'index']);*/


Route::resource('inventario', InventarioController::class);
Route::resource('usuarios', UsuariosController::class);
