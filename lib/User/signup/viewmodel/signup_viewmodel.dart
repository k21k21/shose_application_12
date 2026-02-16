import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final confirmPasswordCon = TextEditingController();

  bool isLoading = false;

  Future<void> signup(BuildContext context, Widget homePage) async {
    if (!formKey.currentState!.validate()) return;

    if (passwordCon.text != confirmPasswordCon.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCon.text.trim(),
        password: passwordCon.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => homePage),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Signup failed")),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    confirmPasswordCon.dispose();
    super.dispose();
  }
}
