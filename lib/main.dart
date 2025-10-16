import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/farmer_dashboard_screen.dart';
import 'screens/group_dashboard_screen.dart';
import 'screens/agronomist_dashboard_screen.dart';
import 'screens/advisory_screen.dart';
import 'screens/yield_prediction_screen.dart';
import 'screens/market_prices_screen.dart';
import 'screens/credit_scoring_screen.dart';
import 'screens/chatbot_screen.dart';
import 'models/farmer_model.dart';
import 'models/group_model.dart';
import 'models/agronomist_model.dart';
import 'models/credit_score_model.dart';
import 'services/app_state.dart';
import 'utils/app_constants.dart';
import 'utils/app_theme.dart';
import 'utils/localization.dart';

void main() {
  runApp(const AgroWorkbenchApp());
}

class AgroWorkbenchApp extends StatelessWidget {
  const AgroWorkbenchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState()..initialize(), // Initialize the app state
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'AgroWorkbench',
            theme: AppTheme.lightTheme, // Use our custom theme
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'), // English
              Locale('lg', ''),   // Luganda
              Locale('sw', ''),   // Swahili
            ],
            home: const LoginScreen(), // Start with login screen
            routes: {
              '/home': (context) => const HomeScreen(),
              '/home-dashboard': (context) => Consumer<AppState>(
                builder: (context, appState, child) {
                  final user = appState.user;
                  if (user != null) {
                    return HomeDashboardScreen(user: user);
                  } else {
                    // If no user, redirect to home screen
                    return const HomeScreen();
                  }
                },
              ),
              '/farmer-dashboard': (context) => FarmerDashboardScreen(
                farmer: ModalRoute.of(context)?.settings.arguments as Farmer ??
                    // Create a mock farmer for demo purposes
                    Farmer(
                      id: 'mock',
                      name: 'Demo Farmer',
                      phone: '+256123456789',
                      location: const Location(lat: 0.3476, lng: 32.5825),
                      crops: const [],
                      acreage: 2.5,
                    ),
              ),
              '/group-dashboard': (context) => GroupDashboardScreen(
                group: FarmerGroup(
                  id: 'mock',
                  name: 'Demo Group',
                  memberIds: const [],
                  totalLand: 150.0,
                  totalSavings: 5000.0,
                  leaderId: 'mock',
                  activities: const [],
                  createdAt: DateTime.now(),
                ),
                members: const [],
              ),
              '/agronomist-dashboard': (context) => AgronomistDashboardScreen(
                agronomist: Agronomist(
                  id: 'mock',
                  name: 'Demo Agronomist',
                  phone: '+256987654321',
                  assignedFarmerIds: const [],
                  assignedGroupIds: const [],
                  totalAcres: 500.0,
                  totalFarmers: 15,
                  totalGroups: 3,
                  fieldVisits: const [],
                  createdAt: DateTime.now(),
                ),
                assignedFarmers: const [],
              ),
              '/advisory': (context) => const AdvisoryScreen(
                farmerId: 'mock',
                cropType: 'Maize',
              ),
              '/yield-prediction': (context) => const YieldPredictionScreen(
                farmerId: 'mock',
                cropType: 'Maize',
              ),
              '/market-prices': (context) => const MarketPricesScreen(),
              '/credit-scoring': (context) => CreditScoringScreen(
                creditScore: CreditScore(
                  score: 720,
                  rating: 'MEDIUM RISK',
                  breakdown: const [],
                  lastUpdated: DateTime.now(),
                  history: const [],
                ),
              ),
              '/chatbot': (context) => const ChatbotScreen(),
            },
          );
        },
      ),
    );
  }
}
