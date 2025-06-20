import 'package:flutter/material.dart';
import 'package:webb/editeprofile.dart';
import 'package:webb/snackBar.dart';
import 'dio_helper.dart';


class Details extends StatefulWidget {
  final String id;
  final String email;

  const Details({Key? key, required this.id, required this.email}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController detailsController = TextEditingController();

  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }

  Future<void> deleteWorker({required String id}) async {
    try {
      final response = await DioHelper.DeleteData(url: 'api/delete/admin/$id');
      print(response.data);
      print("Delete worker successfully");

      if (mounted) Navigator.pop(context);

      showCustomSnackBar(context, 'Delete worker completed successfully!', true);
    } catch (error) {
      print('Error deleting worker: $error');
      showCustomSnackBar(context, 'An error occurred during deleting worker.', false);
    }
  }

  Future<void> banWorker({required String id}) async {
    try {
      final response = await DioHelper.postData(url: 'api/admin/ban/$id', data: {
      });
      print(response.data);
      print("Ban worker successfully");

      if (mounted) Navigator.pop(context);

      showCustomSnackBar(context, 'Ban worker completed successfully!', true);
    } catch (error) {
      print('Error banning worker: $error');
      showCustomSnackBar(context, 'An error occurred during banning worker.', false);
    }
  }

  @override
  void dispose() {
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => edite(id:widget.id
                    ),
                  ),
                );
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showDeleteConfirmationDialog(
                  context: context,
                  title: 'Confirm Delete',
                  content: 'Are you sure you want to delete this user?',
                  onConfirm: () async {
                    Navigator.of(context).pop(); // close dialog first
                    await deleteWorker(id: widget.id);
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showBanConfirmationDialog(
                  context: context,
                  title: 'Confirm Ban',
                  content: 'Are you sure you want to ban this user?',
                  onConfirm: () async {
                    Navigator.of(context).pop(); // close dialog first
                    await banWorker(id: widget.id);
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Ban'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: onConfirm, child: const Text("Delete")),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showBanConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: onConfirm, child: const Text("Ban")),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
