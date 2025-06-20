import 'package:first_project/snackBar.dart';
import 'package:flutter/material.dart';
import 'dio_helper.dart';

class add extends StatelessWidget {
  String category;

  TextEditingController detailsController = TextEditingController();

  add({super.key,required this.category});
  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> addOrder({required details,required itemName,required context }) async {
    await DioHelper.postData(url: 'api/addorder', data: {
      'item_name':itemName,
      'details':details
    }).then((value) {
      print(value.data);
      print("add order  Successfully");
      showCustomSnackBar(context, 'add order completed successfully!', true);
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((error) {
      print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      Navigator.pop(context);
      print(error);
      showCustomSnackBar(context, 'An error occurred during the add order .', false);
    });
  }
  @override
  Widget build(BuildContext context) {
    print(category.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Your Order",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(
                labelText: "Please enter your order details",
                prefixIcon: const Icon(Icons.note),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Spacer(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              ElevatedButton(
                onPressed: () {
                 _showsubmitConfirmationDialog(context);
                },
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
                  ElevatedButton(
                    onPressed: () {
                      _showemergencyConfirmationDialog(context);
                    },
                    child: const Text('Emergency'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),

                      ),

                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _showsubmitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("submit Order"),
          content: const Text("Are you sure you want to save this order?"),
          actions: [
            TextButton(
              onPressed: () {
                addOrder(details:detailsController.text, itemName: category.toString(), context: context);
                // Navigator.of(context).pop();
                // Navigator.pop(context);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Order add successfully!"),
                //   ),
                // );
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
  void _showemergencyConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Emergency Order"),
          content: const Text("Are you sure you want to have an emergency order?it may cost you more"),
          actions: [
            TextButton(
              onPressed: () {
                addOrder(details:detailsController.text, itemName: category.toString(), context: context);
                // Navigator.of(context).pop();
                // Navigator.pop(context);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Order add successfully!"),
                //   ),
                // );
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
