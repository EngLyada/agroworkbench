import 'package:flutter/material.dart';

import '../models/credit_score_model.dart';
import '../utils/app_constants.dart';

class CreditScoringScreen extends StatefulWidget {
  final CreditScore creditScore;
  
  const CreditScoringScreen({Key? key, required this.creditScore}) : super(key: key);

  @override
  State<CreditScoringScreen> createState() => _CreditScoringScreenState();
}

class _CreditScoringScreenState extends State<CreditScoringScreen> {
  bool _showBreakdown = false;
  late CreditScore _score;

  @override
  void initState() {
    super.initState();
    _score = widget.creditScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Credit Scoring'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Credit Score Display with Gauge
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Credit Score: ${_score.score}/1000',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppHelpers.getCreditScoreColor(_score.score),
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
                                  value: _score.score.toDouble(),
                                  max: 1000,
                                  color: AppHelpers.getCreditScoreColor(_score.score),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _score.score.toString(),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: AppHelpers.getCreditScoreColor(_score.score),
                                  ),
                                ),
                                Text(
                                  AppHelpers.getCreditScoreStatus(_score.score),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppHelpers.getCreditScoreColor(_score.score),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showBreakdown = !_showBreakdown;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(_showBreakdown ? 'Hide Details' : 'Show Score Breakdown'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Score Breakdown (Accordion)
              if (_showBreakdown) ...[
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Score Breakdown',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ..._score.breakdown.map((breakdown) => 
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    breakdown.category,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${breakdown.weight}%',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    breakdown.score.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Icon(
                                        breakdown.status == 'Excellent' 
                                            ? Icons.check_circle 
                                            : breakdown.status == 'Good' 
                                                ? Icons.check_circle_outline 
                                                : Icons.warning,
                                        color: breakdown.status == 'Excellent' 
                                            ? AppConstants.successColor 
                                            : breakdown.status == 'Good' 
                                                ? Colors.amber 
                                                : AppConstants.warningColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        breakdown.status,
                                        style: TextStyle(
                                          color: breakdown.status == 'Excellent' 
                                              ? AppConstants.successColor 
                                              : breakdown.status == 'Good' 
                                                  ? Colors.amber 
                                                  : AppConstants.warningColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Actions
              const Text(
                'Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Save for input functionality
                              },
                              icon: const Icon(Icons.savings),
                              label: const Text('Save for Input'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppConstants.primaryColor,
                                side: BorderSide(color: AppConstants.primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Apply for financing functionality
                              },
                              icon: const Icon(Icons.request_quote),
                              label: const Text('Apply for Financing'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstants.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          // Improve score modal
                          _showImproveScoreModal(context);
                        },
                        icon: const Icon(Icons.trending_up),
                        label: const Text('Improve Your Score'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppConstants.primaryColor,
                          side: BorderSide(color: AppConstants.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Credit Evolution Graph
              const Text(
                'Credit Evolution',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: _buildCreditHistoryChart(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditHistoryChart() {
    if (_score.history.isEmpty) {
      return const Center(child: Text('No history data available'));
    }

    final baseScore = 700; // Using base score of 700 for visualization
    final data = _score.history.map((history) => CreditHistoryPoint(
      history.date,
      history.scoreChange + baseScore,
    )).toList();

    final maxValue = data.map((p) => p.score.toDouble()).reduce((a, b) => a > b ? a : b);
    final minValue = data.map((p) => p.score.toDouble()).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue != 0 ? (maxValue - minValue) : 1.0;

    return CustomPaint(
      size: Size(double.infinity, 200),
      painter: CreditHistoryChartPainter(
        data: data,
        color: AppHelpers.getCreditScoreColor(_score.score),
        maxValue: maxValue,
        minValue: minValue,
        range: range,
      ),
    );
  }

  void _showImproveScoreModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Improve Your Credit Score'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle, color: AppConstants.successColor),
                title: const Text('Make timely payments'),
                subtitle: const Text('Always pay your loans on time'),
              ),
              ListTile(
                leading: const Icon(Icons.check_circle, color: AppConstants.successColor),
                title: const Text('Maintain consistent farming'),
                subtitle: const Text('Regular farming activity improves your score'),
              ),
              ListTile(
                leading: const Icon(Icons.check_circle, color: AppConstants.successColor),
                title: const Text('Use quality inputs'),
                subtitle: const Text('Using certified seeds and fertilizers'),
              ),
              ListTile(
                leading: const Icon(Icons.check_circle, color: AppConstants.successColor),
                title: const Text('Participate in training'),
                subtitle: const Text('Complete agricultural training programs'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
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

class CreditHistoryChartPainter extends CustomPainter {
  final List<CreditHistoryPoint> data;
  final Color color;
  final double maxValue;
  final double minValue;
  final double range;

  CreditHistoryChartPainter({
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
      final normalizedValue = data[i].score - minValue;
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

class CreditHistoryPoint {
  final DateTime date;
  final int score;

  CreditHistoryPoint(this.date, this.score);
}