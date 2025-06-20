<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\loginController;
use App\Http\Controllers\firstpartController;
use App\Http\Controllers\partController;
use App\Http\Controllers\AdmainController;
use App\Http\Controllers\workercontroller;



Route::post('login/user', [loginController::class, 'loginpost']);
Route::post('regester/user', [loginController::class, 'registerpost']);
Route::post('logout/user', [loginController::class, 'logout']);
Route::post('regester/admin',[AdmainController::class, 'store']);
Route::post('login/admin', [AdmainController::class, 'loginpost']);

Route::middleware('jwt.auth')->group(function () {

    Route::put('update/regester', [loginController::class, 'update']);
    Route::get('/showusers', [AdmainController::class,'getAllUsers']);
    Route::delete('delete/user', [loginController::class, 'delete']);
    Route::post('addorder', [partController::class, 'addOrder']);
    Route::get('showorder', [partController::class, 'getOrders']);
    Route::put('update/{order_id}', [partController::class, 'updateOrder']);
    Route::delete('delete/{order_id}', [partController::class, 'deleteOrder']);
    Route::put('/workers/{id}',[AdmainController::class, 'updateWorker']);
    Route::delete('delete/admin/{workerId}',[AdmainController::class, 'deleteWorker']);
    Route::post('create/admin',[AdmainController::class,'createWorker']);
    Route::get('show/admin',[AdmainController::class, 'getAllWorkers']);
    Route::post('admin/ban/{userId}', [AdmainController::class, 'banUser']);
    Route::post('admin/unban/{userId}', [AdmainController::class, 'unbanUser']);
    Route::get('admin/banned-users', [AdmainController::class, 'getBannedUsers']);
    Route::get('admin/active_workers', [AdmainController::class, 'getAllActiveWorkers']);
    Route::get('admin/banned-users', [AdmainController::class, 'getBannedUsersByRole']);
    Route::put('/orders/{orderId}/handle', [workercontroller::class, 'handleOrder']);
    Route::get('/unreadnotifications', [partController::class, 'getNotifications']);
    Route::get('/worker/orders/accepted', [workercontroller::class,'getAcceptedOrdersByWorker']);





});



