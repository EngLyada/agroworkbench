import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class Roles extends StatelessWidget {
  const Roles({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      {
        "title": "Farmer",
        "icon": IconlyBold.user2,
        "color": Colors.green,
        "route": "/farmerDashboard",
        "description": "Access your personal farm analytics and market tools.",
      },
      {
        "title": "Agronomist",
        "icon": IconlyBold.work,
        "color": Colors.orange,
        "route": "/agronomistDashboard",
        "description": "Provide insights and manage your farmer clients.",
      },
      {
        "title": "Farmer Group",
        "icon": Icons.group,
        "color": Colors.blue,
        "route": "/groupDashboard",
        "description": "Manage your group’s farms, records, and finances.",
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome to Agrihub",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "What best describes you to personalize your farming experience ?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                itemCount: roles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final role = roles[index];
                  return GestureDetector(
                    onTap: () {
                       Navigator.pushNamed(context, role["route"] as String);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: (role["color"] as Color)
                                  .withOpacity(0.15),
                              radius: 30,
                              child: Icon(
                                role["icon"] as IconData,
                                color: role["color"] as Color,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    role["title"] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: role["color"] as Color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    role["description"] as String,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
