import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shose_application_12/view/bottom_navigations.dart';
import '../viewmodel/signup_viewmodel.dart';

import 'login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignupViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 🔹 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgraound.avif'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 White Container
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: Center(
              child: ClipPath(
                clipper: TopLeftBigCurveClipper(),
                child: Container(
                  width: 500,
                  height: 900,
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
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
                        blurRadius: 15,
                        offset: const Offset(0, 5),
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
                          const SizedBox(height: 30),

                          const Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: "PTSerif-Bold",
                            ),
                          ),

                          const SizedBox(height: 40),

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

                          const SizedBox(height: 20),

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

                          const SizedBox(height: 20),

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

                          const SizedBox(height: 15),

                          // 🔹 Signup Button
                          MaterialButton(
                            onPressed: vm.isLoading
                                ? null
                                : () => vm.signup(context, BottomNavigation()),
                            color: Colors.black,
                            minWidth: 250,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: vm.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "PTSerif-Bold",
                                    ),
                                  ),
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Back to Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 13,
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
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 13,
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
            top: 40,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "assets/images/logo_app.jpg",
                height: 90,
                width: 100,
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(10),
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
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 18,
            ),
          ),
        ),
      ),
    );
  }
}
