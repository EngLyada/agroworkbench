import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../utils/app_constants.dart';

class AlertsWidget extends StatelessWidget {
  final List<Alert> alerts;

  const AlertsWidget({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Critical Alerts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'No critical alerts at the moment.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Critical Alerts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...alerts.take(3).map((alert) => _buildAlertItem(alert)), // Show only first 3 alerts
            if (alerts.length > 3) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Navigate to full alerts list
                },
                child: const Text('View All Alerts'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(Alert alert) {
    Color alertColor = _getAlertColor(alert.priority);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 4,
            color: alertColor,
          ),
        ),
        color: alertColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        children: [
          Icon(
            _getAlertIcon(alert.type),
            color: alertColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: alertColor,
                  ),
                ),
                Text(
                  alert.description,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppHelpers.formatDateWithMonth(alert.date),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getAlertColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppConstants.dangerColor;
      case 'medium':
        return AppConstants.warningColor;
      default:
        return Colors.grey;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pest warning':
        return Icons.bug_report;
      case 'rainfall':
        return Icons.opacity;
      case 'price spike':
        return Icons.trending_up;
      default:
        return Icons.notifications;
    }
  }
}