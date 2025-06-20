import 'package:flutter/material.dart';

import 'package:workerr/myorder.dart';
import 'package:workerr/shared_prefrenses_helper.dart';
import 'package:workerr/showmyorders.dart';

import 'OrderModel.dart';

import 'dio_helper.dart';
import 'login.dart';
import 'myordersmodel.dart';

class Home extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "All Orders", "icon": Icons.shopping_basket},
    {"name": "My Orders", "icon": Icons.shopping_basket_outlined},

  ];
  void getorders(BuildContext context) {
    DioHelper.getData(url: 'api/showorder').then((value) {
      print("API Response: ${value.data}");

      final response = Orderi.fromJson(value.data);
      if (response.orderss != null && response.orderss!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Allorders(me: response.orderss!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No orders found.")),
        );
      }
    }).catchError((error) {
      print("Error fetching orders: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load orders.")),
      );
    });
  }
  void showorders(BuildContext context) {
    DioHelper.getData(url: 'api/worker/orders/accepted').then((value) {
      print("API Response: ${value.data}");

      final response = myorder.fromJson(value.data);

      if (response.orders != null && response.orders!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Myorders(myorders: response.orders!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No orders found.")),
        );
      }
    }).catchError((error) {
      print("Error fetching orders: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load orders.")),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('worker page'),
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
                Navigator.pop(context);
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;

          if (constraints.maxWidth >= 1200) {
            crossAxisCount = 5;
          } else if (constraints.maxWidth >= 900) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 3;
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        if (category["name"] == "All Orders") {
                          getorders(context);
                        } else if (category["name"] == "My Orders") {
                          showorders(context);
                        }
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
                              size: 60,
                              color: Colors.purple,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              category["name"],
                              style: const TextStyle(
                                fontSize: 20,
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
            ),
          );
        },
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
                CachHelper.removeData(key: 'token');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
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
