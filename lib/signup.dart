import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shose_application_12/homepage.dart';
import 'package:shose_application_12/login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class TopLeftBigCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // منحنى كبير من الأعلى الشمال
    path.moveTo(0, size.height * 0.2); // بداية من اليسار 20% ارتفاع
    path.quadraticBezierTo(
      0,
      0, // نقطة التحكم فوق
      size.width * 0.3,
      0, // نهاية المنحنى عند 30% من العرض
    );

    path.lineTo(size.width, 0); // الباقي أعلى يمين
    path.lineTo(size.width, size.height); // اليمين كله للأسفل
    path.lineTo(0, size.height); // الأسفل كله لليسار
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _signupState extends State<signup> {
  final TextEditingController emailcon = TextEditingController();
  final TextEditingController passwordcon = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 الخلفية
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgraound.avif'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 الكونتينر الأبيض نازل لتحت (قص من فوق)
          Positioned(
            top: 170, // القص من فوق زي ما عملت
            left: 0,
            right: 0,
            child: Center(
              child: ClipPath(
                clipper: TopLeftBigCurveClipper(), // 👈 هنا الموجة
                child: Container(
                  width: 500,
                  height: 900,
                  color: Colors.white,
                  child: Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Full name",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Last name",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: emailcon,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: " Email",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: emailcon,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),
                        MaterialButton(
                          onPressed: () async {
                            {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                      email: emailcon.text.trim(),
                                      password: passwordcon.text.trim(),
                                    );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.message ?? "Something went wrong",
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          color: const Color.fromARGB(255, 0, 0, 0),
                          minWidth: 400,
                          height: 60,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 30),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => loginpage(),
                              ),
                            );
                          },
                          child: Text(
                            "You have an account? Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
