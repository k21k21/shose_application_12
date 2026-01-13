import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/signup_viewmodel.dart';
import '../homepage.dart';
import 'login.dart';

class signup extends StatelessWidget {
  const signup({super.key});

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
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                          const SizedBox(height: 40),

                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 40),

                          _field(
                            controller: vm.emailCon,
                            hint: "Email",
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
                                : () => vm.signup(context, HomePage()),
                            color: Colors.black,
                            minWidth: 300,
                            height: 40,
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
                                style: TextStyle(fontSize: 18),
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
                                    fontSize: 20,
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
          obscureText: obscure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          ),
        ),
      ),
    );
  }
}
