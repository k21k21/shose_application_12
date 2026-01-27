import 'dart:ui' as dart_ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/save_viewmodel.dart';
import 'favorite_view.dart';

class CollectionDetailsPage extends StatefulWidget {
  final Collection collection;

  const CollectionDetailsPage({super.key, required this.collection});

  @override
  State<CollectionDetailsPage> createState() => _CollectionDetailsPageState();
}

class _CollectionDetailsPageState extends State<CollectionDetailsPage> {
  late Collection currentCollection;

  // قائمة وهمية للأحذية داخل هذا الكوليكشن
  final List<Map<String, dynamic>> shoes = [
    {"name": "Nike Air Max", "price": "\$120", "img": "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-mens-shoes-jBrhbr.png"},
    {"name": "Zoom Fly 5", "price": "\$150", "img": "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/5a709085-3b02-463d-8e8e-c9062334863b/air-jordan-1-mid-se-shoes-Zn07hL.png"},
    {"name": "Pegasus 40", "price": "\$130", "img": "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/07365005-2d4e-4861-b51e-627762694380/air-jordan-1-low-mens-shoes-0LXhbn.png"},
    {"name": "Dunk Low", "price": "\$110", "img": "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/99486859-0ff3-46b4-949b-2d16af2ad421/custom-nike-dunk-low-by-you-su21.png"},
  ];

  @override
  void initState() {
    super.initState();
    currentCollection = widget.collection;
  }

  @override
  Widget build(BuildContext context) {
    // نستخدم WillPopScope لنضمن إرجاع البيانات المعدلة عند الضغط على زر الرجوع في الهاتف
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context, currentCollection);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. الجزء العلوي المتحرك (The Cinematic Header)
            SliverAppBar(
              expandedHeight: 320.h, // ارتفاع كبير للصورة
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true, // يثبت البار عند السكرول
              stretch: true, // تأثير تمدد الصورة عند السحب لأسفل
              leading: Padding(
                padding: EdgeInsets.all(8.w),
                child: _buildGlassButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context, currentCollection),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: _buildGlassButton(
                    icon: Icons.edit_outlined,
                    onTap: _showEditDialog,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Hero Widget: السر وراء الانيميشن السلس
                    Hero(
                      tag: currentCollection.id,
                      child: Image.network(
                        currentCollection.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                      ),
                    ),
                    // طبقة تظليل خفيفة ليظهر النص والأزرار بوضوح
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. محتوى الصفحة
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والوصف
                    Text(
                      currentCollection.title,
                      style: GoogleFonts.dmSans(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      currentCollection.subtitle,
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        color: Colors.grey[500],
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // عنوان قسم المنتجات
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shoes (${shoes.length})",
                          style: GoogleFonts.dmSans(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.filter_list, size: 24.sp),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 3. شبكة المنتجات (Product Grid)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 40.h),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75, // نسبة الطول للعرض للكارت
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 24.h,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final shoe = shoes[index];
                    return _buildShoeItem(shoe);
                  },
                  childCount: shoes.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Components ---

  // زر زجاجي عائم
  Widget _buildGlassButton({required IconData icon, required VoidCallback onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: dart_ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // يحتاج import 'dart:ui' as dart_ui;
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 20.sp),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }

  // كارت الحذاء
  Widget _buildShoeItem(Map<String, dynamic> shoe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    shoe['img'],
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite_border, size: 16.sp),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          shoe['name'],
          style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 16.sp),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          shoe['price'],
          style: GoogleFonts.dmSans(color: Colors.grey[500], fontSize: 14.sp),
        ),
      ],
    );
  }

  // ديالوج التعديل
  void _showEditDialog() {
    final titleController = TextEditingController(text: currentCollection.title);
    final subtitleController = TextEditingController(text: currentCollection.subtitle);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ليظهر الكيبورد فوق الشيت
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 24, left: 24, right: 24
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Collection", style: GoogleFonts.dmSans(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                labelText: "Subtitle",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // تحديث البيانات محلياً
                    currentCollection = Collection(
                      id: currentCollection.id,
                      title: titleController.text,
                      subtitle: subtitleController.text,
                      imageUrl: currentCollection.imageUrl,
                    );
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("Save Changes", style: GoogleFonts.dmSans(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}