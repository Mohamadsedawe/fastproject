<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Mail;
use App\Http\Controllers\AuthManger;


Route::get('home', function () {
    return view('welcome');
 })->name('home');


 //Route::get('/product/edit/view/{user}', [AuthManger::class, 'edit'])->name('product.edit');
  //Route::post('/product/edit/update/{user}', [AuthManger::class, 'update'])->name('product.update');





Route::get('/test-mail', function () {
    Mail::raw('هذا بريد تجريبي من Laravel باستخدام Gmail SMTP', function ($message) {
        $message->to('mhamadsedawe41@gmail.com') // ← بريدك الحقيقي هنا
                ->subject('رسالة تجريبية');
    });

    return 'تم إرسال البريد بنجاح!';
});






