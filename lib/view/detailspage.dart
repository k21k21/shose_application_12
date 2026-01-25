import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shose_application_12/view/card.dart';

class detailspage extends StatefulWidget {
  const detailspage({super.key});

  @override
  State<detailspage> createState() => _detailspageState();
}

bool isSelected1 = false;
bool isSelected2 = false;
bool isSelected3 = false;
bool isSelected4 = false;

bool Selected1 = false;
bool Selected2 = false;
bool Selected3 = false;
bool Selected4 = false;
bool Selected5 = false;
bool Selected6 = false;

bool isFavorite = false;
double _dragPosition = 0;
bool _completed = false;

class _detailspageState extends State<detailspage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    double width = MediaQuery.of(context).size.width - 100.w;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: Padding(
          padding: EdgeInsets.all(10.w),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, size: 20.sp, color: Colors.black),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartPage()),
                  );
                },
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Container العلوي =====
            Stack(
              children: [
                Container(
                  height: 500.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: const Color(0xffCDEFE3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 120.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          "Nike Travis Scott",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto_Condensed",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 5.h),
                        child: Text(
                          "Men's Shose",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto_Condensed",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 200.h),
                        child: Text(
                          "Price\n160S",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto_Condensed",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: -210.w,
                  child: Transform.rotate(
                    angle: -0.6,
                    child: Image.asset(
                      "assets/images/s-l1200-removebg-preview.png",
                      width: 800.w,
                      height: 400.h,
                    ),
                  ),
                ),
              ],
            ),

            // ===== Description =====
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 30.h),
              child: Row(
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Roboto_Condensed",
                    ),
                  ),
                  SizedBox(width: 130.w),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellow,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 10.h, right: 10.w),
              child: Text(
                "Nike's first lifestyle Air Max brings you style, \ncomfort and big attitude in the Nike Air Max 270 ... Read More",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: "Roboto_Condensed",
                ),
              ),
            ),

            // ===== Select Color =====
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 10.w),
              child: Row(
                children: [
                  Text(
                    "Select color",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Roboto_Condensed",
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    buildColorOption(
                      "assets/images/s-l1200-removebg-preview.png",
                      isSelected1,
                      () {
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = false;
                          isSelected3 = false;
                          isSelected4 = false;
                        });
                      },
                    ),
                    SizedBox(width: 10.w),
                    buildColorOption(
                      "assets/images/s-l1200-removebg-preview.png",
                      isSelected2,
                      () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = true;
                          isSelected3 = false;
                          isSelected4 = false;
                        });
                      },
                    ),
                    SizedBox(width: 10.w),
                    buildColorOption(
                      "assets/images/s-l1200-removebg-preview.png",
                      isSelected3,
                      () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = false;
                          isSelected3 = true;
                          isSelected4 = false;
                        });
                      },
                    ),
                    SizedBox(width: 10.w),
                    buildColorOption(
                      "assets/images/s-l1200-removebg-preview.png",
                      isSelected4,
                      () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = false;
                          isSelected3 = false;
                          isSelected4 = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ===== Size =====
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 10.w),
              child: Row(
                children: [
                  Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Roboto_Condensed",
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    buildSizeOption("40", Selected1, () {
                      setState(() {
                        Selected1 = true;
                        Selected2 = Selected3 = Selected4 = Selected5 =
                            Selected6 = false;
                      });
                    }),
                    SizedBox(width: 10.w),
                    buildSizeOption("41", Selected2, () {
                      setState(() {
                        Selected2 = true;
                        Selected1 = Selected3 = Selected4 = Selected5 =
                            Selected6 = false;
                      });
                    }),
                    SizedBox(width: 10.w),
                    buildSizeOption("42", Selected3, () {
                      setState(() {
                        Selected3 = true;
                        Selected1 = Selected2 = Selected4 = Selected5 =
                            Selected6 = false;
                      });
                    }),
                    SizedBox(width: 10.w),
                    buildSizeOption("43", Selected4, () {
                      setState(() {
                        Selected4 = true;
                        Selected1 = Selected2 = Selected3 = Selected5 =
                            Selected6 = false;
                      });
                    }),
                    SizedBox(width: 10.w),
                    buildSizeOption("44", Selected5, () {
                      setState(() {
                        Selected5 = true;
                        Selected1 = Selected2 = Selected3 = Selected4 =
                            Selected6 = false;
                      });
                    }),
                    SizedBox(width: 10.w),
                    buildSizeOption("45", Selected6, () {
                      setState(() {
                        Selected6 = true;
                        Selected1 = Selected2 = Selected3 = Selected4 =
                            Selected5 = false;
                      });
                    }),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // ===== Add to Cart Row =====
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 60.h),
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    width: width,
                    height: 60.h,
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffeeeeee),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _completed ? "Done!" : "Add to cart",
                            style: TextStyle(
                              color: const Color.fromARGB(137, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                        Positioned(
                          left: _dragPosition,
                          child: GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              setState(() {
                                _dragPosition += details.delta.dx;
                                if (_dragPosition < 0) _dragPosition = 0;
                                if (_dragPosition > width - 60.w)
                                  _dragPosition = width - 60.w;
                              });
                            },
                            onHorizontalDragEnd: (details) {
                              if (_dragPosition >= width - 60.w) {
                                setState(() {
                                  _completed = true;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Action Completed!"),
                                  ),
                                );

                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() {
                                    _dragPosition = 0;
                                    _completed = false;
                                  });
                                });
                              } else {
                                setState(() {
                                  _dragPosition = 0;
                                });
                              }
                            },
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.shopping_cart_checkout,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Helper Widgets =====
  Widget buildColorOption(String image, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? Colors.black : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }

  Widget buildSizeOption(String size, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? Colors.black : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
