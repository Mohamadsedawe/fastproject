<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use JWTFactory;
use JWTAuth;


class AdmainController extends Controller
{



    public function store(Request $request)
    {

        $validator=validator::make($request->all(),[
            'firstname' => ['required', 'string', 'max:255'],
            'lastname' => ['required', 'string', 'max:255'],
            'address' => ['required', 'string', 'max:255'],
            'phone_number' => ['required', 'digits:14'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'min:8', 'confirmed', Password::defaults()],
            'role' => ['required', 'string', 'in:admin,worker,user'],
            'admin_key' => ['required_if:role,admin', 'string'],
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        if (User::where('email', $request->email)->exists()) {
            return response()->json(['error' => 'Email already exists'], 409);
        }

        if ($request->role === 'admin') {

            $validAdminKey = '2345';


            if ($request->admin_key !== $validAdminKey) {
                return response()->json(['error' => 'Invalid admin key'], 400);
            }
        }


        $adminKey = null;
        if ($request->role === 'admin') {
            $adminKey = bcrypt('2345');
        } elseif ($request->role === 'worker') {
            $adminKey = bcrypt('90980');
        }


        $user = User::create([
            'firstname' => $request->firstname,
            'lastname' => $request->lastname,
            'address' => $request->address,
            'phone_number' => $request->phone_number,
            'email' => $request->email,
            'password' => Hash::make($request->input('password')),
            'role' => $request->role,
            'admin_key' => $adminKey,
        ]);
        $user = User::first();
        $token = JWTAuth::fromUser($user);


        return response()->json(compact('token'));
    }


    public function loginpost(Request $request)
{

    $validator = Validator::make($request->all(), [
        'email' => ['required', 'email'],
        'password' => ['required'],
        'role' => ['required', 'in:admin,worker,user'],
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => false,
            'errors' => $validator->errors()
        ], 422);
    }



    $credentials = $request->only('email', 'password');

    try {
        if (!$token = JWTAuth::attempt($credentials)) {
            return response()->json([
                'status' => false,
                'message' => 'Invalid email or password'
            ], 401);
        }
    } catch (JWTException $e) {
        return response()->json([
            'status' => false,
            'message' => 'Could not create token',
            'error' => $e->getMessage()
        ], 500);
    }

    $user = auth()->user();

if ($user->is_banned) {
    return response()->json([
        'status' => false,
        'message' => 'Your account has been banned. Contact admin.'
    ], 403);
}

    if ($user->role !== $request->role) {
        return response()->json([
            'status' => false,
            'message' => 'Role mismatch. You are not registered as ' . $request->role
        ], 403);
    }

    return response()->json([
        'status' => true,
        'message' => 'Login successful',
        'token' => $token,
        'user' => [
            'id' => $user->id,
            'email' => $user->email,
            'role' => $user->role,
            'name' => $user->firstname . ' ' . $user->lastname
        ]
    ]);
}
    public function updateWorker(Request $request, $id)
{
    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $user = User::find($id);

    if (!$user) {
        return response()->json(['message' => 'Worker not found'], 404);
    }

    $request->validate([
        'firstname' => ['required'],
        'lastname' => ['required'],
        'address' => ['required'],
        'phone_number' => ['required', 'digits:14'],
        'email' => ['required', 'email', Rule::unique('users')->ignore($user->id)],
        'password' => ['nullable', 'confirmed', Password::defaults()],
    ]);

    $user->firstname = $request->firstname;
    $user->lastname = $request->lastname;
    $user->address = $request->address;
    $user->phone_number = $request->phone_number;
    $user->email = $request->email;

    if ($request->filled('password')) {
        $user->password = bcrypt($request->password);
    }


    $user->save();

    return response()->json(['message' => 'Worker updated successfully'], 200);
}

public function deleteWorker($workerId) {

    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $user = User::find($workerId);

    if (!$user) {
        return response()->json(['message' => 'User not found'], 404);
    }

    $user->delete();

    return response()->json(['message' => 'User has been deleted successfully'], 200);
}
public function createWorker(Request $request) {

    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $request->validate([
        'firstname' => ['required'],
        'lastname' => ['required'],
        'address' => ['required'],
        'phone_number' => ['required', 'digits:14'],
        'email' => ['required', 'email', 'unique:users,email'],
        'password' => ['required', 'min:5', 'confirmed', Password::defaults()],
        'role' => ['required', 'string', 'in:admin,worker,user'],
        'admin_key' => ['required_if:role,admin', 'string'],
    ]);

    $user = new User();
    $user->firstname = $request->firstname;
    $user->lastname = $request->lastname;
    $user->address = $request->address;
    $user->phone_number = $request->phone_number;
    $user->email = $request->email;
    $user->password = bcrypt($request->password);
    $user->role =$request->role;
    $user->admin_key = $request->admin_key;
    $user->save();
    return response()->json(['message' => 'Worker created successfully'], 201);
}
public function getAllWorkers()
{

    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $workers = User::where('role', 'worker')->get();


    if ($workers->isEmpty()) {
        return response()->json(['message' => 'No workers found'], 404);
    }

    return response()->json(['workers' => $workers], 200);
}

public function banUser($userId)
{
    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $user = User::find($userId);

    if (!$user) {
        return response()->json(['message' => 'User not found'], 404);
    }

    $user->is_banned = true;
    $user->save();

    return response()->json(['message' => 'User has been banned'], 200);
}

public function unbanUser($userId)
{

    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }


    $user = User::find($userId);

    if (!$user) {
        return response()->json(['message' => 'User not found'], 404);
    }


    if (!$user->is_banned) {
        return response()->json(['message' => 'User is not banned'], 400);
    }


    $user->is_banned = false;
    $user->save();

    return response()->json(['message' => 'User has been unbanned successfully'], 200);
}


public function getBannedUsers()
{
    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $bannedUsers = User::where('is_banned', true)->get();

    if ($bannedUsers->isEmpty()) {
        return response()->json(['message' => 'No banned users found'], 404);
    }

    return response()->json(['banned_users' => $bannedUsers], 200);
}


public function getAllActiveWorkers()
{
    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $workers = User::where('role', 'worker')->notBanned()->get();

    if ($workers->isEmpty()) {
        return response()->json(['message' => 'No active (non-banned) workers found'], 404);
    }

    return response()->json(['workers' => $workers], 200);
}


public function getBannedUsersByRole(Request $request)
{

    if (JWTAUTH::user()->role !== 'admin') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }


    $role = $request->query('role');
    if (!$role || !in_array($role, ['admin', 'worker', 'user'])) {
        return response()->json(['message' => 'Invalid or missing role parameter'], 400);
    }


    $bannedUsers = User::where('role', $role)->banned()->get();

    if ($bannedUsers->isEmpty()) {
        return response()->json(['message' => "No banned users found for role {$role}"], 404);
    }

    return response()->json(['banned_users' => $bannedUsers], 200);
}

public function getAllUsers()
{
    $users = User::all();
    return response()->json($users);
}





}
