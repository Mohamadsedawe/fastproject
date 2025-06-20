import 'package:flutter/material.dart';
import 'WorkerModel.dart';
import 'Deatiles.dart';
class WorkerAccountsPage extends StatelessWidget {
  final List<Workers> workers;

  const WorkerAccountsPage({Key? key, required this.workers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Worker Accounts')),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('${worker.firstname} ${worker.lastname}'),
              subtitle: Text('Email: ${worker.email ?? "N/A"}\nPhone: ${worker.phoneNumber ?? "N/A"}\nAddress: ${worker.address ?? "N/A"}\nBanned: ${worker.isBanned ?? "N/A"}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.info_outline),
                tooltip: 'View Details',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        id: worker.id.toString(),
                        email: worker.email ?? '',
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
