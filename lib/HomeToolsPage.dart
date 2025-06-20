import 'package:first_project/LoginPage.dart';
import 'package:first_project/editeprofile.dart';
import 'package:first_project/machine.dart';
import 'package:first_project/orderdeatiles.dart';
import 'package:first_project/shared_prefrenses_helper.dart';
import 'package:flutter/material.dart';
import 'OrderModel.dart';
import 'dio_helper.dart';

class HomeToolsPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Kitchen", "icon": Icons.kitchen},
  ];
  List<Order> order = [];
  void getOrders(BuildContext context) {
    order = [];
    DioHelper.getData(url: 'api/showorder').then((value) {
      List<dynamic> ordersJson = value.data['orders'];
      for (var orderJson in ordersJson) {
        order.add(Order.fromJson(orderJson));
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => orders(order: order)),
      );
    }).catchError((error) {
      print(error);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeToolsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Edite profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('my orders'),
              onTap: () {
                getOrders(context);
              },
                ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                _showConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => machine()),
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
                    Icon(
                      category["icon"],
                      size: 50,
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      category["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                CachHelper.removeData(key:'token');
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                 (Route<dynamic> route) => false,
                 );
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
