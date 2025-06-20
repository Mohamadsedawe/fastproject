import 'package:flutter/material.dart';
import 'package:webb/Login.dart';
import 'package:webb/WorkerAccountsPage.dart';
import 'package:webb/banmodel.dart';
import 'package:webb/shared_prefrenses_helper.dart';
import 'package:webb/creatworker.dart';
import 'package:webb/unbanmodel.dart';
import 'package:webb/unbanworker.dart';
import 'package:webb/unblocked.dart';
import 'dio_helper.dart';
import 'WorkerModel.dart';

class Home extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Accounts", "icon": Icons.account_box},
    {"name": "Add worker", "icon": Icons.add_circle},
    {"name": "Show reports", "icon": Icons.ad_units_sharp},
    {"name": "Incentives", "icon": Icons.account_balance_wallet_rounded},
  ];

  void getWorkers(BuildContext context) {
    DioHelper.getData(url: 'api/show/admin').then((value) {
      print("API Response: ${value.data}");

      final response = WorkerResponse.fromJson(value.data);

      if (response.workers != null && response.workers!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkerAccountsPage(workers: response.workers!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No workers found.")),
        );
      }
    }).catchError((error) {
      print("Error fetching workers: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load workers.")),
      );
    });
  }
  void getUnban(BuildContext context) {
    DioHelper.getData(url: 'api/admin/active_workers?role=worker').then((value) {
      print("API Response: ${value.data}");

      final response = unban.fromJson(value.data);

      if (response.workers != null && response.workers!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Unblocked(workers: response.workers!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No workers found.")),
        );
      }
    }).catchError((error) {
      print("Error fetching workers: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load workers.")),
      );
    });
  }
  void getban(BuildContext context) {
    DioHelper.getData(url: 'api/admin/banned-users?role=worker').then((value) {
      print("API Response: ${value.data}");

      final response = ban.fromJson(value.data);

      if (response.bannedUsers != null && response.bannedUsers!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => unbann(bannedUsers: response.bannedUsers!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No workers found.")),
        );
      }
    }).catchError((error) {
      print("Error fetching workers: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load workers.")),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
            ListTile(
              leading: const Icon(Icons.add_alert_rounded),
              title: const Text('Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('Banned accounts'),
              onTap: () {
                getban(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('UnBanned accounts'),
              onTap: () {
                getUnban(context);

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
                        if (category["name"] == "Accounts") {
                          getWorkers(context);
                        } else if (category["name"] == "Add worker") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateWorker()),
                          );
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
