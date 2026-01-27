import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shose_application_12/view/bottom_navigations.dart';

class LoginViewModel extends ChangeNotifier {
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    Widget home, {
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) return;

    _setLoading(true);

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

    _setLoading(false);
  }

  Future<void> signInWithGoogle(
    BuildContext context,
    BottomNavigation bottomNavigation,
  ) async {
    _setLoading(true); // 1️⃣ شغّل اللودينج

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

<<<<<<< Updated upstream:lib/login/viewmodel/login_viewmodel.dart
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
=======
      // لو المستخدم لغى تسجيل الدخول
      if (googleUser == null) {
        _setLoading(false);
        return;
      }
>>>>>>> Stashed changes:lib/viewmodel/login_viewmodel.dart

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // 2️⃣ بعد النجاح روحي للهوم
      bottomNavigation;
      (context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Google login failed')));
    }

    _setLoading(false); // 3️⃣ وقف اللودينج
  }

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }
}
