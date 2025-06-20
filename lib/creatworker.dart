import 'package:flutter/material.dart';
import 'package:webb/Home.dart';
import 'package:webb/snackBar.dart';
import 'dio_helper.dart';
class CreateWorker extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passconfController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  CreateWorker({super.key});

  void showCustomSnackBar(BuildContext context, String message,
      bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> signup({
    required String email,
    required String pass,
    required BuildContext context,
    required String firstname,
    required String lastname,
    required String address,
    required String phoneNumber,
    required String passconf,
    required String role,
    required String key,
  }) async {
    if (!RegExp(r"^\d{14}$").hasMatch(phoneNumber)) {
      showCustomSnackBar(context, 'Phone number must be 14 digits.', false);
      return;
    }

    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      showCustomSnackBar(context, 'Invalid email format.', false);
      return;
    }

    if (pass.length < 6) {
      showCustomSnackBar(context, 'Password must be at least 6 characters.', false);
      return;
    }

    if (pass != passconf) {
      showCustomSnackBar(context, 'Passwords do not match.', false);
      return;
    }

    await DioHelper.postData(
        url: 'api/create/admin',
        data: {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': pass,
          'address': address,
          'phone_number': phoneNumber,
          'password_confirmation': passconf,
          'role': role,
          'admin_key': key,


        }).then((value) {
      print(value.data);
      showCustomSnackBar(context, 'Create account completed successfully!', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
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
      appBar: AppBar(title: const Text("Create Worker Account")),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Text(
                "Please Sign Up",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: fnameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: lnameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: numController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passconfController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: "Role ",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: keyController,
                decoration: InputDecoration(
                  labelText: "worker Key ",
                  prefixIcon: const Icon(Icons.vpn_key),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showCreateWorkerConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Create Account", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );

  }
  void _showCreateWorkerConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("create account"),
          content: const Text("Are you sure you want to craete the acount?"),
          actions: [
            TextButton(
              onPressed: () {
                signup(
                  email: emailController.text,
                  pass: passController.text,
                  context: context,
                  firstname: fnameController.text,
                  lastname: lnameController.text,
                  address: locationController.text,
                  phoneNumber: numController.text,
                  role: roleController.text,
                  key: keyController.text,
                  passconf: passconfController.text,
                );
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
