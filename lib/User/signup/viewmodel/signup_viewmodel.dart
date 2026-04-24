import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shose_application_12/User/BottomNavigation/bottom_navigations.dart';

import 'package:shose_application_12/User/card/viewmodel/cart_viewmodel.dart';

class SignupViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final confirmPasswordCon = TextEditingController();
  bool isLoading = false;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> signup(
    BuildContext context, [
    BottomNavigation? bottomNavigation,
  ]) async {
    if (!formKey.currentState!.validate()) return;
    if (passwordCon.text != confirmPasswordCon.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "Passwords do not match",
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
      return;
    }

    setLoading(true);

    try {
      // إنشاء المستخدم
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailCon.text.trim(),
            password: passwordCon.text.trim(),
          );

      final user = userCredential.user;

      if (user != null) {
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

        // ⚡ الانتقال إلى الصفحة الرئيسية بأمان
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => CartViewModel(userEmail: user.uid),
              child: BottomNavigation(), // 🔥 مهم جدًا
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "Signup failed",
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

    setLoading(false);
  }

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    confirmPasswordCon.dispose();
    super.dispose();
  }
}
