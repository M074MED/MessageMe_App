import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/toast_message.dart';

final userProvider =
    ChangeNotifierProvider<UserProviderApi>((ref) => UserProviderApi(ref));

class UserProviderApi extends ChangeNotifier {
  Ref ref;
  String email = '';
  String password = '';
  bool _disposed = false;
  bool loading = false;
  final _firebaseAuth = FirebaseAuth.instance;

  UserProviderApi(this.ref);

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<bool> login(String userEmail, String userPassword) async {
    loading = true;
    notifyListeners();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      email = userEmail;
      password = userPassword;
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      ToastMessage(
        message: "Error!: $e",
        bgColor: Colors.red,
      ).show();
      print("-------------------------------------------------------------");
      print(e);
      print("-------------------------------------------------------------");
    }
    loading = false;
    notifyListeners();
    return false;
  }

  Future<bool> logout() async {
    loading = true;
    notifyListeners();
    try {
      await _firebaseAuth.signOut();

      email = '';
      password = '';
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      ToastMessage(
        message: "Error!: $e",
        bgColor: Colors.red,
      ).show();
      print("-------------------------------------------------------------");
      print(e);
      print("-------------------------------------------------------------");
    }
    loading = false;
    notifyListeners();
    return false;
  }

  Future<bool> register(String userEmail, String userPassword) async {
    loading = true;
    notifyListeners();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      return login(userEmail, userPassword);
    } catch (e) {
      ToastMessage(
        message: "Error!: $e",
        bgColor: Colors.red,
      ).show();
      print("-------------------------------------------------------------");
      print(e);
      print("-------------------------------------------------------------");
    }
    loading = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
