import 'package:first_project/snackBar.dart';
import 'package:flutter/material.dart';
import 'dio_helper.dart';
class edite extends StatelessWidget {
  final String id;
  final String name;
  TextEditingController detailsController = TextEditingController();

  edite({super.key, required this.id, required this.name});
  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> editOrder({required details,required id,required itemName,required context }) async {
    await DioHelper.updateData(url: 'api/update/'+id, data: {
      'item_name':itemName,
      'details':details
    }).then((value) {
      print(value.data);
      print("edit order  Successfully");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      showCustomSnackBar(context, 'edit order completed successfully!', true);
    }).catchError((error) {
      print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      Navigator.pop(context);
      print(error);
      showCustomSnackBar(context, 'An error occurred during the add order .', false);
    });
  }
  Future<void> deleteOrder({required id,required context }) async {
    await DioHelper.DeleteData(url: 'api/delete/'+id).then((value) {
      print(value.data);
      print("delete order  Successfully");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      showCustomSnackBar(context, 'delete order completed successfully!', true);
    }).catchError((error) {
      print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(error);
      showCustomSnackBar(context, 'An error occurred during the delete order .', false);
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
                prefixIcon: const Icon(Icons.note),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _showPayConfirmationDialog(context);
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
                "Pay",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    editOrder(details: detailsController.text, id:id.toString(), itemName: name.toString(), context: context);
                    //  _showSaveConfirmationDialog(context);
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
                    "Save Changes",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteOrder(id: id, context: context);
                   // _showDeleteConfirmationDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Save Changes"),
          content: const Text("Are you sure you want to save the changes?"),
          actions: [
            TextButton(
              onPressed: () {
                // editOrder(details: detailsController.text, id:id.toString(), itemName: name.toString(), context: context);
                // Navigator.of(context).pop();
                // Navigator.pop(context);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Order updated successfully!"),
                //   ),
                // );
              },
              child: const Text("Save"),
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

  void _showPayConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Payment"),
          content:
          const Text("Are you sure you want to proceed with the payment?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Payment done successfully!"),
                  ),
                );
              },
              child: const Text("Pay"),
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Order"),
          content: const Text("Are you sure you want to delete this order?"),
          actions: [
            TextButton(
              onPressed: () {
                deleteOrder(id: id, context: context);
                // Navigator.of(context).pop();
                // Navigator.pop(context);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Order deleted successfully!"),
                //   ),
                // );
              },
              child: const Text("Delete"),
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
