import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shose_application_12/User/card/view/card.dart';

class detailspage extends StatefulWidget {
  final Color bgColor;
  final List<Map<String, dynamic>> brandProducts;
  final int selectedIndex;

  const detailspage({
    super.key,
    required this.bgColor,
    required this.brandProducts,
    required this.selectedIndex,
  });

  @override
  State<detailspage> createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  late int selectedIndex;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  bool isSelected5 = false;
  bool isSelected6 = false;

  bool Selected1 = false;
  bool Selected2 = false;
  bool Selected3 = false;
  bool Selected4 = false;
  bool Selected5 = false;
  bool Selected6 = false;
  bool Selected7 = false;
  bool Selected27 = false;

  bool isFavorite = false;
  double _dragPosition = 0;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    double width = MediaQuery.of(context).size.width - 100.w;
    final selectedProduct = widget.brandProducts[selectedIndex];

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
                  height: 400.h,
                  width: 1.sw,
                  decoration: BoxDecoration(color: widget.bgColor),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 100.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              selectedProduct['name'] ?? "nodata",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                fontFamily: "Roboto_Condensed",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 5.h),
                            child: Text(
                              selectedProduct['namebrand'] ?? "nodata",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto_Condensed",
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// ✅ الشريط اللي طالع من تحت
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 100.w,
                          height: 170.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.r),
                            ),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        selectedProduct['price']?.toString() ??
                                        "nodata",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto_Condensed",
                                    ),
                                  ),
                                  TextSpan(
                                    text: " EGP",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Roboto_Condensed",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ✅ صورة الجزمة
                Center(
                  child: Transform.rotate(
                    angle: -0.6,
                    child: (selectedProduct['img'] != null)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Image.memory(
                              base64Decode(
                                selectedProduct['img'].toString().contains(',')
                                    ? selectedProduct['img']
                                          .toString()
                                          .split(',')
                                          .last
                                    : selectedProduct['img'].toString(),
                              ),
                              width: 350,
                              height: 350,
                            ),
                          )
                        : Text("noimg"),
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
                  SizedBox(width: 120.w),
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
                  children: List.generate(widget.brandProducts.length, (index) {
                    var product = widget.brandProducts[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 80.w,
                        height: 100.h,
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 243, 243),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedIndex == index
                                ? widget.bgColor
                                : const Color.fromARGB(255, 245, 243, 243),
                            width: 2,
                          ),
                        ),
                        child: (product['img'] != null)
                            ? Image.memory(
                                base64Decode(
                                  product['img'].toString().contains(',')
                                      ? product['img']
                                            .toString()
                                            .split(',')
                                            .last
                                      : product['img'].toString(),
                                ),
                                width: 350,
                                height: 350,
                                fit: BoxFit.cover,
                              )
                            : Text("noimg"),
                      ),
                    );
                  }),
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
                    buildSizeOption("39", Selected27, () {
                      setState(() {
                        Selected27 = true;
                        Selected1 = false;
                        Selected2 = false;
                        Selected3 = false;
                        Selected4 = false;
                        Selected5 = false;
                        Selected6 = false;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("40", Selected1, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = true;
                        Selected2 = false;
                        Selected3 = false;
                        Selected4 = false;
                        Selected5 = false;
                        Selected6 = false;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("41", Selected2, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = false;
                        Selected2 = true;
                        Selected3 = false;
                        Selected4 = false;
                        Selected5 = false;
                        Selected6 = false;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("42", Selected3, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = false;
                        Selected2 = false;
                        Selected3 = true;
                        Selected4 = false;
                        Selected5 = false;
                        Selected6 = false;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("43", Selected4, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = false;
                        Selected2 = false;
                        Selected3 = false;
                        Selected4 = true;
                        Selected5 = false;
                        Selected6 = false;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("44", Selected5, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = false;
                        Selected2 = false;
                        Selected3 = false;
                        Selected4 = false;
                        Selected5 = true;
                        Selected6 = false;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("45", Selected6, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = false;
                        Selected2 = false;
                        Selected3 = false;
                        Selected4 = false;
                        Selected5 = false;
                        Selected6 = true;
                        Selected7 = false;
                      });
                    }),
                    buildSizeOption("46", Selected7, () {
                      setState(() {
                        Selected27 = false;
                        Selected1 = false;
                        Selected2 = false;
                        Selected3 = false;
                        Selected4 = false;
                        Selected5 = false;
                        Selected6 = false;
                        Selected7 = true;
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
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined,
                        color: widget.bgColor,
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
                            color: const Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _completed ? "Done!" : "Add to cart",
                            style: TextStyle(
                              color: widget.bgColor,
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
                                color: widget.bgColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Icon(
                                Icons.shopping_cart_checkout_outlined,
                                color: const Color.fromARGB(255, 0, 0, 0),
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
  Widget buildSizeOption(String size, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 70.h,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 243, 243),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected
                ? widget.bgColor
                : const Color.fromARGB(255, 245, 243, 243),
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
