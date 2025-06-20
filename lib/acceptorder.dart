import 'package:workerr/snackBar.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'dio_helper.dart';

class accept extends StatelessWidget {
  final String id;
  final String name;
  TextEditingController detailsController = TextEditingController();

  accept({super.key, required this.id, required this.name});

  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> Acceptorder({

    required BuildContext context,

  }) async {
  await DioHelper.updateData(
  url: 'api/orders/$id/handle',
  data: {



  }).then((value) {
  print(value.data);
  showCustomSnackBar(context, 'edite account completed successfully!', true);
  Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => Home()),
  );
  }).catchError((error) {
  print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
  print(error);
  showCustomSnackBar(context, 'An error occurred during the account edition.', false);
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You can edit Your Order!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(
                labelText: "Edit your order details",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _showacceptConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Accept",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Acceptorder( context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ), child: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
void _showacceptConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm aceepting"),
          content:
          const Text("Are you sure you want to accept this order?"),
          actions: [
            TextButton(
              onPressed: () {
                Acceptorder(context: context);
                Navigator.of(context).pop();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("order accepted successfully!"),
                  ),
                );
              },
              child: const Text("Accept"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  }

