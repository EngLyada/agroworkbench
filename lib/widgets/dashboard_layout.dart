import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav_bar.dart';
import '../utils/app_constants.dart';

class DashboardLayout extends StatefulWidget {
  final String title;
  final Widget child;
  final int currentIndex;
  final Function(int) onTabSelected;

  const DashboardLayout({
    Key? key,
    required this.title,
    required this.child,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // Show language selection dialog
              _showLanguageDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTabSelected,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                ListTile(
                  title: const Text('English'),
                  selected: Localizations.localeOf(context).languageCode == 'en',
                  onTap: () {
                    // In a real app, you would change the locale here
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Luganda'),
                  selected: Localizations.localeOf(context).languageCode == 'lg',
                  onTap: () {
                    // In a real app, you would change the locale here
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Swahili'),
                  selected: Localizations.localeOf(context).languageCode == 'sw',
                  onTap: () {
                    // In a real app, you would change the locale here
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}