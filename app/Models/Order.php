<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Order extends Model
{
    use HasFactory;

    protected $fillable = ['item_name','item_id', 'user_id', 'details','status'];

    public function item()
    {
        return $this->belongsTo(Item::class);
    }

public function user()
{
    return $this->belongsTo(User::class, 'user_id');
}
public function worker()
{
    return $this->belongsTo(User::class, 'worker_id');
}

}
