import 'package:flutter/material.dart';
import 'package:webb/snackBar.dart';
import 'dio_helper.dart';


class remove extends StatefulWidget {
  final String id;
  final String email;

  const remove({Key? key, required this.id, required this.email}) : super(key: key);



  @override
  State<remove> createState() => _removeState();
}

class _removeState extends State<remove> {
  final TextEditingController detailsController = TextEditingController();

  void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(message, isSuccess),
    );
  }
  Future<void> removebanWorker({required String id}) async {
    try {
      final response = await DioHelper.postData(url: 'api/admin/unban/$id', data: {
      });
      print(response.data);
      print("UnBan worker successfully");

      if (mounted) Navigator.pop(context);

      showCustomSnackBar(context, 'UnBan worker completed successfully!', true);
    } catch (error) {
      print('Error banning worker: $error');
      showCustomSnackBar(context, 'An error occurred during Unbanning worker.', false);
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
        title: const Text('UnBan worker'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          _showUnBanConfirmationDialog(
            context: context,
            title: 'Confirm UnBan',
            content: 'Are you sure you want to Unban this user?',
            onConfirm: () async {
              Navigator.of(context).pop(); // close dialog first
              await removebanWorker(id: widget.id);
            },
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        child: const Text('UnBan'),
      ),
    ],
    ),
    ),
    );
  }

  void _showUnBanConfirmationDialog({
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
          TextButton(onPressed: onConfirm, child: const Text("UnBan")),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
