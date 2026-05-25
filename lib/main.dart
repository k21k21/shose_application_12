import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shose_application_12/Admin/adminbutton.dart';
import 'package:shose_application_12/User/BottomNavigation/bottom_navigations.dart';
import 'package:shose_application_12/User/SplashScreen/SplashScreen.dart';
import 'package:shose_application_12/User/card/viewmodel/cart_viewmodel.dart';
import 'package:shose_application_12/User/setting/viewmodel/app_settings.dart';
import 'package:shose_application_12/User/forgotpassword/viewmodel/forgotpassword_viewmodel.dart';
import 'package:shose_application_12/User/signup/viewmodel/signup_viewmodel.dart';
import 'User/login/view/login.dart';
import 'User/login/viewmodel/login_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel(userEmail: '')),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => AppSettings()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user != null) {
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // هنا بقى التعديل اللي هيشيل الخط الأحمر نهائياً:
              final dynamic data =
                  roleSnapshot.data; // استلمنا الداتا كـ dynamic مؤقتاً

              // شيك لو الداتا موجودة وحولها لـ Map
              final Map<String, dynamic>? userData =
                  (data != null && data.exists)
                  ? data.data() as Map<String, dynamic>?
                  : null;

              final String role = userData?['role'] ?? 'user';

              if (role == 'admin') {
                return const buttonadmin();
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<CartViewModel>(
                    context,
                    listen: false,
                  ).setUser(user.uid);
                });
                return const BottomNavigation();
              }
            },
          );
        }

        return const loginpage();
      },
    );
  }
}
