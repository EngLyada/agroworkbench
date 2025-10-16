// Agroinput order model
class InputOrder {
  final String id;
  final String farmerId;
  final String inputType; // seeds, fertilizer, pesticide, etc.
  final String inputName;
  final int quantity;
  final String unit; // kg, liters, bags, etc.
  final double unitPrice;
  final double totalPrice;
  final DateTime orderDate;
  final String status; // pending, confirmed, shipped, delivered
  final String deliveryAddress;
  final DateTime? deliveryDate;

  InputOrder({
    required this.id,
    required this.farmerId,
    required this.inputType,
    required this.inputName,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
    required this.deliveryAddress,
    this.deliveryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'inputType': inputType,
      'inputName': inputName,
      'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
      'deliveryAddress': deliveryAddress,
      'deliveryDate': deliveryDate?.toIso8601String(),
    };
  }

  factory InputOrder.fromJson(Map<String, dynamic> json) {
    return InputOrder(
      id: json['id'] ?? '',
      farmerId: json['farmerId'] ?? '',
      inputType: json['inputType'] ?? '',
      inputName: json['inputName'] ?? '',
      quantity: json['quantity'] ?? 0,
      unit: json['unit'] ?? '',
      unitPrice: json['unitPrice']?.toDouble() ?? 0.0,
      totalPrice: json['totalPrice']?.toDouble() ?? 0.0,
      orderDate: DateTime.tryParse(json['orderDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'pending',
      deliveryAddress: json['deliveryAddress'] ?? '',
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? ''),
    );
  }
}

// Input inventory model
class InputInventory {
  final String id;
  final String name;
  final String type; // seeds, fertilizer, pesticide, etc.
  final String brand;
  final int availableQuantity;
  final String unit; // kg, liters, bags, etc.
  final double unitPrice;
  final String description;
  final String supplier;

  InputInventory({
    required this.id,
    required this.name,
    required this.type,
    required this.brand,
    required this.availableQuantity,
    required this.unit,
    required this.unitPrice,
    required this.description,
    required this.supplier,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'brand': brand,
      'availableQuantity': availableQuantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'description': description,
      'supplier': supplier,
    };
  }

  factory InputInventory.fromJson(Map<String, dynamic> json) {
    return InputInventory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      brand: json['brand'] ?? '',
      availableQuantity: json['availableQuantity'] ?? 0,
      unit: json['unit'] ?? '',
      unitPrice: json['unitPrice']?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      supplier: json['supplier'] ?? '',
    );
  }
}