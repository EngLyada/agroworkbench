import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/farmer_model.dart';
import '../models/user_model.dart';
import '../services/app_state.dart';
import '../utils/app_constants.dart';

// Common home screen for all user types with role selection
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedRole = 'farmer'; // Default to farmer

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroWorkbench'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to AgroWorkbench',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Select your role to continue:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ChoiceChip(
                    label: const Text('Individual Farmer'),
                    selected: selectedRole == 'farmer',
                    onSelected: (selected) {
                      setState(() {
                        selectedRole = 'farmer';
                      });
                    },
                    selectedColor: AppConstants.primaryColor.withOpacity(0.2),
                  ),
                  ChoiceChip(
                    label: const Text('Farmer Group'),
                    selected: selectedRole == 'group',
                    onSelected: (selected) {
                      setState(() {
                        selectedRole = 'group';
                      });
                    },
                    selectedColor: AppConstants.primaryColor.withOpacity(0.2),
                  ),
                  ChoiceChip(
                    label: const Text('Agronomist'),
                    selected: selectedRole == 'agronomist',
                    onSelected: (selected) {
                      setState(() {
                        selectedRole = 'agronomist';
                      });
                    },
                    selectedColor: AppConstants.primaryColor.withOpacity(0.2),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Create and save user based on selected role
                  final user = User(
                    id: 'user-${DateTime.now().millisecondsSinceEpoch}',
                    name: 'Demo User',
                    phone: '+256123456789',
                    role: selectedRole == 'farmer' 
                        ? UserRole.farmer 
                        : selectedRole == 'group' 
                            ? UserRole.group 
                            : UserRole.agronomist,
                    createdAt: DateTime.now(),
                  );
                  
                  appState.updateUser(user);
                  
                  // Navigate to appropriate dashboard based on role
                  switch (selectedRole) {
                    case 'farmer':
                      Navigator.pushReplacementNamed(context, '/home-dashboard');
                      break;
                    case 'group':
                      Navigator.pushReplacementNamed(context, '/home-dashboard');
                      break;
                    case 'agronomist':
                      Navigator.pushReplacementNamed(context, '/home-dashboard');
                      break;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor, // Primary green
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
                child: const Text(
                  'Continue to Dashboard',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 24),
              // Guest mode option
              TextButton(
                onPressed: () {
                  // Navigate to guest dashboard
                  // For demo purposes, we'll go to farmer dashboard
                  Navigator.pushReplacementNamed(context, '/farmer-dashboard', arguments: 
                    Farmer(
                      id: 'guest-${DateTime.now().millisecondsSinceEpoch}',
                      name: 'Guest User',
                      phone: '+256000000000',
                      location: const Location(lat: 0.3476, lng: 32.5825),
                      crops: const [
                        Crop(id: 'crop1', name: 'Maize', type: 'grain'),
                      ],
                      acreage: 1.0,
                    )
                  );
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(color: Color(0xFF10B981)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}