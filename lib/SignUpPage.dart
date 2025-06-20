import 'package:first_project/HomeToolsPage.dart';
import 'package:first_project/snackBar.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'dio_helper.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void showCustomSnackBar(BuildContext context, String message,
      bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> signUp({
    required String email,
    required String pass,
    required BuildContext context,
    required String firstname,
    required String lastname,
    required String address,
    required String phoneNumber,
  }) async {
    if (!RegExp(r"^\d{14}$").hasMatch(phoneNumber)) {
      showCustomSnackBar(context, 'Phone number must be 15 digits.', false);
      return;
    }

    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      showCustomSnackBar(context, 'Email must contain "@".', false);
      return;
    }

    if (pass.length < 6) {
      showCustomSnackBar(context, 'Password must be at least 6 characters.', false);
      return;
    }

    await DioHelper.postData(
        url: 'api/regester', data: {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': pass,
      'address': address,
      'phone_number': phoneNumber
    }).then((value) {
      print(value.data);
      showCustomSnackBar(context, 'Create account completed successfully!', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }).catchError((error) {
      print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(error);
      showCustomSnackBar(context, 'An error occurred during the account creation.', false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "please sign up",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 40),
                TextField(
                  controller: fnameController,
                  decoration: InputDecoration(
                    labelText: "  First name ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: lnameController,
                  decoration: InputDecoration(
                    labelText: "  Last name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "  Location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: numController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "  phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                    labelText: "enter new Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showcreateConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "create account",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showcreateConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("create account"),
          content: const Text("Are you sure you want to craete the acount?"),
          actions: [
            TextButton(
              onPressed: () {
                signUp(email: emailController.text,
                    pass: passController.text,
                    context: context,
                    firstname: fnameController.text,
                    lastname: lnameController.text,
                    address: locationController.text,
                    phoneNumber: numController.text);
              },
              child: const Text("yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("no"),
            ),
          ],
        );
      },
    );
  }
}
