import '../../models/product_model.dart';
import '../../models/user_cart_model.dart';
import '../../models/user_data_model.dart';
import '../../services/firestore_services.dart';
import '../../utilities/fire_store_paths.dart';

abstract class DataBase {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newsProductsStream();
  Future<void> addUser({required UserData user});
  Future<void> addProduct({required Product product});
  Stream<List<AddToCartModel>> userCartAllProducts();
  Future<void> addTOCart({required AddToCartModel product});
}

class FireStoreDataBase implements DataBase {
  final fireStoreServices = FireStoreServices.instance;
  final String currentUserId;

  /// to listen and consume it we just need streamBuilder

  // FireStoreDataBase._();
  // static final FireStoreDataBase? _fireStoreDataBase;
  // factory FireStoreDataBase.instance() {
  //   return _fireStoreDataBase ?? FireStoreDataBase._();
  // }

  FireStoreDataBase({
    required this.currentUserId,
  });

  @override
  Stream<List<Product>> salesProductsStream() {
    return fireStoreServices.collectionsStream(
      path: FireStorePaths.productPath,
      queryBuilder: (query) => query.where(
        'discountValue',
        isNotEqualTo: 0,
      ),
      fromMapBuilder: (data, documentId) {
        return Product.fromMap(
          map: data!,
          documentId: documentId,
        );
      },
    );
  }

  @override
  Stream<List<Product>> newsProductsStream() {
    return fireStoreServices.collectionsStream(
      path: FireStorePaths.productPath,
      fromMapBuilder: (dataReturnedDataFromFirestore, documentId) =>
          Product.fromMap(
        map: dataReturnedDataFromFirestore!,
        documentId: documentId,
      ),
    );
  }

  @override
  Future<void> addProduct({required Product product}) async {
    await fireStoreServices.setData(
      documentPath: "${FireStorePaths.productPath}${product.id}",
      data: product.toMap(),
    );
  }

  @override
  Future<void> addTOCart({required AddToCartModel product}) {
    return fireStoreServices.setData(
      ///  users/currentUser;
      documentPath: 'users/$currentUserId/AddToCart/${product.id}',
      data: product.toMap(),
    );
  }

  @override
  Future<void> addUser({required UserData user}) async {
    await fireStoreServices.setData(
      documentPath: 'users/${user.uId}', // users/generateddecomentID
      data: user.toMap(),
    );
  }

  @override

  /// returned from firebase auth
  Stream<List<AddToCartModel>> userCartAllProducts() {
    return fireStoreServices.collectionsStream(
      path: 'users/$currentUserId/AddToCart/',
      fromMapBuilder: (data, documentId) {
        return AddToCartModel.fromMap(
          data!,
          productID: documentId,
        );
      },
    );
  }
}
