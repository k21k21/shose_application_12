<<<<<<< Updated upstream:lib/User/save/view/favorite_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CollectionDetailsPage.dart';

// --- 1. الموديل (Data Model) ---
class Collection {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  // تم إزالة isFavorite كما طلبت

  Collection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

// --- 2. الصفحة الرئيسية ---
class ShoeLibraryScreen extends StatefulWidget {
  const ShoeLibraryScreen({super.key});

  @override
  State<ShoeLibraryScreen> createState() => _ShoeLibraryScreenState();
}

class _ShoeLibraryScreenState extends State<ShoeLibraryScreen> {
  // بيانات تجريبية
  List<Collection> myCollections = [
    Collection(
      id: '1',
      title: "Nike Running",
      subtitle: "Zoom Fly 5 • 12 Items",
      imageUrl:
          "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-mens-shoes-jBrhbr.png",
    ),
    Collection(
      id: '2',
      title: "Classic Formal",
      subtitle: "Oxford & Loafers • 5 Items",
      imageUrl:
          "https://img.freepik.com/free-photo/leather-shoes_1203-8120.jpg?w=900",
    ),
    Collection(
      id: '3',
      title: "Jordan Retro",
      subtitle: "High Tops • 8 Items",
      // تم تغيير الرابط ليكون مستقراً أكثر، وتم إضافة معالج أخطاء في الكود
      imageUrl:
          "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/5a709085-3b02-463d-8e8e-c9062334863b/air-jordan-1-mid-se-shoes-Zn07hL.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F9F9,
      ), // لون أبيض مائل للرمادي قليلاً للراحة
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              // --- Header Section (Clean & Bold) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Library",
                        style: GoogleFonts.dmSans(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${myCollections.length} Collections",
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // زر الإضافة بتصميم أيقوني بسيط وأنيق
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _showAddCollectionDialog,
                      borderRadius: BorderRadius.circular(50.r),
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: Colors.black, // Dark Mode feel button
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // --- List Section ---
              Expanded(
                child: myCollections.isEmpty
                    ? _buildEmptyState() // في حالة لا توجد بيانات
                    : ListView.separated(
                        itemCount: myCollections.length,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        padding: EdgeInsets.only(bottom: 20.h),
                        itemBuilder: (context, index) {
                          final item = myCollections[index];
                          return _buildCollectionCard(item, index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildCollectionCard(Collection item, int index) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE), // أحمر فاتح جداً
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red[400],
          size: 28.sp,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          myCollections.removeAt(index);
        });
      },
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
          ), // حدود خفيفة بدلاً من الظل القوي
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE0E0E0).withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          onTap: () async {
            // الانتقال للصفحة الجديدة مع تمرير بيانات الكوليكشن
            // ننتظر النتيجة (في حال تم تعديل الاسم نحدث الصفحة)
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CollectionDetailsPage(collection: item),
              ),
            );

            // إذا رجعنا بتعديل جديد، نحدث الواجهة
            if (result != null && result is Collection) {
              setState(() {
                // تحديث العنصر في الليستة
                myCollections[index] = result;
              });
            }
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                // 1. الصورة (Image) مع معالجة الأخطاء
                Container(
                  width: 70.h,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.contain, // يجعل الحذاء كاملاً داخل الصندوق
                      // --- هذا هو حل مشكلة الصورة ---
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey[400],
                            size: 24.sp,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(width: 16.w),

                // 2. النصوص (Texts)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.dmSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF000000),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.dmSans(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // 3. أيقونة التوجيه (Arrow) بدلاً من القلب
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[300],
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.layers_clear_outlined,
            size: 60.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Text(
            "No collections yet",
            style: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  // --- Dialog Function ---
  void _showAddCollectionDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Collection",
                style: GoogleFonts.dmSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: controller,
                autofocus: true,
                style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Collection Name",
                  hintStyle: GoogleFonts.dmSans(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        foregroundColor: Colors.grey[600],
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          setState(() {
                            myCollections.add(
                              Collection(
                                id: DateTime.now().toString(),
                                title: controller.text,
                                subtitle: "0 Items",
                                // صورة افتراضية نظيفة
                                imageUrl:
                                    "https://cdn-icons-png.flaticon.com/512/5499/5499206.png",
                              ),
                            );
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        "Create",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CollectionDetailsPage.dart';

// --- 1. الموديل (Data Model) ---
class Collection {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  Collection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  // Factory constructor to create a Collection from a Firestore document
  factory Collection.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Collection(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      subtitle: data['subtitle'] ?? 'No Subtitle',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Method to convert a Collection to a map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
    };
  }
}

class ShoeLibraryScreen extends StatefulWidget {
  const ShoeLibraryScreen({super.key});

  @override
  State<ShoeLibraryScreen> createState() => _ShoeLibraryScreenState();
}

class _ShoeLibraryScreenState extends State<ShoeLibraryScreen> {
  // Get a reference to the Firestore collection
  final CollectionReference _collectionsStream =
      FirebaseFirestore.instance.collection('saves');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _collectionsStream.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final collections = snapshot.data!.docs
                .map((doc) => Collection.fromFirestore(doc))
                .toList();

            return Padding(
              padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  // --- Header Section ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Library",
                            style: GoogleFonts.dmSans(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${collections.length} Collections", // Updated count
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Add button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _showAddCollectionDialog,
                          borderRadius: BorderRadius.circular(50.r),
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Icon(Icons.add,
                                color: Colors.white, size: 24.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32.h),
                  // --- List Section ---
                  Expanded(
                    child: collections.isEmpty
                        ? _buildEmptyState()
                        : ListView.separated(
                            itemCount: collections.length,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.h),
                            padding: EdgeInsets.only(bottom: 20.h),
                            itemBuilder: (context, index) {
                              final item = collections[index];
                              return _buildCollectionCard(item);
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // --- UI Components ---
  Widget _buildCollectionCard(Collection item) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(Icons.delete_outline_rounded,
            color: Colors.red[400], size: 28.sp),
      ),
      onDismissed: (direction) {
        // Delete from Firestore
        FirebaseFirestore.instance.collection('saves').doc(item.id).delete();
      },
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE0E0E0).withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CollectionDetailsPage(collection: item),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Container(
                  width: 70.h,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.image_not_supported_outlined,
                              color: Colors.grey[400], size: 24.sp),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2)));
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.dmSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF000000),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.dmSans(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[300],
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.layers_clear_outlined, size: 60.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text(
            "No collections yet",
            style: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 16.sp),
          )
        ],
      ),
    );
  }

  // --- Dialog Function ---
  void _showAddCollectionDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Collection",
                style: GoogleFonts.dmSans(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: controller,
                autofocus: true,
                style: GoogleFonts.dmSans(
                    color: Colors.black, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "Collection Name",
                  hintStyle: GoogleFonts.dmSans(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          foregroundColor: Colors.grey[600]),
                      child: Text("Cancel",
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          // Create a new Collection object
                          final newCollection = Collection(
                            id: '', // Firestore will generate the ID
                            title: controller.text,
                            subtitle: "0 Items",
                            imageUrl:
                                "https://cdn-icons-png.flaticon.com/512/5499/5499206.png",
                          );
                          // Add to Firestore
                          FirebaseFirestore.instance
                              .collection('saves')
                              .add(newCollection.toFirestore())
                              .then((value) => print("Collection Added"))
                              .catchError((error) => print("Failed to add collection: $error"));
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r)),
                      ),
                      child: Text(
                        "Create",
                        style: GoogleFonts.dmSans(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes:lib/save/view/favorite_view.dart
