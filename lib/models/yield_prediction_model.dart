// YieldPrediction data model as specified in requirements
class YieldPrediction {
  final String farmerId;
  final String crop;
  final double predictedYield;
  final String unit;
  final double confidence;
  final List<Factor> factors;

  YieldPrediction({
    required this.farmerId,
    required this.crop,
    required this.predictedYield,
    required this.unit,
    required this.confidence,
    required this.factors,
  });

  Map<String, dynamic> toJson() {
    return {
      'farmerId': farmerId,
      'crop': crop,
      'predictedYield': predictedYield,
      'unit': unit,
      'confidence': confidence,
      'factors': factors.map((factor) => factor.toJson()).toList(),
    };
  }

  factory YieldPrediction.fromJson(Map<String, dynamic> json) {
    return YieldPrediction(
      farmerId: json['farmerId'] ?? '',
      crop: json['crop'] ?? '',
      predictedYield: json['predictedYield']?.toDouble() ?? 0.0,
      unit: json['unit'] ?? 'tons/acre',
      confidence: json['confidence']?.toDouble() ?? 0.0,
      factors: List<Factor>.from(
          (json['factors'] ?? []).map((item) => Factor.fromJson(item))),
    );
  }
}

// Factor model for yield prediction factors
class Factor {
  final String name;
  final double value;
  final String impact; // positive, negative, neutral

  Factor({
    required this.name,
    required this.value,
    required this.impact,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'impact': impact,
    };
  }

  factory Factor.fromJson(Map<String, dynamic> json) {
    return Factor(
      name: json['name'] ?? '',
      value: json['value']?.toDouble() ?? 0.0,
      impact: json['impact'] ?? 'neutral',
    );
  }
}