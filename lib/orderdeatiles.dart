import 'package:first_project/OrderModel.dart';
import 'package:first_project/editeorder.dart';
import 'package:flutter/material.dart';
class orders extends StatelessWidget {
  final List<Order>   order;

  const orders({super.key, required this.order});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my orders'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: order.length,
          itemBuilder: (context, index) {
            final myOrder = order[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => edite(id: myOrder.id.toString(), name: myOrder.itemName.toString())),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 50,
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      myOrder.itemName.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        myOrder.details.toString(),
                        style:  TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            );
          },
        ),
      ),
    );
  }
}
