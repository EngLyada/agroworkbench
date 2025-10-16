import 'package:flutter/material.dart';

import '../models/group_model.dart';
import '../models/farmer_model.dart';
import '../utils/app_constants.dart';

class GroupDashboardScreen extends StatefulWidget {
  final FarmerGroup group;
  final List<Farmer> members; // List of farmers in the group
  
  const GroupDashboardScreen({Key? key, required this.group, required this.members}) : super(key: key);

  @override
  State<GroupDashboardScreen> createState() => _GroupDashboardScreenState();
}

class _GroupDashboardScreenState extends State<GroupDashboardScreen> {
  // Mock data for demonstration
  late List<GroupMemberPerformance> _memberPerformance;
  late List<GroupActivity> _activities;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock member performance
    _memberPerformance = [
      GroupMemberPerformance(
        memberId: '1',
        farmerName: 'John Doe',
        landSize: 2.5,
        yield: 3.2,
        creditScore: 750,
        status: 'Good',
      ),
      GroupMemberPerformance(
        memberId: '2',
        farmerName: 'Jane Smith',
        landSize: 3.0,
        yield: 3.8,
        creditScore: 820,
        status: 'Excellent',
      ),
      GroupMemberPerformance(
        memberId: '3',
        farmerName: 'Samuel Kato',
        landSize: 1.8,
        yield: 2.5,
        creditScore: 650,
        status: 'Average',
      ),
      GroupMemberPerformance(
        memberId: '4',
        farmerName: 'Grace Nakato',
        landSize: 2.2,
        yield: 3.0,
        creditScore: 780,
        status: 'Good',
      ),
    ];

    // Mock activities
    _activities = [
      GroupActivity(
        id: '1',
        name: 'Group Meeting',
        description: 'Monthly planning meeting',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'completed',
      ),
      GroupActivity(
        id: '2',
        name: 'Bulk Input Purchase',
        description: 'Purchase of seeds and fertilizers',
        date: DateTime.now().add(const Duration(days: 5)),
        status: 'pending',
      ),
      GroupActivity(
        id: '3',
        name: 'Field Visit',
        description: 'Agronomist field visit',
        date: DateTime.now().add(const Duration(days: 10)),
        status: 'pending',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
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
              // Group Header
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.group.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${widget.members.length}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Total Members',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              AppHelpers.formatCurrency(widget.group.totalSavings),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Total Savings',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${widget.group.totalLand} Acres',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Total Land',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick Actions (Same 4-card layout as individual)
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
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
                  _buildQuickActionCard('Members', Icons.people, AppConstants.dangerColor),
                ],
              ),
              const SizedBox(height: 16),

              // Activity Summary
              const Text(
                'Activity Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildActivityCard('Group Loan Status', 'Active - \$2,500'),
              const SizedBox(height: 8),
              _buildActivityCard('Collective Insurance', '3 Policies Active'),
              const SizedBox(height: 8),
              _buildActivityCard('Bulk Orders', '5 Placed'),
              const SizedBox(height: 16),

              // Group Analytics
              const Text(
                'Group Analytics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Aggregate Yield Chart
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aggregate Yield Chart',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: _buildYieldChart(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Total Production Timeline
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Production Timeline',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: _buildProductionTimeline(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Member Performance Table
              const Text(
                'Member Performance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              DataTable(
                columnSpacing: 12,
                columns: const [
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Acres'),
                  ),
                  DataColumn(
                    label: Text('Yield'),
                  ),
                  DataColumn(
                    label: Text('Credit Score'),
                  ),
                ],
                rows: _memberPerformance.map((member) {
                  return DataRow(
                    cells: [
                      DataCell(Text(member.farmerName)),
                      DataCell(Text(member.landSize.toString())),
                      DataCell(Text('${member.yield} tons')),
                      DataCell(
                        Text(
                          member.creditScore.toString(),
                          style: TextStyle(
                            color: AppHelpers.getCreditScoreColor(member.creditScore),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      // Export report functionality
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Export Report'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppConstants.primaryColor,
                      side: BorderSide(color: AppConstants.primaryColor),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add member functionality
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Member'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
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

  Widget _buildYieldChart() {
    // Create a simple bar chart using Flutter widgets
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxValue = _memberPerformance.map((m) => m.yield).reduce((a, b) => a > b ? a : b);
        
        return Column(
          children: _memberPerformance.map((member) {
            final barHeight = (member.yield / maxValue) * 100;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      member.farmerName,
                      style: const TextStyle(fontSize: 12),
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
                            width: (barHeight / 100) * constraints.maxWidth * 0.6,
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
                                  member.yield.toStringAsFixed(1),
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

  Widget _buildProductionTimeline() {
    // Sample data for the production timeline
    final data = [
      ProductionDataPoint(1, 12.5),
      ProductionDataPoint(2, 14.2),
      ProductionDataPoint(3, 11.8),
      ProductionDataPoint(4, 15.0),
      ProductionDataPoint(5, 13.5),
      ProductionDataPoint(6, 16.2),
    ];
    
    final maxValue = data.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    final minValue = data.map((p) => p.value).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue != 0 ? (maxValue - minValue) : 1.0;

    return CustomPaint(
      size: Size(double.infinity, 100),
      painter: LineChartPainter(
        data: data,
        color: AppConstants.primaryColor,
        maxValue: maxValue,
        minValue: minValue,
        range: range,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<ProductionDataPoint> data;
  final Color color;
  final double maxValue;
  final double minValue;
  final double range;

  LineChartPainter({
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
      final y = size.height - ((data[i].value - minValue) / range) * size.height;
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

class ProductionDataPoint {
  final int month;
  final double value;

  ProductionDataPoint(this.month, this.value);
}