<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Item;

class KitchenSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $kitchen = Category::create(['name' => 'Kitchen']);

        $kitchen->items()->createMany([
            ['name' => 'Refrigerator'],
            ['name' => 'Washing Machine'],
            ['name' => 'Dishwasher'],
            ['name' => 'Microwave'],
        ]);
    }
    }

