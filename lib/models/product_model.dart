class Product {
  final String id;
  final String title;
  final int price;
  final String imgUrl;
  final int? discountValue;
  final String brandName;
  final int? rate;
  final String size;
  final String? color;

  Product({
    required this.color,
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    required this.size,
    this.discountValue,
    this.brandName = 'Other',
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'discountValue': discountValue,
      'brandName': brandName,
      'rate': rate,
      'size': size,
    };
  }

  copyWith(
    String? id,
    String title,
    int price,
    String imgUrl,
    String? color,
    int? discountValue,
    String? brandName,
    String size,
    int? rate,
  ) {
    return Product(
      id: id ?? this.id,
      title: title,
      size: size,
      color: color ?? this.color,
      price: price,
      imgUrl: imgUrl,
    );
  }

  factory Product.fromMap(
      {required Map<String, dynamic> map, required String documentId}) {
    return Product(
      id: documentId,
      size: map['size'] ?? 'Null',
      color: map['color'] ?? 'Black',
      title: map['title'] as String,
      price: map['price'] as int,
      imgUrl: map['imgUrl'] as String,
      discountValue: map['discountValue'] as int,
      brandName: map['brandName'] as String,
      rate: map['rate'] as int,
    );
  }
}

// List<Product> dummyProducts = [
//   Product(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     brandName: 'Clothes',
//     discountValue: 20,
//     co
//   ),
//   Product(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     brandName: 'Clothes',
//     discountValue: 20,
//   ),
//   Product(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     brandName: 'Clothes',
//     discountValue: 20,
//   ),
//   Product(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     brandName: 'Clothes',
//     discountValue: 20,
//   ),
//   Product(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     brandName: 'Clothes',
//   ),
//   Product(
//     id: '1',
//     title: 'T-shirt',
//     price: 300,
//     imgUrl: AppAssets.tempProductAsset1,
//     brandName: 'Clothes',
//     discountValue: 20,
//   ),
// ];
