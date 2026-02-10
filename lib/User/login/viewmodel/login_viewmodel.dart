import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends ChangeNotifier {
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false; // 🔹 Loading shared for Login & Google

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    Widget home, {
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) return;

    setLoading(true); // 🔹 show loading

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCon.text.trim(),
        password: passwordCon.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => home),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
    }

    setLoading(false); // 🔹 hide loading
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    return userCredential.user;
  }

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }
}
