import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User?> logInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  User? get currentUser;

  Stream<User?> get authStateChanges;
  Future<void> logOut();
}

// this makes an leakage in memory
// Auth auth = Auth();
// we want this to make use of only one object froom this class
// Auth auth = Auth.getInstance();

class Auth implements AuthBase {
  //*Applying sington pattern
  //*The last constructor Auth._(); is a private constructor,
  // meaning it can only be accessed from within the Auth class itself.
  //This is typically used to prevent external instantiation of the class
  //and to enforce the use of a factory constructor,
  // as shown in the factory Auth() method.
  Auth._();

  //* So, in summary, these lines of code ensure that only one instance of the Auth class is created
  // and shared across the entire application,
  // which is the essence of the Singleton pattern.
  static Auth? _instance;

  factory Auth.getInstance() {
    return _instance ??= Auth._();
  }
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> logInWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> logOut() async => await _firebaseAuth.signOut();
}
