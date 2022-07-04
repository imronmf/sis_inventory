<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ApiController extends Controller
{
    public function index(){
        $data = \DB::table('barang')->get();

        return response ()->json($data);
    }
}
