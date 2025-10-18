import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../utils/app_constants.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Weather',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  weatherData.location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${weatherData.temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  weatherData.condition,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail(Icons.water, '${weatherData.humidity.toStringAsFixed(0)}%'),
                _buildWeatherDetail(Icons.opacity, '${weatherData.rainfall.toStringAsFixed(1)}mm'),
                _buildWeatherDetail(Icons.air, '${weatherData.windSpeed.toStringAsFixed(0)} km/h'),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '3-Day Forecast',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ...weatherData.forecast.map((day) => _buildForecastDay(day)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppConstants.primaryColor),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildForecastDay(ForecastDay day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppHelpers.formatDateWithMonth(day.date),
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            '${day.highTemp.toStringAsFixed(0)}°/${day.lowTemp.toStringAsFixed(0)}°',
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            day.condition,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            '${day.rainfall.toStringAsFixed(1)}mm',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}