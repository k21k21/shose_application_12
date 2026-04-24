import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

      // ✅ مسح البيانات بعد نجاح تسجيل الدخول
      emailCon.clear();
      passwordCon.clear();

      if (user != null) {
        // تأكد بيانات المستخدم موجودة في Firestore
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!doc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                'email': user.email,
                'createdAt': FieldValue.serverTimestamp(),
              });
        }

        if (!context.mounted) return;

        // ⚡ الانتقال للصفحة الرئيسية بأمان
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => CartViewModel(userEmail: user.uid),
              child: BottomNavigation(), // (لو عندك الصفحة دي)
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Login failed",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
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
