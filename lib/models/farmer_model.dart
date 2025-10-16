// Farmer data model as specified in requirements
class Farmer {
  final String id;
  final String name;
  final String phone;
  final Location location;
  final List<Crop> crops;
  final double acreage;
  final String? groupId;

  Farmer({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.crops,
    required this.acreage,
    this.groupId,
  });

  // Convert to JSON for API communication
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'location': location.toJson(),
      'crops': crops.map((crop) => crop.toJson()).toList(),
      'acreage': acreage,
      'groupId': groupId,
    };
  }

  // Create from JSON
  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      crops: List<Crop>.from(
          (json['crops'] ?? []).map((item) => Crop.fromJson(item))),
      acreage: json['acreage']?.toDouble() ?? 0.0,
      groupId: json['groupId'],
    );
  }

  // Copy with method for updates
  Farmer copyWith({
    String? id,
    String? name,
    String? phone,
    Location? location,
    List<Crop>? crops,
    double? acreage,
    String? groupId,
  }) {
    return Farmer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      crops: crops ?? this.crops,
      acreage: acreage ?? this.acreage,
      groupId: groupId ?? this.groupId,
    );
  }
}

// Location model
class Location {
  final double lat;
  final double lng;

  const Location({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
    );
  }
}

// Crop model
class Crop {
  final String id;
  final String name;
  final String type;

  const Crop({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }
}