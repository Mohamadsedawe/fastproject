<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use JWTFactory;
use JWTAuth;

class loginController extends Controller
{
    public function loginpost(Request $request)
{

    $validator = Validator::make($request->all(), [
        'email' => ['required', 'email'],
        'password' => ['required'],
    ]);

    if ($validator->fails()) {
        return response()->json([
            'message' => 'Validation failed',
            'errors' => $validator->errors()
        ], 422);
    }


    $credentials = $request->only('email', 'password');

    try {

        if (!$token = JWTAuth::attempt($credentials)) {
            return response()->json([
                'message' => 'Invalid email or password'
            ], 401);
        }
    } catch (JWTException $e) {
        return response()->json([
            'message' => 'Could not create token',
            'error' => $e->getMessage()
        ], 500);
    }


    return response()->json([
        'token' => $token,
        'token_type' => 'bearer',
        'expires_in' => auth('api')->factory()->getTTL() * 60
    ]);
}



    public function registerpost(Request $request)
    {
       $validator=validator::make($request->all(),[
            'firstname' => 'required',
            'lastname' => 'required',
            'address' => 'required',
            'phone_number' => 'required|digits:14',
            'email' => ['required', 'email', Rule::unique('users')],
            'password' => 'required|min:5',
        ]);

        if($validator ->fails()){
            return response()->json($validator->errors());
        }
        $data['firstname']=$request->firstname;
        $data['lastname']=$request->lastname;
        $data['address']=$request->address;
        $data['phone_number']=$request->phone_number;
        $data['email']=$request->email;
        $data['password']=Hash::make($request->password);

        $data = $request->only(['firstname', 'lastname', 'address', 'phone_number', 'email']);
        $data['password'] = Hash::make($request->password);
         $data['role'] = 'user';

        $user = User::create($data);
       $token=JWTAuth::fromUser($user);

        return response()->json(compact ('token'));
    }

    function logout (Request $request){

        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
     }
     public function edit(){
        $user = Auth::user();
        return view('product.edit', compact('user'));
    }
    public function update(Request $request){

        $request->validate([
            'firstname' => ['required'],
            'lastname' =>[ 'required'],
            'address' => ['required'],
            'phone_number'  => ['required', 'digits:14'],
            'email' =>[ 'required '],
            'password' => 'required|min:5',
        ]);
        $userid = JWTAUTH::user()->id;


    $user=User::findorfail($userid);
    if(!$user)
     {return response()->json(['message' , 'user is not found'], 404);
    }
    $user->firstname=$request->firstname;
    $user->lastname=$request->lastname;
    $user->address=$request->address;
    $user->phone_number=$request->phone_number;
    $user->email=$request->email;
    $user->password = bcrypt($request->password);
    $user->save();


    return response()->json(['message' => 'user update is successful'], 200);


    }
    public function delete(Request $request) {

        $userid = JWTAUTH::user()->id;

        $user = User::findOrFail($userid);
        if (!$user) {
            return response()->json(['message' => 'user is not found'], 404);
        }

        $user->delete();

        return response()->json(['message' => 'user has been deleted successfully'], 200);
    }



}
