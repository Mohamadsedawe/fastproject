import 'package:flutter/material.dart';
import 'package:webb/banmodel.dart';
import 'package:webb/removeban.dart';


class unbann extends StatelessWidget {
  final List<BannedUsers> bannedUsers;

  const unbann({Key? key, required this.bannedUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bannned Accounts')),
      body: ListView.builder(
        itemCount: bannedUsers.length,
        itemBuilder: (context, index) {
          final worker = bannedUsers[index];
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
                      builder: (context) => remove(
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
