<?php

use App\Http\Controllers\InvitationController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ShortUrlController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', [ShortUrlController::class, 'index',])->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/invitations/accept/{token}', [InvitationController::class, 'showAcceptForm',])->name('invitations.accept');
Route::post('/invitations/accept/{token}', [InvitationController::class, 'accept',])->name('invitations.accept.submit');

Route::get('/s/{code}', [ShortUrlController::class,'redirect',])->name('shorturls.redirect');


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::middleware('role:superadmin,admin')->group(function () {
        Route::post('/invitations', [InvitationController::class, 'store',])->name('invitations.store');

    });

    Route::middleware('role:admin,member')->group(function () {
        Route::post('/short-urls', [ShortUrlController::class, 'store',])->name('shorturls.store');
    });
});

require __DIR__.'/auth.php';
