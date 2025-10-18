import 'package:flutter/material.dart';

import '../models/market_price_model.dart';
import '../utils/app_constants.dart';

class MarketPricesScreen extends StatefulWidget {
  const MarketPricesScreen({super.key});

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> 
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<MarketPrice> _prices;
  late PriceForecast _forecast;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadMockData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    _prices = [
      MarketPrice(
        commodity: 'Maize',
        currentPrice: 0.85,
        previousPrice: 0.82,
        change: 0.03,
        changePercent: 3.66,
        date: DateTime.now(),
        unit: 'per kg',
        region: 'Kampala',
      ),
      MarketPrice(
        commodity: 'Rice',
        currentPrice: 1.20,
        previousPrice: 1.18,
        change: 0.02,
        changePercent: 1.69,
        date: DateTime.now(),
        unit: 'per kg',
        region: 'Kampala',
      ),
      MarketPrice(
        commodity: 'Beans',
        currentPrice: 1.50,
        previousPrice: 1.45,
        change: 0.05,
        changePercent: 3.45,
        date: DateTime.now(),
        unit: 'per kg',
        region: 'Kampala',
      ),
      MarketPrice(
        commodity: 'Coffee',
        currentPrice: 3.20,
        previousPrice: 3.25,
        change: -0.05,
        changePercent: -1.54,
        date: DateTime.now(),
        unit: 'per kg',
        region: 'Kampala',
      ),
    ];

    _forecast = PriceForecast(
      commodity: 'Maize',
      forecastData: [
        PricePoint(
          date: DateTime.now().add(const Duration(days: 7)),
          predictedPrice: 0.88,
        ),
        PricePoint(
          date: DateTime.now().add(const Duration(days: 14)),
          predictedPrice: 0.92,
        ),
        PricePoint(
          date: DateTime.now().add(const Duration(days: 21)),
          predictedPrice: 0.95,
        ),
      ],
      confidence: 'high',
      forecastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices & Forecasting'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Tab Bar for Local | Regional | Export
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Local'),
              Tab(text: 'Regional'),
              Tab(text: 'Export'),
            ],
            labelColor: AppConstants.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppConstants.primaryColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Price Chart
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
                                  'Maize Prices (6 months)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: 'Maize',
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Maize',
                                      child: Text('Maize'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Rice',
                                      child: Text('Rice'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Beans',
                                      child: Text('Beans'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    // Handle commodity change
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 250,
                              child: _buildPriceChart(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // AI Insights Panel (Bottom Card)
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '🤖 AI Insights',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Best Time to Sell ${_forecast.commodity}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Prices predicted to rise ${(0.95 - 0.85) / 0.85 * 100}% in 3 weeks. Consider holding.',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        // Set price alert
                                      },
                                      icon: const Icon(Icons.notifications),
                                      label: const Text('Price Alert'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppConstants.primaryColor,
                                        side: BorderSide(color: AppConstants.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        // View full analysis
                                      },
                                      icon: const Icon(Icons.analytics),
                                      label: const Text('Analysis'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppConstants.primaryColor,
                                        side: BorderSide(color: AppConstants.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Favorite Crops List
                    const Text(
                      'Favorite Crops',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _prices.length,
                      itemBuilder: (context, index) {
                        final price = _prices[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            title: Text(
                              price.commodity,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${AppHelpers.formatCurrency(price.currentPrice)} ${price.unit}',
                            ),
                            trailing: Text(
                              '${price.change > 0 ? '+' : ''}${AppHelpers.formatPercentage(price.changePercent)}',
                              style: TextStyle(
                                color: price.change >= 0 
                                    ? AppConstants.successColor 
                                    : AppConstants.dangerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
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

  Widget _buildPriceChart() {
    if (_forecast.forecastData.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final maxValue = _forecast.forecastData.map((p) => p.predictedPrice).reduce((a, b) => a > b ? a : b);
    final minValue = _forecast.forecastData.map((p) => p.predictedPrice).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue != 0 ? (maxValue - minValue) : 1.0;

    return CustomPaint(
      size: Size(double.infinity, 200),
      painter: PriceChartPainter(
        data: _forecast.forecastData,
        color: AppConstants.primaryColor,
        maxValue: maxValue,
        minValue: minValue,
        range: range,
      ),
    );
  }
}

class PriceChartPainter extends CustomPainter {
  final List<PricePoint> data;
  final Color color;
  final double maxValue;
  final double minValue;
  final double range;

  PriceChartPainter({
    required this.data,
    required this.color,
    required this.maxValue,
    required this.minValue,
    required this.range,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final x = (i * size.width) / (data.length - 1);
      final normalizedValue = data[i].predictedPrice - minValue;
      final y = size.height - (normalizedValue / range) * size.height;
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