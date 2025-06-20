import 'package:first_project/HomeToolsPage.dart';
import 'package:first_project/SignUpPage.dart';
import 'package:first_project/shared_prefrenses_helper.dart';
import 'package:first_project/snackBar.dart';
import 'package:flutter/material.dart';

import 'dio_helper.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> login({required String email, required String pass, required BuildContext context}) async {
    try {
      final response = await DioHelper.postData(url: 'api/login', data: {
        'email': email,
        'password': pass
      });

      if (response.statusCode == 200 && response.data != null) {
        print(response.data);
        await CachHelper.saveData(key: 'token', value: response.data['token']);
        print("tokeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen");
        print(CachHelper.getData(key: 'token'));
        showCustomSnackBar(context, 'LogIn completed successfully!', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeToolsPage()),
        );
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (error) {
      print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(error);
      showCustomSnackBar(context, 'An error occurred during the login.', false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please log in to your account.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: " please enter your Email ",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print(emailController.text);
                    print(passController.text);
                    if(emailController.text.isNotEmpty &&passController.text.isNotEmpty ){
                      login(email:emailController.text, pass:passController.text, context: context);
                    } else{
                      showCustomSnackBar(context, 'Enter email and password please.', false);
                    }


                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
