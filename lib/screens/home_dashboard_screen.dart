import 'package:flutter/material.dart';

import '../widgets/weather_widget.dart';
import '../widgets/alerts_widget.dart';
import '../widgets/responsive_wrapper.dart';
import '../models/weather_model.dart';
import '../models/user_model.dart';
import '../utils/app_constants.dart';

class HomeDashboardScreen extends StatefulWidget {
  final User user;

  const HomeDashboardScreen({super.key, required this.user});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentIndex = 0;
  
  // Mock data for demonstration
  late WeatherData _weatherData;
  late List<Alert> _alerts;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    _weatherData = WeatherData(
      temperature: 25.5,
      humidity: 65,
      rainfall: 5.2,
      condition: 'Partly Cloudy',
      windSpeed: 12.3,
      date: DateTime.now(),
      location: 'Kampala, Uganda',
      forecast: [
        ForecastDay(
          date: DateTime.now().add(const Duration(days: 1)),
          highTemp: 27.0,
          lowTemp: 18.0,
          condition: 'Sunny',
          rainfall: 0.0,
        ),
        ForecastDay(
          date: DateTime.now().add(const Duration(days: 2)),
          highTemp: 26.5,
          lowTemp: 19.0,
          condition: 'Rainy',
          rainfall: 8.0,
        ),
        ForecastDay(
          date: DateTime.now().add(const Duration(days: 3)),
          highTemp: 24.0,
          lowTemp: 17.0,
          condition: 'Cloudy',
          rainfall: 2.0,
        ),
      ],
    );

    _alerts = [
      Alert(
        id: '1',
        title: 'Pest Alert',
        description: 'Stem borers detected in maize fields. Apply Carbofuran.',
        type: 'pest warning',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
        priority: 'high',
      ),
      Alert(
        id: '2',
        title: 'Rainfall Prediction',
        description: 'Heavy rains expected in next 48 hours. Harvest crops soon.',
        type: 'rainfall',
        date: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
        priority: 'medium',
      ),
      Alert(
        id: '3',
        title: 'Market Price Spike',
        description: 'Maize prices increased by 8% this week.',
        type: 'price spike',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        priority: 'low',
      ),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate based on selected tab
    switch (index) {
      case 0: // Home - stay on current screen
        break;
      case 1: // Services
        Navigator.pushReplacementNamed(context, '/advisory');
        break;
      case 2: // Markets
        Navigator.pushReplacementNamed(context, '/market-prices');
        break;
      case 3: // Profile
        // Navigate to profile based on user role
        switch (widget.user.role) {
          case UserRole.farmer:
            Navigator.pushReplacementNamed(context, '/farmer-dashboard');
            break;
          case UserRole.group:
            Navigator.pushReplacementNamed(context, '/group-dashboard');
            break;
          case UserRole.agronomist:
            Navigator.pushReplacementNamed(context, '/agronomist-dashboard');
            break;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                'Welcome, ${widget.user.name}!',
                style: TextStyle(
                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getRoleSpecificMessage(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Weather Widget (current conditions + 3-day forecast)
              WeatherWidget(weatherData: _weatherData),
              const SizedBox(height: 16),

              // Critical Alerts Banner
              AlertsWidget(alerts: _alerts),
              const SizedBox(height: 16),

              // Quick Action Cards (4-card grid)
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildQuickActionCard(
                    '🌿 My Farm',
                    Icons.agriculture,
                    AppConstants.primaryColor,
                    () {
                      Navigator.pushReplacementNamed(
                        context, 
                        widget.user.role == UserRole.farmer 
                          ? '/farmer-dashboard' 
                          : widget.user.role == UserRole.group
                            ? '/group-dashboard'
                            : '/agronomist-dashboard'
                      );
                    },
                  ),
                  _buildQuickActionCard(
                    '📈 Market Prices',
                    Icons.trending_up,
                    AppConstants.secondaryColor,
                    () {
                      Navigator.pushNamed(context, '/market-prices');
                    },
                  ),
                  _buildQuickActionCard(
                    '🤖 AI Advisory',
                    Icons.auto_fix_high,
                    AppConstants.warningColor,
                    () {
                      Navigator.pushNamed(context, '/advisory');
                    },
                  ),
                  _buildQuickActionCard(
                    '💰 Credit Score',
                    Icons.credit_score,
                    AppConstants.dangerColor,
                    () {
                      // In a real app, we'd fetch the user's credit score
                      Navigator.pushNamed(context, '/credit-scoring');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Markets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return _buildDesktopLayout(); // Use same layout as desktop for tablet
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Dashboard'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.account_circle),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar for navigation
          Container(
            width: 250,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  selected: _currentIndex == 0,
                  onTap: () => _onTabSelected(0),
                ),
                ListTile(
                  leading: const Icon(Icons.build),
                  title: const Text('Services'),
                  selected: _currentIndex == 1,
                  onTap: () => _onTabSelected(1),
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Markets'),
                  selected: _currentIndex == 2,
                  onTap: () => _onTabSelected(2),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  selected: _currentIndex == 3,
                  onTap: () => _onTabSelected(3),
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: Padding(
              padding: ResponsiveWrapper.getResponsivePadding(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome message
                    Text(
                      'Welcome, ${widget.user.name}!',
                      style: TextStyle(
                        fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getRoleSpecificMessage(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Weather Widget (current conditions + 3-day forecast)
                    WeatherWidget(weatherData: _weatherData),
                    const SizedBox(height: 24),

                    // Critical Alerts Banner
                    AlertsWidget(alerts: _alerts),
                    const SizedBox(height: 24),

                    // Quick Action Cards (4-card grid)
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 4, // More columns on desktop
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.2, // Slightly rectangular cards
                      children: [
                        _buildQuickActionCard(
                          '🌿 My Farm',
                          Icons.agriculture,
                          AppConstants.primaryColor,
                          () {
                            Navigator.pushReplacementNamed(
                              context, 
                              widget.user.role == UserRole.farmer 
                                ? '/farmer-dashboard' 
                                : widget.user.role == UserRole.group
                                  ? '/group-dashboard'
                                  : '/agronomist-dashboard'
                            );
                          },
                        ),
                        _buildQuickActionCard(
                          '📈 Market Prices',
                          Icons.trending_up,
                          AppConstants.secondaryColor,
                          () {
                            Navigator.pushNamed(context, '/market-prices');
                          },
                        ),
                        _buildQuickActionCard(
                          '🤖 AI Advisory',
                          Icons.auto_fix_high,
                          AppConstants.warningColor,
                          () {
                            Navigator.pushNamed(context, '/advisory');
                          },
                        ),
                        _buildQuickActionCard(
                          '💰 Credit Score',
                          Icons.credit_score,
                          AppConstants.dangerColor,
                          () {
                            // In a real app, we'd fetch the user's credit score
                            Navigator.pushNamed(context, '/credit-scoring');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleSpecificMessage() {
    switch (widget.user.role) {
      case UserRole.farmer:
        return 'Manage your farm and get personalized recommendations';
      case UserRole.group:
        return 'Monitor your group performance and member activities';
      case UserRole.agronomist:
        return 'Oversee assigned farmers and provide expert guidance';
    }
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}