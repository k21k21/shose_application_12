import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shose_application_12/User/login/view/login.dart';
import 'package:shose_application_12/User/BottomNavigation/bottom_navigations.dart';
import '../viewmodel/signup_viewmodel.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );

    final vm = context.watch<SignupViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 🔹 Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgraound.png',
              fit: BoxFit.cover,
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
                      key: vm.formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),

                          Text(
                            "SignUp",
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
                              if (v == null || v.isEmpty) {
                                return "Enter your email";
                              }
                              if (!v.contains('@')) {
                                return "Invalid email";
                              }
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
                              if (v == null || v.isEmpty) {
                                return "Enter your password";
                              }
                              if (v.length < 6) {
                                return "Min 6 characters";
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 20.h),

                          _field(
                            controller: vm.confirmPasswordCon,
                            hint: "Confirm Password",
                            icon: Icons.lock,
                            obscure: true,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Confirm your password";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 15.h),

                          // 🔹 Signup Button
                          MaterialButton(
                            onPressed: vm.isLoading
                                ? null
                                : () => vm.signup(context, BottomNavigation()),
                            color: Colors.black,
                            minWidth: 250.w,
                            height: 50.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: vm.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "PTSerif-Bold",
                                    ),
                                  ),
                          ),

                          SizedBox(height: 10.h),

                          // 🔹 Back to Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: "PTSerif-Bold",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const loginpage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: "PTSerif-Bold",
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
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

          // 🔹 Logo
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
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(10.r),
        ),
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
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
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
              horizontal: 25.w,
              vertical: 18.h,
            ),
          ),
        ),
      ),
    );
  }
}
