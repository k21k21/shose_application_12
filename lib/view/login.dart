import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../viewmodel/forgotpassword_viewmodel.dart';
import '../viewmodel/login_viewmodel.dart';
import 'forgotpassword.dart';
import 'signup.dart';
import 'homepage.dart';

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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

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
                      vertical: 40, horizontal: 20),
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
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom,
                    ),
                    child: Form(
                      key: vm.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontFamily: "PTSerif-Bold"
                            ),
                          ),

                          const SizedBox(height: 40),

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

                          const SizedBox(height: 20),

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
                                    builder: (_) =>
                                        ChangeNotifierProvider(
                                          create: (_) =>
                                              ForgotPasswordViewModel(),
                                          child: ForgotPasswordPage(),
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "PTSerif-Bold"
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 13),

                          // 🔹 Login Button
                          MaterialButton(
                            onPressed: vm.isLoading
                                ? null
                                : () => vm.login(context, HomePage()),
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
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PTSerif-Bold"
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          // 🔹 Google Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Google Button
                              MaterialButton(
                                onPressed: () =>
                                    vm.signInWithGoogle(context, HomePage()),


                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/search.png',
                                      height: 30,
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 2,),
                          // 🔹 Create Account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 15,
                                    fontFamily: "PTSerif-Bold"),

                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const signup(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Create Account",
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
          ),

          // 🔹 Logo
          Positioned(
            top: 40,
            left: MediaQuery
                .of(context)
                .size
                .width / 2 - 50,
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

  // 🔹 Reusable Field
  Widget _field({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}