import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/forgotpassword_viewmodel.dart';
import 'login.dart';



class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ForgotPasswordViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgraound.avif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Center(
              child: ClipPath(
                clipper: TopLeftBigCurveClipper(),
                child: Container(
                  height: 900,
                  width: 500,
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
                    child: Column(
                      children: [
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: "PTSerif-Bold"
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: _field(
                            controller: vm.emailController,
                            hint: "Enter your email",
                            icon: Icons.email,
                            validator: (v) {
                              if (v == null || v.isEmpty) return "Enter your email";
                              if (!v.contains('@')) return "Invalid email";
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          onPressed: vm.isLoading
                              ? null
                              : () => vm.resetPassword(context),
                          color: Colors.black,
                          minWidth: double.infinity,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: vm.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            "Send Reset Link",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "PTSerif-Bold"
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Remember your password?",
                              style: TextStyle(fontSize: 15,
                                  fontFamily: "PTSerif-Bold"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontFamily: "PTSerif-Bold"
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
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
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ),
    );
  }
}
