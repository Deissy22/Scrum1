<?php

namespace App\Http\Controllers;

use App\Models\Usuarios;
use Illuminate\Http\Request;

class UsuariosController extends Controller
{

    public function index()
    {
        $usuarios = Usuarios::all();
        return view('usuarios.index', ['usuarios'=>$usuarios]);
    }

    public function create()
    {
        return view('usuarios.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|regex:/^[\pL\s\-]+$/u|min:3|max:50',
            'documento' => 'required|numeric|digits_between:7,11|unique:usuarios',
            'correo' => 'required|email|min:3|max:30|unique:usuarios',
            'contraseña'=>'required|min:8',
            'rol' => 'required|in: "A", "T", "V", "C"'

        ]);

        Usuarios::create($request->all());

        return redirect()->route('usuarios.index');
    }

    public function show(Usuarios $usuarios)
    {
        
    }

   
    public function edit(Usuarios $usuario)
    {
        return view('usuarios.edit', ['usuarios'=>$usuario]);
    }

    public function update(Request $request, Usuarios $usuario)
    {
        $request->validate([
            'nombre' => 'required|regex:/^[\pL\s\-]+$/u|min:3|max:50',
            'documento' => 'required|numeric|digits_between:7,11',
            'correo' => 'required|email|min:3|max:30',
            'contraseña'=>'required|min:8|confirmed',
            'rol' => 'required|in: "A", "T", "V", "C"'

        ]);

        $usuario->update($request->all());  

        return redirect()->route('usuarios.index');
    }

    public function destroy(Usuarios $usuario)
    {
        $usuario->delete();

        return redirect()->route('usuarios.index');
    }
}
