import 'package:flutter/material.dart';

import 'myordersmodel.dart';


class Myorders extends StatelessWidget {
  final List<Orders> myorders;

  const Myorders({Key? key, required this.myorders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY ORDERS')),
      body: ListView.builder(
        itemCount: myorders.length,
        itemBuilder: (context, index) {
          final order = myorders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('${order.itemName} ${order.userId}'),
              subtitle: Text('Email: ${order.details ?? "N/A"}\nPhone: ${order.createdAt ?? "N/A"}\nAddress: ${order.item ?? "N/A"}}'),
              isThreeLine: true,

            ),
          );
        },
      ),
    );
  }
}
