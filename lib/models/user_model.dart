// User model representing different roles in the system
enum UserRole { farmer, group, agronomist }

class User {
  final String id;
  final String name;
  final String phone;
  final UserRole role;
  final String? groupId; // For farmers who belong to a group
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.groupId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role.toString().split('.').last, // Convert enum to string
      'groupId': groupId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: _parseUserRole(json['role'] ?? 'farmer'),
      groupId: json['groupId'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  static UserRole _parseUserRole(String roleString) {
    switch (roleString) {
      case 'farmer':
        return UserRole.farmer;
      case 'group':
        return UserRole.group;
      case 'agronomist':
        return UserRole.agronomist;
      default:
        return UserRole.farmer;
    }
  }

  User copyWith({
    String? id,
    String? name,
    String? phone,
    UserRole? role,
    String? groupId,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}