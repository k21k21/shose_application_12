import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  bool isLoading = true;

  AuthViewModel() {
    _auth.authStateChanges().listen((event) {
      user = event;
      isLoading = false;
      notifyListeners();
    });
  }
}
