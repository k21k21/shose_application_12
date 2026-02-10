import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/chage_passwordviewmodel.dart';
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

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool hasSpecialChar = false;

  void _checkPassword(String value) {
    setState(() {
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasNumber = value.contains(RegExp(r'[0-9]'));
      hasMinLength = value.length >= 6;
      hasSpecialChar = value.contains(RegExp(r'[@$%#]'));
    });
  }

  String _passwordHint() {
    if (!hasUppercase) return "Must contain a capital letter";
    if (!hasNumber) return "Must contain a number";
    if (!hasSpecialChar) return "Must contain a special character";
    if (!hasMinLength) return "At least 6 characters";
    return "";
  }

  bool get isPasswordValid =>
      hasUppercase && hasNumber && hasMinLength && hasSpecialChar;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );

    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/backgraound.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                            vertical: 40.h, horizontal: 20.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.white, Colors.white70],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15.r,
                                offset: Offset(0, 5.h))
                          ],
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom:
                              MediaQuery
                                  .of(context)
                                  .viewInsets
                                  .bottom),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 40.h),
                                Text(
                                  "Change Password",
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "PTSerif-Bold"),
                                ),
                                SizedBox(height: 30.h),
                                _field(
                                  controller: currentController,
                                  hint: "Password",
                                  obscureText: obscureCurrent,
                                  toggle: () {
                                    setState(() {
                                      obscureCurrent = !obscureCurrent;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.h),
                                _field(
                                  controller: newController,
                                  hint: "New Password",
                                  obscureText: obscureNew,
                                  toggle: () {
                                    setState(() {
                                      obscureNew = !obscureNew;
                                    });
                                  },
                                  onChanged: _checkPassword,
                                ),
                                if (!isPasswordValid &&
                                    newController.text.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 4.h),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _passwordHint(),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 20.h),
                                _field(
                                  controller: confirmController,
                                  hint: "Confirm Password",
                                  obscureText: obscureConfirm,
                                  toggle: () {
                                    setState(() {
                                      obscureConfirm = !obscureConfirm;
                                    });
                                  },
                                  validator: (v) {
                                    if (v != newController.text) return "Passwords do not match";
                                    return null;
                                  },
                                ),
                                SizedBox(height: 30.h),
                                vm.isLoading
                                    ? const CircularProgressIndicator()
                                    : SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!
                                          .validate()) {
                                        final success =
                                        await vm.changePassword(
                                          currentPassword:
                                          currentController.text,
                                          newPassword:
                                          newController.text,
                                        );

                                        if (success && context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Password changed successfully"),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      "Change Password",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "PTSerif-Bold"),
                                    ),
                                  ),
                                ),
                                if (vm.errorMessage != null) ...[
                                  SizedBox(height: 12.h),
                                  Text(
                                    vm.errorMessage!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ]
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
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required bool obscureText,
    required VoidCallback toggle,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
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
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
            onPressed: toggle,
          ),
        ),
      ),
    );
  }
}
