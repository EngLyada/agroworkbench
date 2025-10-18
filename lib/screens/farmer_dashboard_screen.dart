import 'package:flutter/material.dart';

import '../widgets/responsive_wrapper.dart';
import '../models/farmer_model.dart';
import '../models/credit_score_model.dart';
import '../models/yield_prediction_model.dart';
import '../models/advisory_model.dart';
import '../models/weather_model.dart';
import '../models/input_order_model.dart';
import '../utils/app_constants.dart';

class FarmerDashboardScreen extends StatefulWidget {
  final Farmer farmer;
  
  const FarmerDashboardScreen({super.key, required this.farmer});

  @override
  State<FarmerDashboardScreen> createState() => _FarmerDashboardScreenState();
}

class _FarmerDashboardScreenState extends State<FarmerDashboardScreen> {
  // Mock data for demonstration
  late CreditScore _creditScore;
  late List<YieldPrediction> _yieldPredictions;
  late List<Advisory> _advisories;
  late WeatherData _weatherData;
  late List<InputOrder> _inputOrders;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock credit score
    _creditScore = CreditScore(
      score: 720,
      rating: 'MEDIUM RISK',
      breakdown: [
        ScoreBreakdown(category: 'Productivity', weight: 40, score: 85, status: 'Good'),
        ScoreBreakdown(category: 'Consistency', weight: 30, score: 75, status: 'Average'),
        ScoreBreakdown(category: 'Input Usage', weight: 20, score: 90, status: 'Excellent'),
        ScoreBreakdown(category: 'Payment History', weight: 10, score: 80, status: 'Good'),
      ],
      lastUpdated: DateTime.now(),
      history: [
        CreditHistory(date: DateTime.now().subtract(const Duration(days: 30)), scoreChange: 15, reason: 'Loan payment'),
        CreditHistory(date: DateTime.now().subtract(const Duration(days: 60)), scoreChange: -5, reason: 'Late payment'),
      ],
    );

    // Mock yield predictions
    _yieldPredictions = [
      YieldPrediction(
        farmerId: widget.farmer.id,
        crop: 'Maize',
        predictedYield: 3.5,
        unit: 'tons/acre',
        confidence: 0.85,
        factors: [
          Factor(name: 'Rainfall', value: 0.9, impact: 'positive'),
          Factor(name: 'Soil Quality', value: 0.8, impact: 'positive'),
          Factor(name: 'Fertilizer', value: 0.7, impact: 'positive'),
        ],
      ),
    ];

