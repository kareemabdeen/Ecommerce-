class DeliveryMethodModel {
  final String id;
  final String imageUrl;
  final String name;
  final num price;
  final String days;

  DeliveryMethodModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.days,
  });

  DeliveryMethodModel copyWith({
    String? id,
    String? imageUrl,
    String? name,
    num? price,
    String? days,
  }) {
    return DeliveryMethodModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      days: days ?? this.days,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'days': days,
    };
  }

  factory DeliveryMethodModel.fromMap(
      Map<String, dynamic> map, String decumentId) {
    return DeliveryMethodModel(
      id: map['id'] ?? decumentId,
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      days: map['days'] ?? '',
    );
  }
}
