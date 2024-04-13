class AddToCartModel {
  final String title;
  final String size;
  final int price;
  final String color;
  final int productCount;
  final String orginalProductId;
  final String image;
  final int discountValue;
  final String id;

  AddToCartModel({
    required this.title,
    required this.size,
    required this.price,
    required this.color,
    this.productCount = 1,
    required this.orginalProductId,
    required this.image,
    this.discountValue = 0,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'size': size,
      'price': price,
      'color': color,
      'productCount': productCount,
      'productId': orginalProductId,
      'image': image,
      'discountValue': discountValue,
      'id': id,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map,
      {required String productID}) {
    return AddToCartModel(
      title: map['title'] ?? '',
      size: map['size'] ?? '',
      price: map['price']?.toInt() ?? 0,
      color: map['color'] ?? '',
      productCount: map['productCount']?.toInt() ?? 0,
      orginalProductId: productID,
      image: map['image'] ?? '',
      discountValue: map['discountValue']?.toInt() ?? 0,
      id: map['id'] ?? '',
    );
  }
}
