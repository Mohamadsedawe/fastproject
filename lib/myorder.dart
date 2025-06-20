import 'package:flutter/material.dart';
import 'package:workerr/acceptorder.dart';

import 'OrderModel.dart';




class Allorders extends StatelessWidget {
  final List<Order> me;

  const Allorders({Key? key, required this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY ORDERS')),
      body: ListView.builder(
        itemCount: me.length,
        itemBuilder: (context, index) {
          final order = me[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('${order.itemName} ${order.userId}'),
              subtitle: Text('Email: ${order.details ?? "N/A"}\nPhone: ${order.itemName ?? "N/A"}\nAddress: ${order.userId ?? "N/A"}}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.info_outline),
                tooltip: 'View Details',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => accept(id: '', name: '',

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
