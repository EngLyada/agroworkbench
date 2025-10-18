import 'package:agroworkbench/screens/advisory.dart';
import 'package:agroworkbench/screens/homepage.dart';
import 'package:agroworkbench/screens/inputs.dart';
import 'package:agroworkbench/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badges;

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int currentIndex = 0;

  final pages = [
    const Homepage(),
    const AgroInputsScreen(),
    const AiAdvisoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool showAppBar = currentIndex == 0;

    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(2),
            bottomLeft: Radius.circular(2),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text("Farmer "),
              accountEmail: Text("075 XXXX - XXX"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(IconlyBold.profile, color: Colors.green, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.analytics_outlined),
              title: const Text("Farm Analytics"),
              subtitle: const Text("Monitor your yields & inputs"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.cloud_outlined),
              title: const Text("Weather Forecast"),
              subtitle: const Text("Track weather for your region"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.storefront_outlined),
              title: const Text("Nearby Agro Dealers"),
              subtitle: const Text("Find verified input suppliers"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.newspaper_outlined),
              title: const Text("Agri News & Updates"),
              subtitle: const Text("Stay informed on market trends"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text("Help & Support"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
          ],
        ),
      ),

      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Good Morning 🖐",
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    "Please enjoy our services",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton.filledTonal(
                    onPressed: () {},
                    icon: badges.Badge(
                      badgeContent: const Text(
                        "3",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      badgeStyle:
                          const badges.BadgeStyle(badgeColor: Colors.green),
                      position:
                          badges.BadgePosition.topEnd(top: -18, end: -14),
                      child: const Icon(IconlyBroken.notification),
                    ),
                  ),
                ),
              ],
            )
          : null,

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            activeIcon: Icon(IconlyBold.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.bag),
            activeIcon: Icon(IconlyBold.bag),
            label: "Agro Inputs",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.chat),
            activeIcon: Icon(IconlyBold.chat),
            label: "AI Advisory",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.profile),
            activeIcon: Icon(IconlyBold.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}