    // Mock advisories
    _advisories = [
      Advisory(
        id: '1',
        farmerId: widget.farmer.id,
        crop: 'Maize',
        stage: 'Vegetative',
        recommendations: [
          'Apply nitrogen fertilizer at 2-week intervals',
          'Monitor for stem borer infestation',
          'Ensure adequate soil moisture'
        ],
        confidence: 0.92,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Advisory(
        id: '2',
        farmerId: widget.farmer.id,
        crop: 'Beans',
        stage: 'Flowering',
        recommendations: [
          'Apply phosphorus fertilizer',
          'Control aphid infestation',
          'Maintain soil pH between 6.0-7.0'
        ],
        confidence: 0.88,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    // Mock weather data
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

    // Mock input orders
    _inputOrders = [
      InputOrder(
        id: '1',
        farmerId: widget.farmer.id,
        inputType: 'Fertilizer',
        inputName: 'NPK 15-15-15',
        quantity: 2,
        unit: 'bags',
        unitPrice: 45.0,
        totalPrice: 90.0,
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        status: 'delivered',
        deliveryAddress: 'Farm Location',
      ),
      InputOrder(
        id: '2',
        farmerId: widget.farmer.id,
        inputType: 'Seeds',
        inputName: 'Maize Hybrid',
        quantity: 5,
        unit: 'kg',
        unitPrice: 12.0,
        totalPrice: 60.0,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        status: 'shipped',
        deliveryAddress: 'Farm Location',
      ),
    ];
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
        title: const Text('Farmer Dashboard'),
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
          padding: ResponsiveWrapper.getResponsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Summary - Total Savings and Total Land
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppHelpers.formatCurrency(1250.0),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Total Savings',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    Column(
                      children: [
                        Text(
                          '${widget.farmer.acreage} Acres',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Total Land',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick Actions (2 Rows × 2 Cards)
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
                  _buildQuickActionCard('Buy Inputs', Icons.shopping_cart, AppConstants.primaryColor),
                  _buildQuickActionCard('Get Services', Icons.build, AppConstants.secondaryColor),
                  _buildQuickActionCard('Markets', Icons.trending_up, AppConstants.warningColor),
                  _buildQuickActionCard('Profile', Icons.person, AppConstants.dangerColor),
                ],
              ),
              const SizedBox(height: 16),

              // Activity Summary Cards
              Text(
                'Activity Summary',
                style: TextStyle(
                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildActivityCard('Loan Outstanding', AppHelpers.formatCurrency(350.0)),
              const SizedBox(height: 8),
              _buildActivityCard('Insurance Policies', '2 Active'),
              const SizedBox(height: 8),
              _buildActivityCard('Agroinputs Ordered', '${_inputOrders.length} Items'),
              const SizedBox(height: 16),

              // Performance Section
              Text(
                'Performance',
                style: TextStyle(
                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Crop Performance Card
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Maize Performance',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            '85% vs target',
                            style: TextStyle(
                              color: AppConstants.successColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.85,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(AppConstants.successColor),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Target: 4 tons/acre | Actual: 3.4 tons/acre',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Market Prices Widget (mini chart)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Maize Prices',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${AppHelpers.formatCurrency(0.85)} / kg',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.trending_up,
                                color: AppConstants.successColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 80,
                        child: _buildMiniPriceChart(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Credit Score Meter
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Credit Score',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _creditScore.score.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppHelpers.getCreditScoreColor(_creditScore.score),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _creditScore.score / 1000,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppHelpers.getCreditScoreColor(_creditScore.score),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppHelpers.getCreditScoreStatus(_creditScore.score),
                        style: TextStyle(
                          color: AppHelpers.getCreditScoreColor(_creditScore.score),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Latest AI Advisory Feed
              Semantics(
                header: true,
                child: Text(
                  'Latest AI Advisory',
                  style: TextStyle(
                    fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _advisories.length,
                itemBuilder: (context, index) {
                  final advisory = _advisories[index];
                  return Semantics(
                    container: true,
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Semantics(
                                  header: true,
                                  child: Text(
                                    '${advisory.crop} - ${advisory.stage}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${(advisory.confidence * 100).toStringAsFixed(0)}% confidence',
                                  style: TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...advisory.recommendations.map((rec) => 
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: AppConstants.successColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        rec,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppHelpers.formatDateWithMonth(advisory.createdAt),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Compare Seasons Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to compare seasons screen
                  },
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('Compare Seasons'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return _buildDesktopLayout(); // Use same layout as desktop for tablet
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard'),
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
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home-dashboard');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.build),
                  title: const Text('Services'),
                  onTap: () {
                    Navigator.pushNamed(context, '/advisory');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Markets'),
                  onTap: () {
                    Navigator.pushNamed(context, '/market-prices');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    // Navigate to farmer profile
                  },
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: ResponsiveWrapper.getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Summary - Total Savings and Total Land
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                AppHelpers.formatCurrency(1250.0),
                                style: TextStyle(
                                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Total Savings',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: Colors.grey[300],
                          ),
                          Column(
                            children: [
                              Text(
                                '${widget.farmer.acreage} Acres',
                                style: TextStyle(
                                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Total Land',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left column - Quick Actions and Activity Summary
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Quick Actions (2x2 grid)
                              Text(
                                'Quick Actions',
                                style: TextStyle(
                                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.2,
                                children: [
                                  _buildQuickActionCard('Buy Inputs', Icons.shopping_cart, AppConstants.primaryColor),
                                  _buildQuickActionCard('Get Services', Icons.build, AppConstants.secondaryColor),
                                  _buildQuickActionCard('Markets', Icons.trending_up, AppConstants.warningColor),
                                  _buildQuickActionCard('Profile', Icons.person, AppConstants.dangerColor),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Activity Summary
                              Text(
                                'Activity Summary',
                                style: TextStyle(
                                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildActivityCard('Loan Outstanding', AppHelpers.formatCurrency(350.0)),
                              const SizedBox(height: 12),
                              _buildActivityCard('Insurance Policies', '2 Active'),
                              const SizedBox(height: 12),
                              _buildActivityCard('Agroinputs Ordered', '${_inputOrders.length} Items'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Right column - Performance and Advisory
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Performance Section
                              Text(
                                'Performance',
                                style: TextStyle(
                                  fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Crop Performance Card
                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Maize Performance',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Text(
                                            '85% vs target',
                                            style: TextStyle(
                                              color: AppConstants.successColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      LinearProgressIndicator(
                                        value: 0.85,
                                        backgroundColor: Colors.grey[300],
                                        valueColor: const AlwaysStoppedAnimation<Color>(AppConstants.successColor),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Target: 4 tons/acre | Actual: 3.4 tons/acre',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Market Prices Widget (mini chart)
                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Maize Prices',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${AppHelpers.formatCurrency(0.85)} / kg',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.trending_up,
                                                color: AppConstants.successColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        height: 100,
                                        child: _buildMiniPriceChart(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Credit Score Meter
                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Credit Score',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            _creditScore.score.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppHelpers.getCreditScoreColor(_creditScore.score),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      LinearProgressIndicator(
                                        value: _creditScore.score / 1000,
                                        backgroundColor: Colors.grey[300],
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppHelpers.getCreditScoreColor(_creditScore.score),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        AppHelpers.getCreditScoreStatus(_creditScore.score),
                                        style: TextStyle(
                                          color: AppHelpers.getCreditScoreColor(_creditScore.score),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Latest AI Advisory Feed (full width)
                    Text(
                      'Latest AI Advisory',
                      style: TextStyle(
                        fontSize: ResponsiveWrapper.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _advisories.length,
                      itemBuilder: (context, index) {
                        final advisory = _advisories[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${advisory.crop} - ${advisory.stage}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${(advisory.confidence * 100).toStringAsFixed(0)}% confidence',
                                      style: TextStyle(
                                        color: AppConstants.primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ...advisory.recommendations.map((rec) => 
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          size: 16,
                                          color: AppConstants.successColor,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            rec,
                                            style: const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppHelpers.formatDateWithMonth(advisory.createdAt),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Compare Seasons Button
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to compare seasons screen
                        },
                        icon: const Icon(Icons.bar_chart),
                        label: const Text('Compare Seasons'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
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
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String value) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniPriceChart() {
    // Simple line chart using CustomPaint
    return CustomPaint(
      size: Size(double.infinity, 80),
      painter: MiniLineChartPainter(
        data: [0.75, 0.78, 0.82, 0.80, 0.85],
        color: AppConstants.primaryColor,
      ),
    );
  }
}

class MiniLineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  MiniLineChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final points = <Offset>[];
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue != 0 ? maxValue - minValue : 1;

    for (int i = 0; i < data.length; i++) {
      final x = (i * size.width) / (data.length - 1);
      final y = size.height - ((data[i] - minValue) / range) * size.height;
      points.add(Offset(x, y));
    }

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    // Draw filled area under the line
    if (points.length > 1) {
      final fillPaint = Paint()
        ..color = color.withOpacity(0.2)
        ..style = PaintingStyle.fill;

      final path = Path();
      path.moveTo(points.first.dx, size.height);
      for (final point in points) {
        path.lineTo(point.dx, point.dy);
      }
      path.lineTo(points.last.dx, size.height);
      path.close();
      
      canvas.drawPath(path, fillPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}