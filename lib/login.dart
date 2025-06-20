import 'package:flutter/material.dart';
import 'package:workerr/Home.dart';
import 'package:workerr/shared_prefrenses_helper.dart';
import 'package:workerr/snackBar.dart';
import 'dio_helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }

  Future<void> login({
    required String email,
    required String pass,
    required String rolee,
    required String keyy,
    required BuildContext context,
  }) async {
    try {
      final response = await DioHelper.postData(url: 'api/login/admin', data: {
        'email': email,
        'password': pass,
        'role': 'worker',
        'Key': 90980,
      });

      if (response.statusCode == 200 && response.data != null) {
        print(response.data);
        await CachHelper.saveData(key: 'token', value: response.data['token']);
        showCustomSnackBar(context, 'LogIn completed successfully!', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (error) {
      print('Login error: $error');
      showCustomSnackBar(context, 'An error occurred during the login.', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please log in to your account.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(
                    labelText: "Role",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: keyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Key",
                    prefixIcon: const Icon(Icons.vpn_key),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password feature
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty &&
                          roleController.text.isNotEmpty) {
                        login(
                          email: emailController.text,
                          pass: passController.text,
                          context: context,
                          rolee: roleController.text,
                          keyy: keyController.text,
                        );
                      } else {
                        showCustomSnackBar(context, 'Please fill all required fields.', false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
