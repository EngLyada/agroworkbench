// Market price data model
class MarketPrice {
  final String commodity;
  final double currentPrice;
  final double previousPrice;
  final double change;
  final double changePercent;
  final DateTime date;
  final String unit; // e.g., "per kg", "per ton"
  final String region;

  MarketPrice({
    required this.commodity,
    required this.currentPrice,
    required this.previousPrice,
    required this.change,
    required this.changePercent,
    required this.date,
    required this.unit,
    required this.region,
  });

  Map<String, dynamic> toJson() {
    return {
      'commodity': commodity,
      'currentPrice': currentPrice,
      'previousPrice': previousPrice,
      'change': change,
      'changePercent': changePercent,
      'date': date.toIso8601String(),
      'unit': unit,
      'region': region,
    };
  }

  factory MarketPrice.fromJson(Map<String, dynamic> json) {
    return MarketPrice(
      commodity: json['commodity'] ?? '',
      currentPrice: json['currentPrice']?.toDouble() ?? 0.0,
      previousPrice: json['previousPrice']?.toDouble() ?? 0.0,
      change: json['change']?.toDouble() ?? 0.0,
      changePercent: json['changePercent']?.toDouble() ?? 0.0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      unit: json['unit'] ?? '',
      region: json['region'] ?? '',
    );
  }
}

// Price forecast model
class PriceForecast {
  final String commodity;
  final List<PricePoint> forecastData;
  final String confidence; // high, medium, low
  final DateTime forecastDate;

  PriceForecast({
    required this.commodity,
    required this.forecastData,
    required this.confidence,
    required this.forecastDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'commodity': commodity,
      'forecastData': forecastData.map((point) => point.toJson()).toList(),
      'confidence': confidence,
      'forecastDate': forecastDate.toIso8601String(),
    };
  }

  factory PriceForecast.fromJson(Map<String, dynamic> json) {
    return PriceForecast(
      commodity: json['commodity'] ?? '',
      forecastData: List<PricePoint>.from(
          (json['forecastData'] ?? []).map((item) => PricePoint.fromJson(item))),
      confidence: json['confidence'] ?? 'medium',
      forecastDate: DateTime.tryParse(json['forecastDate'] ?? '') ?? DateTime.now(),
    );
  }
}

// Price point for forecast
class PricePoint {
  final DateTime date;
  final double predictedPrice;

  PricePoint({
    required this.date,
    required this.predictedPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'predictedPrice': predictedPrice,
    };
  }

  factory PricePoint.fromJson(Map<String, dynamic> json) {
    return PricePoint(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      predictedPrice: json['predictedPrice']?.toDouble() ?? 0.0,
    );
  }
}