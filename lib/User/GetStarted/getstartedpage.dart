import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 6, 183, 115),
              const Color.fromARGB(255, 0, 0, 0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    "assets/images/logo_app.jpg",
                    height: 90.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  "Stars",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto_Condensed",
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),

                Stack(
                  alignment: AlignmentGeometry.topRight,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset(
                            "assets/images/images-removebg-preview.png",
                            width: 600,
                            height: 600,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 350),
                      child: Row(
                        children: [
                          Text(
                            "Start Your Journey \n With Nike",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto_Condensed",
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
