import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أنيميشن الأيقونة (بتكبر من الصفر للواحد)
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.elasticOut, // حركة مرنة "Pop-up"
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: const BoxDecoration(
                      color: Colors.black, // اللون الأسود المعتمد
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 90.sp,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40.h),

            Text(
              "Order Completed!",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto_Condensed",
              ),
            ),

            SizedBox(height: 15.h),

            Text(
              "Thank you for your purchase.\nYour order has been received.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontFamily: "Roboto_Condensed",
              ),
            ),

            SizedBox(height: 60.h),

            // زرار الرجوع للرئيسية بنفس ستايلك
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Container(
                width: double.infinity,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Roboto_Condensed",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
