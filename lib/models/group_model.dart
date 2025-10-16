// Farmer group data model
class FarmerGroup {
  final String id;
  final String name;
  final List<String> memberIds; // List of farmer IDs in the group
  final double totalLand; // Total land in acres
  final double totalSavings; // Total savings in USD
  final String leaderId; // ID of the group leader
  final List<GroupActivity> activities;
  final DateTime createdAt;

  FarmerGroup({
    required this.id,
    required this.name,
    required this.memberIds,
    required this.totalLand,
    required this.totalSavings,
    required this.leaderId,
    required this.activities,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'memberIds': memberIds,
      'totalLand': totalLand,
      'totalSavings': totalSavings,
      'leaderId': leaderId,
      'activities': activities.map((activity) => activity.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FarmerGroup.fromJson(Map<String, dynamic> json) {
    return FarmerGroup(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      memberIds: List<String>.from(json['memberIds'] ?? []),
      totalLand: json['totalLand']?.toDouble() ?? 0.0,
      totalSavings: json['totalSavings']?.toDouble() ?? 0.0,
      leaderId: json['leaderId'] ?? '',
      activities: List<GroupActivity>.from(
          (json['activities'] ?? []).map((item) => GroupActivity.fromJson(item))),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

// Group activity model
class GroupActivity {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String status; // completed, pending, in-progress

  GroupActivity({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory GroupActivity.fromJson(Map<String, dynamic> json) {
    return GroupActivity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'pending',
    );
  }
}

// Group member performance model
class GroupMemberPerformance {
  final String memberId;
  final String farmerName;
  final double landSize;
  final double yield;
  final int creditScore;
  final String status; // Good, Average, Poor

  GroupMemberPerformance({
    required this.memberId,
    required this.farmerName,
    required this.landSize,
    required this.yield,
    required this.creditScore,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'farmerName': farmerName,
      'landSize': landSize,
      'yield': yield,
      'creditScore': creditScore,
      'status': status,
    };
  }

  factory GroupMemberPerformance.fromJson(Map<String, dynamic> json) {
    return GroupMemberPerformance(
      memberId: json['memberId'] ?? '',
      farmerName: json['farmerName'] ?? '',
      landSize: json['landSize']?.toDouble() ?? 0.0,
      yield: json['yield']?.toDouble() ?? 0.0,
      creditScore: json['creditScore'] ?? 0,
      status: json['status'] ?? 'Average',
    );
  }
}