import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:shose_application_12/Admin/adminbutton.dart';
import 'package:shose_application_12/User/BottomNavigation/bottom_navigations.dart';
import 'package:shose_application_12/User/card/viewmodel/cart_viewmodel.dart';

class LoginViewModel extends ChangeNotifier {
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  // 🔹 Login بـ Email
  // 🔹 Login بـ Email المعدل
  Future<void> login(BuildContext context, dynamic vm) async {
    if (!formKey.currentState!.validate()) return;

    setLoading(true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailCon.text.trim(),
            password: passwordCon.text.trim(),
          );

      final user = userCredential.user;
      if (user != null) {
        // 1. جلب الداتا مرة واحدة
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String role;

        // 2. التحقق لو الدوكيومنت موجود فعلاً
        if (doc.exists) {
          // لو موجود، اسحب الداتا بأمان
          final data = doc.data() as Map<String, dynamic>?;
          role = data?['role'] ?? 'user';
        } else {
          // 3. لو مش موجود (ده اللي بيعمل الـ Exception عندك)
          // كريته الأول وبعدين كمل بالرول الافتراضي
          role = 'user';
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                'email': user.email,
                'createdAt': FieldValue.serverTimestamp(),
                'role': role,
              });
        }

        // دلوقتي الـ role بقى معاه قيمة مضمونة (إما من السيرفر أو اللي إنت لسه مكريه)
        if (!context.mounted) return;

        emailCon.clear();
        passwordCon.clear();

        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => buttonadmin()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => CartViewModel(userEmail: user.uid),
                child: BottomNavigation(),
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // ... باقي كود الـ Error اللي إنت كاتبه زي ما هو
    } finally {
      setLoading(false);
    }
  }

  // 🔹 Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
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
      final user = userCredential.user;

      // هنا ممكن تحفظ بيانات الكارت لو تحب
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }
}
