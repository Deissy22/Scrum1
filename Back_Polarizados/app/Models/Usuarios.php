<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Usuarios extends Model
{
    protected $table ='usuarios';
    protected $primaryKey = 'cod_usr';
    protected $fillable = ['nombre', 'documento','correo','contraseña','rol'];

    public $timestamps = false;
}
