// Credit score data model
class CreditScore {
  final int score; // 0-1000
  final String rating; // Excellent, Good, Fair, Poor, etc.
  final List<ScoreBreakdown> breakdown;
  final DateTime lastUpdated;
  final List<CreditHistory> history;

  CreditScore({
    required this.score,
    required this.rating,
    required this.breakdown,
    required this.lastUpdated,
    required this.history,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'rating': rating,
      'breakdown': breakdown.map((item) => item.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'history': history.map((item) => item.toJson()).toList(),
    };
  }

  factory CreditScore.fromJson(Map<String, dynamic> json) {
    return CreditScore(
      score: json['score'] ?? 0,
      rating: json['rating'] ?? '',
      breakdown: List<ScoreBreakdown>.from(
          (json['breakdown'] ?? []).map((item) => ScoreBreakdown.fromJson(item))),
      lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? '') ?? DateTime.now(),
      history: List<CreditHistory>.from(
          (json['history'] ?? []).map((item) => CreditHistory.fromJson(item))),
    );
  }
}

// Score breakdown model
class ScoreBreakdown {
  final String category; // Productivity, Consistency, Input Usage, Payment History
  final int weight; // Percentage weight (e.g., 40 for 40%)
  final int score; // Score for this category (0-100)
  final String status; // Excellent, Good, Average, Poor

  ScoreBreakdown({
    required this.category,
    required this.weight,
    required this.score,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'weight': weight,
      'score': score,
      'status': status,
    };
  }

  factory ScoreBreakdown.fromJson(Map<String, dynamic> json) {
    return ScoreBreakdown(
      category: json['category'] ?? '',
      weight: json['weight'] ?? 0,
      score: json['score'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

// Credit history model
class CreditHistory {
  final DateTime date;
  final int scoreChange;
  final String reason;

  CreditHistory({
    required this.date,
    required this.scoreChange,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'scoreChange': scoreChange,
      'reason': reason,
    };
  }

  factory CreditHistory.fromJson(Map<String, dynamic> json) {
    return CreditHistory(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      scoreChange: json['scoreChange'] ?? 0,
      reason: json['reason'] ?? '',
    );
  }
}