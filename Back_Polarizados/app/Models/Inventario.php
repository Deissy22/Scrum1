<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Inventario extends Model
{
    protected $table = 'inventario';
    protected $primaryKey = 'cod_producto';
    protected $fillable = ['nom_prod', 'marca', 'distribuidora', 'cant_prod', 'precio'];

    public $timestamps = false;
}
