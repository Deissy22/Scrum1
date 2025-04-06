<?php

namespace App\Http\Controllers;

use App\Models\Inventario;
use Illuminate\Http\Request;

class InventarioController extends Controller
{
    
    public function index()
    {
        $inventario = Inventario::all();
        return view('inventario.index', ['inventario'=>$inventario]);
    }

    public function create()
    {
        return view('inventario.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nom_prod' => 'required|min:3|max:50',
            'marca' => 'required|min:3|max:30',
            'distribuidora' => 'required|min:3|max:30',
            'cant_prod' => 'required|numeric',
            'precio' => 'required|numeric|digits_between:4,11'

        ]);

        Inventario::create($request->all());

        return redirect()->route('inventario.index');
    }

    public function show(Inventario $inventario)
    {
        //
    }

    public function edit(Inventario $inventario)
    {
        return view('inventario.edit', ['inventario'=>$inventario]);
    }

    public function update(Request $request, Inventario $inventario)
    {
        $request->validate([
            'nom_prod' => 'required|min:3|max:50',
            'marca' => 'required|min:3|max:30',
            'distribuidora' => 'required|min:3|max:30',
            'cant_prod' => 'required|numeric',
            'precio' => 'required|numeric|min:10'

        ]); 

        $inventario->update($request->all());  

        return redirect()->route('inventario.index');

    }

    public function destroy(Inventario $inventario)
    {
        $inventario->delete();

        return redirect()->route('inventario.index');
    }
}
