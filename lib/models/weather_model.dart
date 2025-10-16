// Weather data model
class WeatherData {
  final double temperature; // in Celsius
  final double humidity; // percentage
  final double rainfall; // in mm
  final String condition; // e.g., sunny, cloudy, rainy
  final double windSpeed; // in km/h
  final DateTime date;
  final String location; // location name
  final List<ForecastDay> forecast; // 3-day forecast

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.rainfall,
    required this.condition,
    required this.windSpeed,
    required this.date,
    required this.location,
    required this.forecast,
  });

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'rainfall': rainfall,
      'condition': condition,
      'windSpeed': windSpeed,
      'date': date.toIso8601String(),
      'location': location,
      'forecast': forecast.map((day) => day.toJson()).toList(),
    };
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['temperature']?.toDouble() ?? 0.0,
      humidity: json['humidity']?.toDouble() ?? 0.0,
      rainfall: json['rainfall']?.toDouble() ?? 0.0,
      condition: json['condition'] ?? '',
      windSpeed: json['windSpeed']?.toDouble() ?? 0.0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      location: json['location'] ?? '',
      forecast: List<ForecastDay>.from(
          (json['forecast'] ?? []).map((item) => ForecastDay.fromJson(item))),
    );
  }
}

// Forecast day model
class ForecastDay {
  final DateTime date;
  final double highTemp;
  final double lowTemp;
  final String condition;
  final double rainfall;

  ForecastDay({
    required this.date,
    required this.highTemp,
    required this.lowTemp,
    required this.condition,
    required this.rainfall,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'highTemp': highTemp,
      'lowTemp': lowTemp,
      'condition': condition,
      'rainfall': rainfall,
    };
  }

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      highTemp: json['highTemp']?.toDouble() ?? 0.0,
      lowTemp: json['lowTemp']?.toDouble() ?? 0.0,
      condition: json['condition'] ?? '',
      rainfall: json['rainfall']?.toDouble() ?? 0.0,
    );
  }
}

// Alert model for critical notifications
class Alert {
  final String id;
  final String title;
  final String description;
  final String type; // pest warning, rainfall, price spike, etc.
  final DateTime date;
  final bool isRead;
  final String priority; // high, medium, low

  Alert({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    required this.isRead,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'date': date.toIso8601String(),
      'isRead': isRead,
      'priority': priority,
    };
  }

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
      priority: json['priority'] ?? 'medium',
    );
  }
}