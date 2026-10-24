<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class SuperAdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $email = 'superadmin@yopmail.com';
        $exists = DB::table('users')->where('email', $email)->exists();

        if ($exists) {
            return;
        }

        $password = Hash::make('Admin@123');
        DB::table('users')->insert([
            'name' => 'Super Admin',
            'email' => $email,
            'password' => $password,
            'role' => 'superadmin',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
