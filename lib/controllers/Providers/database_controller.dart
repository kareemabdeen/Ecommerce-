import '../../models/product_model.dart';
import '../../services/firestore_services.dart';

abstract class DataBase {
  Stream<List<Product>> getAllProductsStream(
      {Map<String, dynamic>? data, required String documentId});
}

class FireStoreDataBase implements DataBase {
  FireStoreServices fireStoreServices = FireStoreServices.instance;
  @override
  Stream<List<Product>> getAllProductsStream(
      {Map<String, dynamic>? data, required String documentId}) {
    return fireStoreServices.collectionsStream(
      path: 'products/',
      fromMapBuilder: (data, {required documentId}) =>
          Product.fromMap(map: data!, documentId: documentId),
    );
  }
}
