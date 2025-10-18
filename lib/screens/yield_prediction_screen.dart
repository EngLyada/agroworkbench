import 'package:flutter/material.dart';

import '../models/yield_prediction_model.dart';
import '../utils/app_constants.dart';

class YieldPredictionScreen extends StatefulWidget {
  final String farmerId;
  final String cropType;
  
  const YieldPredictionScreen({super.key, required this.farmerId, required this.cropType});

  @override
  State<YieldPredictionScreen> createState() => _YieldPredictionScreenState();
}

class _YieldPredictionScreenState extends State<YieldPredictionScreen> {
  // Mock data for demonstration
  late YieldPrediction _prediction;
  late List<Factor> _factors;
  late List<HistoricalYieldData> _historicalYields;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    _prediction = YieldPrediction(
      farmerId: widget.farmerId,
      crop: widget.cropType,
      predictedYield: 3.4,
      unit: 'tons/acre',
      confidence: 0.85,
      factors: [
        Factor(name: 'Rainfall', value: 0.9, impact: 'positive'),
        Factor(name: 'Soil Quality', value: 0.8, impact: 'positive'),
        Factor(name: 'Fertilizer', value: 0.7, impact: 'positive'),
        Factor(name: 'Pest Control', value: 0.6, impact: 'negative'),
        Factor(name: 'Temperature', value: 0.75, impact: 'positive'),
      ],
    );

    _factors = _prediction.factors;

    _historicalYields = [
      HistoricalYieldData(2022, 2.8),
      HistoricalYieldData(2023, 3.0),
      HistoricalYieldData(2024, 3.4), // Current prediction
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yield Prediction - ${widget.cropType}'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Predicted Yield Gauge (circular progress)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Predicted Yield',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox.expand(
                              child: CustomPaint(
                                painter: CircularGaugePainter(
                                  value: _prediction.predictedYield,
                                  max: 5.0, // Assume max possible yield is 5 tons/acre
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _prediction.predictedYield.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'tons/acre',
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confidence Level
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
                            'Confidence Level',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${(_prediction.confidence * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _prediction.confidence,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This prediction is based on historical data, current conditions, '
                        'and regional patterns. The higher the confidence, the more reliable the prediction.',
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

              // Comparison Bar Chart
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Comparison',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: _buildComparisonChart(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Input Update Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Update Inputs',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Current Growth Stage',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        initialValue: 'Vegetative',
                        items: const [
                          DropdownMenuItem(
                            value: 'Planting',
                            child: Text('Planting'),
                          ),
                          DropdownMenuItem(
                            value: 'Vegetative',
                            child: Text('Vegetative'),
                          ),
                          DropdownMenuItem(
                            value: 'Flowering',
                            child: Text('Flowering'),
                          ),
                          DropdownMenuItem(
                            value: 'Fruiting',
                            child: Text('Fruiting'),
                          ),
                          DropdownMenuItem(
                            value: 'Harvest',
                            child: Text('Harvest'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle growth stage change
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Fertilizer Applied (kg/acre)',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: '45',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Handle fertilizer amount change
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Irrigation Method',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        initialValue: 'Drip',
                        items: const [
                          DropdownMenuItem(
                            value: 'Drip',
                            child: Text('Drip'),
                          ),
                          DropdownMenuItem(
                            value: 'Sprinkler',
                            child: Text('Sprinkler'),
                          ),
                          DropdownMenuItem(
                            value: 'Furrow',
                            child: Text('Furrow'),
                          ),
                          DropdownMenuItem(
                            value: 'Rainfed',
                            child: Text('Rainfed'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle irrigation method change
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Recalculate prediction
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Recalculate Prediction'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Historical Yield Line Graph
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Historical Yields',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: _buildHistoricalChart(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Export PDF Report Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Export PDF functionality
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export PDF Report'),
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

  Widget _buildComparisonChart() {
    final data = [
      ComparisonData('Your Farm', _prediction.predictedYield),
      ComparisonData('Regional Avg', 3.0),
      ComparisonData('Top 10%', 3.8),
    ];
    
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: data.map((item) {
            final barWidth = (item.value / maxValue) * constraints.maxWidth * 0.8;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item.label,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: barWidth,
                            decoration: BoxDecoration(
                              color: AppConstants.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  item.value.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildHistoricalChart() {
    final maxValue = _historicalYields.map((h) => h.yield).reduce((a, b) => a > b ? a : b);
    final minValue = _historicalYields.map((h) => h.yield).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue != 0 ? (maxValue - minValue) : 1.0;

    return CustomPaint(
      size: Size(double.infinity, 100),
      painter: HistoricalChartPainter(
        data: _historicalYields,
        color: AppConstants.primaryColor,
        maxValue: maxValue,
        minValue: minValue,
        range: range,
      ),
    );
  }
}

class CircularGaugePainter extends CustomPainter {
  final double value;
  final double max;
  final Color color;

  CircularGaugePainter({required this.value, required this.max, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    
    // Background circle
    final Paint bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);
    
    // Progress circle
    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = (value / max) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularGaugePainter oldDelegate) => true;
}

class HistoricalChartPainter extends CustomPainter {
  final List<HistoricalYieldData> data;
  final Color color;
  final double maxValue;
  final double minValue;
  final double range;

  HistoricalChartPainter({
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
      final normalizedValue = data[i].yield - minValue;
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

class ComparisonData {
  final String label;
  final double value;

  ComparisonData(this.label, this.value);
}

class HistoricalYieldData {
  final int year;
  final double yield;

  HistoricalYieldData(this.year, this.yield);
}