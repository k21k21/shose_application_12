import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shose_application_12/Admin/adminbutton.dart';
import 'package:shose_application_12/User/login/widgets/googlespinner.dart';
import 'package:shose_application_12/User/BottomNavigation/bottom_navigations.dart';
import '../../forgotpassword/viewmodel/forgotpassword_viewmodel.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../forgotpassword/view/forgotpassword.dart';
import '../../signup/view/signup.dart';

class TopLeftBigCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(0, 0, size.width * 0.3, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoadingGoogle = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );

    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 🔹 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgraound.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 White Container
          Positioned(
            top: 170.h,
            left: 0,
            right: 0,
            child: Center(
              child: ClipPath(
                clipper: TopLeftBigCurveClipper(),
                child: Container(
                  width: 1.sw,
                  height: 0.9.sh,
                  padding: EdgeInsets.symmetric(
                    vertical: 40.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white70],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 40.h),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "PTSerif-Bold",
                            ),
                          ),
                          SizedBox(height: 40.h),
                          _field(
                            controller: vm.emailCon,
                            hint: "Email",
                            icon: Icons.email,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Enter your email";
                              if (!v.contains('@')) return "Invalid email";
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          _field(
                            controller: vm.passwordCon,
                            hint: "Password",
                            icon: Icons.lock,
                            obscure: true,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Enter your password";
                              if (v.length < 6) return "Min 6 characters";
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                      create: (_) => ForgotPasswordViewModel(),
                                      child: ForgotPasswordPage(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontFamily: "PTSerif-Bold",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 13.h),

                          MaterialButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              setState(() => vm.isLoading = true);

                              try {
                                // تسجيل الدخول مباشرة عن طريق FirebaseAuth
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                      email: vm.emailCon.text.trim(),
                                      password: vm.passwordCon.text.trim(),
                                    );

                                // خد الانستانس الحالي من FirebaseAuth
                                final user = FirebaseAuth.instance.currentUser;

                                if (user != null) {
                                  if (user.email == 'userr@admin.com') {
                                    // صفحة الادمن
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const buttonadmin(),
                                      ),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation(),
                                      ),
                                    );
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Login failed: ${e.message}"),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              } finally {
                                if (mounted)
                                  setState(() => vm.isLoading = false);
                              }
                            },
                            color: Colors.black,
                            minWidth: 250.w,
                            height: 50.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "PTSerif-Bold",
                              ),
                            ),
                          ),

                          SizedBox(height: 10.h),

                          // ✅ Google Button
                          MaterialButton(
                            onPressed: () async {
                              if (_isLoadingGoogle) return;

                              setState(() => _isLoadingGoogle = true);

                              try {
                                final user = await vm.signInWithGoogle();

                                if (user != null && mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BottomNavigation(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Google sign in failed'),
                                  ),
                                );
                              } finally {
                                if (!mounted) return;
                                setState(() => _isLoadingGoogle = false);
                              }
                            },

                            height: 50.h,
                            minWidth: 250.w,
                            child: _isLoadingGoogle
                                ? const GoogleLoader() // Spinner الملون يظهر بدل الصورة
                                : Image.asset(
                                    'assets/images/search.png',
                                    height: 30.h,
                                  ),
                          ),

                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontFamily: "PTSerif-Bold",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontFamily: "PTSerif-Bold",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 40.h,
            left: 0.5.sw - 50.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.asset(
                "assets/images/logo_app.jpg",
                height: 90.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ✅ Loading overlay in center of page for Login only
          if (vm.isLoading && !_isLoadingGoogle)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: TextFormField(
        controller: controller,
        obscureText: obscure ? _obscurePassword : false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon, color: Colors.black) : null,
          suffixIcon: obscure
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 18.h,
          ),
        ),
      ),
    );
  }
}
