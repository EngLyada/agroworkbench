// Agronomist data model
class Agronomist {
  final String id;
  final String name;
  final String phone;
  final List<String> assignedFarmerIds;
  final List<String> assignedGroupIds;
  final double totalAcres;
  final int totalFarmers;
  final int totalGroups;
  final List<FieldVisit> fieldVisits;
  final DateTime createdAt;

  Agronomist({
    required this.id,
    required this.name,
    required this.phone,
    required this.assignedFarmerIds,
    required this.assignedGroupIds,
    required this.totalAcres,
    required this.totalFarmers,
    required this.totalGroups,
    required this.fieldVisits,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'assignedFarmerIds': assignedFarmerIds,
      'assignedGroupIds': assignedGroupIds,
      'totalAcres': totalAcres,
      'totalFarmers': totalFarmers,
      'totalGroups': totalGroups,
      'fieldVisits': fieldVisits.map((visit) => visit.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Agronomist.fromJson(Map<String, dynamic> json) {
    return Agronomist(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      assignedFarmerIds: List<String>.from(json['assignedFarmerIds'] ?? []),
      assignedGroupIds: List<String>.from(json['assignedGroupIds'] ?? []),
      totalAcres: json['totalAcres']?.toDouble() ?? 0.0,
      totalFarmers: json['totalFarmers'] ?? 0,
      totalGroups: json['totalGroups'] ?? 0,
      fieldVisits: List<FieldVisit>.from(
          (json['fieldVisits'] ?? []).map((item) => FieldVisit.fromJson(item))),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

// Field visit model
class FieldVisit {
  final String id;
  final String farmerId;
  final String groupName;
  final String notes;
  final List<String> photoPaths;
  final List<RecommendationOverride> recommendationOverrides;
  final bool tasksCompleted;
  final DateTime visitDate;
  final String status; // pending, completed, overdue

  FieldVisit({
    required this.id,
    required this.farmerId,
    required this.groupName,
    required this.notes,
    required this.photoPaths,
    required this.recommendationOverrides,
    required this.tasksCompleted,
    required this.visitDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'groupName': groupName,
      'notes': notes,
      'photoPaths': photoPaths,
      'recommendationOverrides': 
          recommendationOverrides.map((override) => override.toJson()).toList(),
      'tasksCompleted': tasksCompleted,
      'visitDate': visitDate.toIso8601String(),
      'status': status,
    };
  }

  factory FieldVisit.fromJson(Map<String, dynamic> json) {
    return FieldVisit(
      id: json['id'] ?? '',
      farmerId: json['farmerId'] ?? '',
      groupName: json['groupName'] ?? '',
      notes: json['notes'] ?? '',
      photoPaths: List<String>.from(json['photoPaths'] ?? []),
      recommendationOverrides: List<RecommendationOverride>.from(
          (json['recommendationOverrides'] ?? [])
              .map((item) => RecommendationOverride.fromJson(item))),
      tasksCompleted: json['tasksCompleted'] ?? false,
      visitDate: DateTime.tryParse(json['visitDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'pending',
    );
  }
}

// Recommendation override model
class RecommendationOverride {
  final String originalRecommendation;
  final String newRecommendation;
  final String justification;

  RecommendationOverride({
    required this.originalRecommendation,
    required this.newRecommendation,
    required this.justification,
  });

  Map<String, dynamic> toJson() {
    return {
      'originalRecommendation': originalRecommendation,
      'newRecommendation': newRecommendation,
      'justification': justification,
    };
  }

  factory RecommendationOverride.fromJson(Map<String, dynamic> json) {
    return RecommendationOverride(
      originalRecommendation: json['originalRecommendation'] ?? '',
      newRecommendation: json['newRecommendation'] ?? '',
      justification: json['justification'] ?? '',
    );
  }
}