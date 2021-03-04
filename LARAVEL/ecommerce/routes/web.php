<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return "This is a client page";
});


Route::get('/admin', [AdminController::class, 'index']);
// Route::get('/admin','AdminController@index');

Route::get('/shop', 'ShopController@index');

Route::get('/shop/{id}', function ($id) {
    return view('single-product',["id" => $id]);
});
