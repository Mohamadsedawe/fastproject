<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\loginController;
use App\Http\Controllers\firstpartController;
use App\Http\Controllers\partController;



Route::post('login', [loginController::class, 'loginpost']);
Route::post('regester', [loginController::class, 'registerpost']);
Route::post('logout', [loginController::class, 'logout']);

Route::middleware('jwt.auth')->group(function () {
    Route::put('update/regester', [loginController::class, 'update']);
    Route::put('delete/user', [loginController::class, 'delete']);
    Route::post('addorder', [partController::class, 'addOrder']);
    Route::get('showorder', [partController::class, 'getOrders']);
    Route::put('update/{order_id}', [partController::class, 'updateOrder']);
    Route::delete('delete/{order_id}', [partController::class, 'deleteOrder']);
});



