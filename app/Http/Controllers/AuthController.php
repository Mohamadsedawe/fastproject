<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    function loginpost(Request $request):RedirectResponse {
        $validator = Validator::make($request->all(), [
            'email' => ['required', 'email'], // التأكد أن البريد الإلكتروني مطلوب وله صيغة صحيحة
            'password' => ['required'], // التأكد من وجود كلمة المرور
        ]);
           if($validator->fails()){
               return response()->json($validator->errors());
           }

       $credentials=$request->only('email', 'password');
   try{
       if(! $token=Auth::attempt($credentials)){
           return response()->json(['error' => 'invaild useername and password'],[401]);
       }
   }catch(Exception $e){
       return response()->json(['error' => 'cant create token '],[500]);
   }
   return response()->json(compact('token'));


      }


    public function registerpost(Request $request)
    {
       $validator=validator::make([
            'firstname' => 'required',
            'lastname' => 'required',
            'address' => 'required',
            'phone_number' => 'required|digits:13',
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

        $user = User::create($data);
        $token=Auth::fromuser($user);
       // $token = $user->createToken('API Token')->accessToken;

        return response()->json(compact ('token'));
    }

    function logout (Request $request): RedirectResponse{

        $request->session()->invalidate();

         $request->session()->regenerateToken();

         return redirect('/login');
     }
     public function edit(){
        $user = Auth::user();
        return view('product.edit', compact('user'));
    }
    public function update(Request $request, $userid){

        $request->validate([
            'firstname' => ['required'],
            'lastname' =>[ 'required'],
            'address' => ['required'],
            'phone_number'  => ['required', 'digits:13'],
            'email' =>[ 'required '],
            'password' => 'required|min:5',
        ]);
    $user=User::findorfail($userid);
    $user->firstname=$request->firstname;
    $user->lastname=$request->lastname;
    $user->address=$request->address;
    $user->phone_number=$request->phone_number;
    $user->email=$request->email;
    $user->password=$request->password;
    $user->save();
    if(!$user)
    {return redirect(route('product.edit')->with('error', ' update is not successfully'));
    }
    return redirect()->back()->with('success', ' update is not successfully');

    }
}
