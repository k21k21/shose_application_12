import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ), // نفس الخلفية المريحة اللي في الصورة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context); // هيرجعك للصفحة اللي قبلك علطول
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 24, // الحجم المناسب للـ UI اللي صورته
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                "My Orders",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto_Condensed",
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .orderBy('Order Date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Orders Yet", style: TextStyle(fontSize: 16.sp)),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderDoc = snapshot.data!.docs[index];
              var orderData = orderDoc.data() as Map<String, dynamic>;
              List items = orderData.containsKey('items')
                  ? orderData['items']
                  : [];

              return Container(
                margin: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ), // حواف دائرية زي الصورة
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 8.h,
                    ),
                    leading: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                        size: 28.w,
                      ),
                    ),
                    title: Text(
                      "Order #${orderDoc.id.substring(0, 5).toUpperCase()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "${items.length} Items • ${orderData['totalAmount'] ?? 0} EGP",
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 14.w,
                      color: Colors.grey,
                    ),
                    children: [
                      const Divider(indent: 20, endIndent: 20, thickness: 0.5),
                      ...items.map((item) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          title: Text(
                            item['productName'] ?? 'Product',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                          subtitle: Text(
                            "Qty: ${item['quantity']} - Price: ${item['price']} EGP",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                          trailing: Container(
                            width: 50.w, // كبرناها شوية عشان تفاصيل الشوز تبان
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFF1F1F1,
                              ), // خلفية رمادي خفيفة لو الصورة شفافة
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                // تأكد هل هي 'image' ولا 'img' زي ما إنت كاتبها في الداتا للي بتترفع
                                image: NetworkImage(
                                  item['image'] ?? item['image'] ?? '',
                                ),
                                fit: BoxFit
                                    .contain, // contain أحسن للكوتشيات عشان متبقاش مقصوصة
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
