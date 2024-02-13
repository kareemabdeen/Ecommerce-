// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../services/auth.dart';
import '../../utilities/enums.dart';

class AuthController with ChangeNotifier {
  final AuthBase authBase; //we here deals with abstract class direct
  String email;
  String password;
  AuthFormType? authFormType;

  AuthController({
    required this.authBase,
    this.email = '',
    this.password = '',
    authFormType = AuthFormType.login,
  });

  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }

  //  this.email = email;
  void updateEmail(String newEmail) {
    copyWith(email: newEmail);
    log(newEmail);
  }

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await authBase.logInWithEmailAndPassword(email, password);
      } else {
        await authBase.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await authBase.logOut();
    } catch (e) {
      rethrow;
    }
  }

  void toggleAuthFormType() {
    //! cannot be updated to ui
    if (authFormType == AuthFormType.register) {
      authFormType = AuthFormType.login;
    } else {
      authFormType = AuthFormType.register;
    }
    copyWith(
      authFormType: authFormType,
      email: " ",
      password: " ",
    );
  }

  void updatePassword(String newPassword) => copyWith(password: newPassword);
}
