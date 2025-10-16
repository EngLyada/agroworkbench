import 'package:flutter/material.dart';

import '../models/advisory_model.dart';
import '../utils/app_constants.dart';

class AdvisoryScreen extends StatefulWidget {
  final String farmerId;
  final String cropType;
  
  const AdvisoryScreen({Key? key, required this.farmerId, required this.cropType}) : super(key: key);

  @override
  State<AdvisoryScreen> createState() => _AdvisoryScreenState();
}

class _AdvisoryScreenState extends State<AdvisoryScreen> {
  // Mock data for demonstration
  late List<Advisory> _advisories;

  @override
  void initState() {
    super.initState();
    _loadMockAdvisories();
  }

  void _loadMockAdvisories() {
    _advisories = [
      Advisory(
        id: '1',
        farmerId: widget.farmerId,
        crop: widget.cropType,
        stage: 'Planting',
        recommendations: [
          'Use certified seeds for better yield',
          'Ensure soil pH is between 6.0-7.0',
          'Apply starter fertilizer at planting',
        ],
        confidence: 0.95,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Advisory(
        id: '2',
        farmerId: widget.farmerId,
        crop: widget.cropType,
        stage: 'Vegetative',
        recommendations: [
          'Apply nitrogen fertilizer at 2-week intervals',
          'Monitor for stem borer infestation',
          'Ensure adequate soil moisture',
        ],
        confidence: 0.92,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Advisory(
        id: '3',
        farmerId: widget.farmerId,
        crop: widget.cropType,
        stage: 'Flowering',
        recommendations: [
          'Control aphid infestation',
          'Maintain soil pH between 6.0-7.0',
          'Prepare for harvesting in 2-3 weeks',
        ],
        confidence: 0.88,
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Crop Advisory - ${widget.cropType}'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline view of upcoming tasks
            const Text(
              'Upcoming Tasks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _advisories.length,
                itemBuilder: (context, index) {
                  final advisory = _advisories[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${advisory.stage} Stage',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppConstants.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${(advisory.confidence * 100).toStringAsFixed(0)}% Confidence',
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        AppHelpers.formatDateWithMonth(advisory.createdAt),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recommendations:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
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
                              ).toList(),
                              const SizedBox(height: 16),
                              const Text(
                                'Why this advice?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'This recommendation is based on your location, current weather conditions, '
                                'soil type, and growth stage. Our AI analyzed similar conditions across '
                                'East Africa to provide the most effective recommendations.',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up_alt_outlined),
                                    color: Colors.grey,
                                    onPressed: () {
                                      // Thumbs up feedback
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_down_alt_outlined),
                                    color: Colors.grey,
                                    onPressed: () {
                                      // Thumbs down feedback
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.share),
                                    onPressed: () {
                                      // Share recommendation
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}