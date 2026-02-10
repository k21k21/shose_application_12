import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/forgotpassword_viewmodel.dart';
import '../../login/view/login.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );

    final vm = context.watch<ForgotPasswordViewModel>();

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
            top: 180.h,
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
                    child: Column(
                      children: [
                        Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: "PTSerif-Bold",
                          ),
                        ),
                        SizedBox(height: 40.h),
                        _field(
                          controller: vm.emailController,
                          hint: "Enter your email",
                          icon: Icons.email,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return "Enter your email";
                            if (!v.contains('@')) return "Invalid email";
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        MaterialButton(
                          onPressed: vm.isLoading
                              ? null
                              : () => vm.resetPassword(context),
                          color: Colors.black,
                          minWidth: 1.sw,
                          height: 50.h,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: vm.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Send Reset Link",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "PTSerif-Bold",
                                  ),
                                ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remember your password?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: "PTSerif-Bold",
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 12.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon, color: Colors.black) : null,
            border: InputBorder.none,
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
      ),
    );
  }
}
