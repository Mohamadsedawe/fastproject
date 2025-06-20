import 'package:flutter/material.dart';
import 'addrequest.dart';
class machine extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Washing Machine", "icon": Icons.local_laundry_service},
    {"name": " Microwave", "icon": Icons.microwave},
    {"name": " Refrigerator", "icon": Icons.kitchen_sharp},
    {"name": " Dishwasher", "icon": Icons.water_drop}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machines'),
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
                  MaterialPageRoute(builder: (context) => add(category: category["name"])),
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
}
