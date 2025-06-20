import 'package:flutter/material.dart';
import 'package:webb/unbanmodel.dart';

class Unblocked extends StatelessWidget {
  final List<Workers> workers;

  const Unblocked({Key? key, required this.workers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unbanned workers')),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('${worker.firstname} ${worker.lastname}'),
              subtitle: Text('Email: ${worker.email ?? "N/A"}\nPhone: ${worker.phoneNumber ?? "N/A"}\nAddress: ${worker.address ?? "N/A"}}'),
              isThreeLine: true,

            ),
          );
        },
      ),
    );
  }
}
