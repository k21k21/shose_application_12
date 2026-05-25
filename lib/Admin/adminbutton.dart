import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shose_application_12/Admin/Total_Orders/totalorders.dart';
import 'package:shose_application_12/User/login/view/login.dart';

class buttonadmin extends StatefulWidget {
  const buttonadmin({super.key});

  @override
  State<buttonadmin> createState() => _buttonadminState();
}

class _buttonadminState extends State<buttonadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              "Admin",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto_Condensed",
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        width: 400.w,
                        height: 270.h,
                        color: const Color.fromARGB(255, 237, 237, 237),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0.h,
                              left: 0.w,
                              right: 0.w,
                              height: 200.h,
                              child: Image.asset(
                                "assets/images/Addproducttt.png",
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              top: 210.h,
                              left: 10.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add Product",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              bottom: 0.h,
                              right: 0.w,

                              child: IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => AddProductPage(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 400.w,
                        height: 270.h,
                        color: const Color.fromARGB(255, 237, 237, 237),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0.h,
                              left: 0.w,
                              right: 0.w,
                              height: 200.h,
                              child: Image.asset(
                                "assets/images/orderss.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              top: 210.h,
                              left: 10.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Orders",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Orders')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text(
                                          "...",
                                          style: TextStyle(fontSize: 14),
                                        );
                                      }

                                      int numberOfOrders =
                                          snapshot.data?.docs.length ?? 0;

                                      return Text(
                                        "Total: $numberOfOrders",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              bottom: 0.h,
                              right: 0.w,

                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => totalorders(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => loginpage()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
