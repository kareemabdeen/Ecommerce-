import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  //lazy singeton
  // static FireStoreServices? _firestoreServices;

  // FireStoreServices._();

  // factory FireStoreServices.init() {
  //   return _firestoreServices ??= FireStoreServices._();
  // }
  FireStoreServices._();
  static final instance = FireStoreServices._();
  final _firestore = FirebaseFirestore.instance;
  Future<void> setData(
      {required documentPath, required Map<String, dynamic> data}) async {
    final docsRefrence = _firestore.doc(documentPath);
    log('$data');
    log('$documentPath');

    await docsRefrence.set(
      data,
    ); //* in order it can add data if not founded before or edit it if it has anew value as example
  }
  //  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
  //   await _firestore.collection(collection).add(data);
  // }

  // Future<void> updateDocument(
  //     String collection, String documentId, Map<String, dynamic> data) async {
  //   await _firestore.collection(collection).doc(documentId).update(data);
  // }

  Future<void> deleteData({
    required documentPath,
  }) async {
    final docsRefrence = _firestore.doc(documentPath);
    log('$documentPath');
    await docsRefrence.delete();
  }
  //   Future<void> deleteDocument(String collection, String documentId) async {
  //   await _firestore.collection(collection).doc(documentId).delete();
  // }

  // Future<DocumentSnapshot<Type>> readFromDocument<Type>({
  //   required String documentPath,
  // }) {
  //   final DocumentReference = _firestore.doc(documentPath);
  //   final snapShots =
  //       DocumentReference.snapshots();

  // }

  // get Specific document
  //FireStoreServices _fireStoreServices = FireStoreServices.instance.documentsStream<Product>(path: '/qfvds/aa', fromMapBuilder:Product.fromMap() );
  Stream<type> documentsStream<type>({
    required String documentPath,
    required type Function<type>(
            {Map<String, dynamic>? data, String documentId})
        fromMapBuilder,
  }) {
    final reference = _firestore.doc(documentPath);
    final snapshots = reference.snapshots();
    //return Stream<DocumentSnapshot> only , dosnot access any collections

    return snapshots.map(
      (snapshot) {
        return fromMapBuilder(data: snapshot.data(), documentId: snapshot.id);
      },
    );
  }

  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data,
            {required String documentId})
        fromMapBuilder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _firestore.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();

    return snapshots.map(
      (snapshot) {
        final result = snapshot.docs
            .map(
              (snapshot) => fromMapBuilder(
                snapshot.data() as Map<String, dynamic>,
                documentId: snapshot.id,
              ),
            )
            .where((value) => value != null)
            .toList();
        if (sort != null) {
          result.sort(sort);
        }
        return result;
      },
    );
  }
  // final numbers = <int>[1, 2, 3, 5, 6, 7];
  // var result = numbers.where((x) => x < 5); // (1, 2, 3)

  // Stream<List<Type>> getEntireContentOfCollection<Type>({
  //   required String collectionPath,
  //   required Type Function({Map<String, dynamic>? data, String documentId})
  //       fromMapBuilder,
  //   int Function(Type lhs, Type rhs)? sort,
  // }) {
  //   final collectionReference = _firestore.collection(collectionPath);
  //   final snapshots = collectionReference.snapshots();
  //   return snapshots.map(
  //     (snapshot) {
  //       final result = snapshot.docs
  //           .map(
  //             (doc) => fromMapBuilder(data: doc.data(), documentId: doc.id),
  //           )
  //           .where((docItem) => docItem != null)
  //           .toList();

  //       if (sort != null) {
  //         result.sort(sort);
  //       }

  //       return result;
  //     },
  //   );
  // }
}
