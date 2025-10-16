// Advisory data model as specified in requirements
class Advisory {
  final String id;
  final String farmerId;
  final String crop;
  final String stage;
  final List<String> recommendations;
  final double confidence;
  final DateTime createdAt;

  Advisory({
    required this.id,
    required this.farmerId,
    required this.crop,
    required this.stage,
    required this.recommendations,
    required this.confidence,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'crop': crop,
      'stage': stage,
      'recommendations': recommendations,
      'confidence': confidence,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Advisory.fromJson(Map<String, dynamic> json) {
    return Advisory(
      id: json['id'] ?? '',
      farmerId: json['farmerId'] ?? '',
      crop: json['crop'] ?? '',
      stage: json['stage'] ?? '',
      recommendations: List<String>.from(json['recommendations'] ?? []),
      confidence: json['confidence']?.toDouble() ?? 0.0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}